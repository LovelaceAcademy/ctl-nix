# this is basically purs-nix/purs-nix official generator
# but accepting arguments
pkgs:
let
  b = builtins;
  p = pkgs;
  l = p.lib;
  # TODO we should probably filter the universe of packages
  #  to only include the packages being used by CTL and its
  #  dependencies
  package-set = l.importJSON (./packages.json);
  package-set-entries = l.mapAttrsToList (n: v: { inherit n v; }) package-set;
  escape-reserved-word = ps-pkgs: str:
    let
      reserved-words = [ "assert" ];
    in
    if b.elem str reserved-words then
      if ps-pkgs then ''ps-pkgs."${str}"''
      else ''"${str}"''
    else
      str;
  package-set-str = b.foldl'
    (acc: { n, v }:
      let
        repo = b.fetchGit
          {
            url = v.repo;
            ref = "refs/tags/${v.version}";
            shallow = true;
          };
      in
      acc
      + ''
        ${escape-reserved-word false n} =
          { src.git =
              { repo = "${v.repo}";
                rev = "${repo.rev}";
              };
            info =
              { version = "${b.substring 1 (b.stringLength v.version) v.version}";
                dependencies =
                  [ ${b.foldl'
                        (acc: d: acc + escape-reserved-word true d + " ")
                        ""
                        v.dependencies
                    }
                  ];
              };
          };
      ''
    )
    ""
    package-set-entries;
in
p.writeText "" ''
  ps-pkgs:
    with ps-pkgs;
    { ${package-set-str} }
''

