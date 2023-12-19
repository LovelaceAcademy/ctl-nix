# Changelog

## [4.0.0](https://github.com/LovelaceAcademy/ctl-nix/compare/v3.0.0...v4.0.0) (2023-12-19)


### ⚠ BREAKING CHANGES

* see CTL develop (v7.0.0) for breaking changes

### deps

* upgrade to CTL develop (v7.0.0) ([6aa9478](https://github.com/LovelaceAcademy/ctl-nix/commit/6aa9478481e6bb0c0524528a94f19dbbf9b321e8))

## [3.0.0](https://github.com/LovelaceAcademy/ctl-nix/compare/v2.1.2...v3.0.0) (2023-03-14)


### ⚠ BREAKING CHANGES

* **deps:** see CTL upstream for breaking changes

### Features

* **deps:** Bump CTL to v5.0.0 ([1b9d55f](https://github.com/LovelaceAcademy/ctl-nix/commit/1b9d55f6a9bae6d778f7155314740385fab70dc2))

## [2.1.2](https://github.com/LovelaceAcademy/ctl-nix/compare/v2.1.1...v2.1.2) (2023-02-25)


### Bug Fixes

* missing node_modules on purs-nix compile ([1e2348e](https://github.com/LovelaceAcademy/ctl-nix/commit/1e2348e4570f0c26e9c41a35555f3ac81a848cf7))

## [2.1.1](https://github.com/LovelaceAcademy/ctl-nix/compare/v2.1.0...v2.1.1) (2023-02-16)


### Bug Fixes

* add purs-nix/purs-nix[#44](https://github.com/LovelaceAcademy/ctl-nix/issues/44) patch to allow node_modules import ([d618e37](https://github.com/LovelaceAcademy/ctl-nix/commit/d618e375f8ca628eb21c0a5d9fefd9ea1eb46338))
* conflicting FFI deps ([ade8175](https://github.com/LovelaceAcademy/ctl-nix/commit/ade81757fc466316e7897f4917972cb059b876ae))
* incorrect version error ([1bc5234](https://github.com/LovelaceAcademy/ctl-nix/commit/1bc52345287f0c4ea2fcc39ee020f12761ae46c3))

## [2.1.0](https://github.com/LovelaceAcademy/ctl-nix/compare/v2.0.1...v2.1.0) (2023-01-31)


### Features

* add aeson as a internal flake packag ([03634d7](https://github.com/LovelaceAcademy/ctl-nix/commit/03634d751527df4f552843005f2225a2aa9967b9))
* add purs-nix and nixpkgs inputs following ps-0.14 ([e4a7552](https://github.com/LovelaceAcademy/ctl-nix/commit/e4a75526bb283d41b532a1e3d78da8e11e6894ee))


### Bug Fixes

* add bignumber missing version ([c372bec](https://github.com/LovelaceAcademy/ctl-nix/commit/c372bec58d3db557c444f0052492ed987a79462b))
* add missing bigints FFI ([9c51c2a](https://github.com/LovelaceAcademy/ctl-nix/commit/9c51c2af22bdf2b29197ca09852e46012687f8b9))
* incorrect bigints repo ([13ebc22](https://github.com/LovelaceAcademy/ctl-nix/commit/13ebc220efca5e0d2367dd1c23f42c9081021823))
* incorrect pkg name ([2dbc657](https://github.com/LovelaceAcademy/ctl-nix/commit/2dbc657dba2fc180a92743ea3a77d761bc0800b3))
* incorrect var name ([9409f35](https://github.com/LovelaceAcademy/ctl-nix/commit/9409f357d942668ba0e04f9b6d96bd0d73d4cf13))
* missing aeson ffi ([e770d4e](https://github.com/LovelaceAcademy/ctl-nix/commit/e770d4edb30896ecec1a04d8225c452861024802))
* missing ffi ([974c4cd](https://github.com/LovelaceAcademy/ctl-nix/commit/974c4cde2676bdb45b23047886d001cb6a634532))
* missing node_modules on ffi folders ([5b94fbb](https://github.com/LovelaceAcademy/ctl-nix/commit/5b94fbbcf2331132f32e59073a1751184de12063))

## [2.0.1](https://github.com/LovelaceAcademy/ctl-nix/compare/v2.0.0...v2.0.1) (2023-01-28)


### Bug Fixes

* missing FFI deps after upgrade to v4.0.2 ([0f68a6b](https://github.com/LovelaceAcademy/ctl-nix/commit/0f68a6b174a54b52a1e6623cdb99c88a5d43e44b))
* re-add toppokki ref ([fa42e4f](https://github.com/LovelaceAcademy/ctl-nix/commit/fa42e4f006adb30c0b05d1e3d65fc822643e98cc))

## [2.0.0](https://github.com/LovelaceAcademy/ctl-nix/compare/v1.0.0...v2.0.0) (2023-01-27)


### ⚠ BREAKING CHANGES

* **deps:** see CTL upstream for breaking changes

### Features

* **deps:** Bump CTL to v4.0.2 ([03e70e1](https://github.com/LovelaceAcademy/ctl-nix/commit/03e70e14e566676393f83007a4f1d9017288555c))

## 1.0.0 (2023-01-03)


### Features

* add built package-set matching package-set-repo rev ([7135fe7](https://github.com/LovelaceAcademy/ctl-nix/commit/7135fe76227f133de006b5e39b6de070168ef95c))
* add cardano-transaction-lib and fix aeson-helpers ([82ba168](https://github.com/LovelaceAcademy/ctl-nix/commit/82ba1689d5506808e762ac35eeceee7c602ae7f8))
* add cardano-transaction-lib deps ([ecad26d](https://github.com/LovelaceAcademy/ctl-nix/commit/ecad26d56fcec5227899d4968622d67dc24275f2))
* add overlay and template ([5c08d71](https://github.com/LovelaceAcademy/ctl-nix/commit/5c08d71f7f881c66ad803bcc90150be8379a4046))
* add package-set generator ([c474a6c](https://github.com/LovelaceAcademy/ctl-nix/commit/c474a6cc6a86ead2269778f64285ac3f932516a1))
* add package-set overlay using generated file ([f706728](https://github.com/LovelaceAcademy/ctl-nix/commit/f706728aca0d1f023c9ed93881faddb4cb7c7878))
* add template aeson example ([da3e905](https://github.com/LovelaceAcademy/ctl-nix/commit/da3e90593a2a75522b4305aebe2c0f969b4a6eca))
* compose overlays ([4689b11](https://github.com/LovelaceAcademy/ctl-nix/commit/4689b11b5b0ba33b06da598975a850e982bae979))
* remove unused inputs ([0f566af](https://github.com/LovelaceAcademy/ctl-nix/commit/0f566aff681827b5eb5d1225f377d8b3cc3f1590))
* **template:** add ctl dep ([d040a05](https://github.com/LovelaceAcademy/ctl-nix/commit/d040a0555e04c6b1578cfd7a828c94cd57ee3e88))
* **template:** change the deps ([f4c4291](https://github.com/LovelaceAcademy/ctl-nix/commit/f4c42915d196c7455380787de31ab7d4abd4e5bf))
* **template:** move the template to LovelaceAcademy/nix-templates[#14](https://github.com/LovelaceAcademy/ctl-nix/issues/14) ([120c081](https://github.com/LovelaceAcademy/ctl-nix/commit/120c0815771c0ef14fa3b7b57d221956be48b534))


### Bug Fixes

* incompatible systems with purs-nix and purs with ctl ([bdda675](https://github.com/LovelaceAcademy/ctl-nix/commit/bdda6751eea4f13b63922c38f989a227f14ef85d))
* missing package-set fetch ([cd66157](https://github.com/LovelaceAcademy/ctl-nix/commit/cd661573454531d3e228cc4c1efbb8d54e004297))
* remove missing template ([bcb34af](https://github.com/LovelaceAcademy/ctl-nix/commit/bcb34afe6234795c24513a31b4f1d68453e7d5c8))
* remove test check from ctl-nix ([c5f5809](https://github.com/LovelaceAcademy/ctl-nix/commit/c5f58099904d489ed366037d3e87d5e98c93ed23))
* rename la-ctl to ctl-nix ([bc24ec8](https://github.com/LovelaceAcademy/ctl-nix/commit/bc24ec8be7d035d027a69ba35077e021a77c0c46))
* template incorrect overlays ([d0da8fd](https://github.com/LovelaceAcademy/ctl-nix/commit/d0da8fdd4c25708964153396a300772cc842985b))
