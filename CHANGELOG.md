# Changelog

## [2.1.1](https://github.com/CloudNationHQ/terraform-azure-cog/compare/v2.1.0...v2.1.1) (2025-10-10)


### Bug Fixes

* type definitions ([#22](https://github.com/CloudNationHQ/terraform-azure-cog/issues/22)) ([012fabb](https://github.com/CloudNationHQ/terraform-azure-cog/commit/012fabbf90fd0f0ea1f128817e40490957c80868))

## [2.1.0](https://github.com/CloudNationHQ/terraform-azure-cog/compare/v2.0.0...v2.1.0) (2025-10-10)


### Features

* add property dynamic_throttling_enabled ([#20](https://github.com/CloudNationHQ/terraform-azure-cog/issues/20)) ([094ab6e](https://github.com/CloudNationHQ/terraform-azure-cog/commit/094ab6ee79f812ad244da20ad6b5a1c439227d88))


### Bug Fixes

* lint ([84f34c9](https://github.com/CloudNationHQ/terraform-azure-cog/commit/84f34c92d7d92917af51c79b9458558be7024baf))

## [2.0.0](https://github.com/CloudNationHQ/terraform-azure-cog/compare/v1.1.1...v2.0.0) (2025-05-08)


### ⚠ BREAKING CHANGES

* The data structure changed, causing a recreate on existing resources.

### Upgrade from v1.1.1 to v2.0.0:

- Update module reference to: `version = "~> 2.0"`
- The property and variable resource_group is renamed to resource_group_name

### Features

* small refactor ([#11](https://github.com/CloudNationHQ/terraform-azure-cog/issues/11)) ([ad8c3a9](https://github.com/CloudNationHQ/terraform-azure-cog/commit/ad8c3a94f69ad08f678a52aa7ff6ae25a7dd6eac))

## [1.1.1](https://github.com/CloudNationHQ/terraform-azure-cog/compare/v1.1.0...v1.1.1) (2025-04-15)


### Bug Fixes

* module references in usages ([#7](https://github.com/CloudNationHQ/terraform-azure-cog/issues/7)) ([f0ab1e7](https://github.com/CloudNationHQ/terraform-azure-cog/commit/f0ab1e7f375b59d15356fef8ad3da6d51fcf6fed))

## [1.1.0](https://github.com/CloudNationHQ/terraform-azure-cognitive/compare/v1.0.1...v1.1.0) (2025-04-15)


### Features

* add rai policy support and example configurations ([#5](https://github.com/CloudNationHQ/terraform-azure-cognitive/issues/5)) ([98745d6](https://github.com/CloudNationHQ/terraform-azure-cognitive/commit/98745d6a05ce6418e3f0933087354119649b5948))

## [1.0.1](https://github.com/CloudNationHQ/terraform-azure-cognitive/compare/v1.0.0...v1.0.1) (2025-04-14)


### Bug Fixes

* fix increment module version in usages ([#3](https://github.com/CloudNationHQ/terraform-azure-cognitive/issues/3)) ([ed8dea2](https://github.com/CloudNationHQ/terraform-azure-cognitive/commit/ed8dea2d1ba7d7878195909c48518f17316ad731))

## 1.0.0 (2025-04-14)


### Features

* add initial resources  ([#1](https://github.com/CloudNationHQ/terraform-azure-cognitive/issues/1)) ([9f5bf23](https://github.com/CloudNationHQ/terraform-azure-cognitive/commit/9f5bf2393e71ea68b146f450d77dc9503f482331))

## [2.5.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v2.4.0...v2.5.0) (2025-04-11)


### Features

* add type definitions ([#50](https://github.com/CloudNationHQ/terraform-azure-rg/issues/50)) ([b5a0a08](https://github.com/CloudNationHQ/terraform-azure-rg/commit/b5a0a08f5ba6ea9ca8d01e132d2b6c8a960c9f08))

## [2.4.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v2.3.0...v2.4.0) (2025-04-07)


### Features

* add managed by property ([#48](https://github.com/CloudNationHQ/terraform-azure-rg/issues/48)) ([46b6fa5](https://github.com/CloudNationHQ/terraform-azure-rg/commit/46b6fa5e2c9347138e4873fe85b7e0b401908547))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#46](https://github.com/CloudNationHQ/terraform-azure-rg/issues/46)) ([98501a5](https://github.com/CloudNationHQ/terraform-azure-rg/commit/98501a58b41ce1dbf5d100b27d29057470760402))
* **deps:** bump golang.org/x/net from 0.33.0 to 0.36.0 in /tests ([#47](https://github.com/CloudNationHQ/terraform-azure-rg/issues/47)) ([8c4bc9a](https://github.com/CloudNationHQ/terraform-azure-rg/commit/8c4bc9ae05e0f3f5eb934661063352a94177604c))

## [2.3.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v2.2.0...v2.3.0) (2025-01-21)


### Features

* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#40](https://github.com/CloudNationHQ/terraform-azure-rg/issues/40)) ([ca98179](https://github.com/CloudNationHQ/terraform-azure-rg/commit/ca98179d682a91e14519ac2a57ec44fff08bb1a1))
* **deps:** bump golang.org/x/crypto from 0.29.0 to 0.31.0 in /tests ([#43](https://github.com/CloudNationHQ/terraform-azure-rg/issues/43)) ([cf86bd4](https://github.com/CloudNationHQ/terraform-azure-rg/commit/cf86bd4d6cf368bb65d9d9bad80a865c8eae920e))
* **deps:** bump golang.org/x/net from 0.31.0 to 0.33.0 in /tests ([#44](https://github.com/CloudNationHQ/terraform-azure-rg/issues/44)) ([b9ad633](https://github.com/CloudNationHQ/terraform-azure-rg/commit/b9ad633ae8350a425c9393435d4fdcad3c0eba79))
* remove temporary files when deployment tests fails ([#41](https://github.com/CloudNationHQ/terraform-azure-rg/issues/41)) ([7b901ee](https://github.com/CloudNationHQ/terraform-azure-rg/commit/7b901ee457a45378a58431f18350181345492b15))

## [2.2.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v2.1.0...v2.2.0) (2024-11-11)


### Features

* enhance testing with sequential, parallel modes and flags for exceptions and skip-destroy ([#37](https://github.com/CloudNationHQ/terraform-azure-rg/issues/37)) ([e0ca443](https://github.com/CloudNationHQ/terraform-azure-rg/commit/e0ca443aa18afb0bd0f4cbe705badf3c50de901d))

## [2.1.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v2.0.0...v2.1.0) (2024-10-11)


### Features

* auto generated docs and refine makefile ([#35](https://github.com/CloudNationHQ/terraform-azure-rg/issues/35)) ([f13951b](https://github.com/CloudNationHQ/terraform-azure-rg/commit/f13951b5593b3f85e8856ff49114976a328457b7))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#34](https://github.com/CloudNationHQ/terraform-azure-rg/issues/34)) ([67a684b](https://github.com/CloudNationHQ/terraform-azure-rg/commit/67a684b4d4fe3048e83e62b4d1e0f6f1c491c2c6))

## [2.0.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v1.1.0...v2.0.0) (2024-09-24)


### ⚠ BREAKING CHANGES

* Version 4 of the azurerm provider includes breaking changes.

### Features

* upgrade azurerm provider to v4 ([#32](https://github.com/CloudNationHQ/terraform-azure-rg/issues/32)) ([ae4bedc](https://github.com/CloudNationHQ/terraform-azure-rg/commit/ae4bedce18c0da8bb97f4345ce1a156280e33f48))

### Upgrade from v1.1.0 to v2.0.0:

- Update module reference to: `version = "~> 2.0"`

## [1.1.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v1.0.0...v1.1.0) (2024-09-18)


### Features

* add type definitions and simplified tests ([#31](https://github.com/CloudNationHQ/terraform-azure-rg/issues/31)) ([88dcdb0](https://github.com/CloudNationHQ/terraform-azure-rg/commit/88dcdb0fe19752ccdcdc9116ff956444209cb929))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#28](https://github.com/CloudNationHQ/terraform-azure-rg/issues/28)) ([679a1d9](https://github.com/CloudNationHQ/terraform-azure-rg/commit/679a1d9b6cf658e81e6efaa90c66c440c7befa53))

## [1.0.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.9.0...v1.0.0) (2024-08-27)


#### ⚠ BREAKING CHANGES

* aligned properties

### Features

* merge output for newly created and existing groups ([#25](https://github.com/CloudNationHQ/terraform-azure-rg/issues/25)) ([4b488f5](https://github.com/CloudNationHQ/terraform-azure-rg/commit/4b488f5c723d532803b2c148da1dfeb40d927acb))

### Upgrade from v0.9.0 to v1.0

- Update module reference to: `version = "~> 1.0"`
- Rename variable:
   * region -> location
- Rename output variable:
   * groups_existing -> groups

## [0.9.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.8.0...v0.9.0) (2024-07-04)


### Features

* update contribution docs ([#23](https://github.com/CloudNationHQ/terraform-azure-rg/issues/23)) ([7b61ef7](https://github.com/CloudNationHQ/terraform-azure-rg/commit/7b61ef758147f84e3778162b8644767c794e8b7b))

## [0.8.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.7.1...v0.8.0) (2024-07-02)


### Features

* add issue template ([#22](https://github.com/CloudNationHQ/terraform-azure-rg/issues/22)) ([c370fe2](https://github.com/CloudNationHQ/terraform-azure-rg/commit/c370fe26d2cd0c50c20aab97c08fe89706189430))
* create pull request template ([#19](https://github.com/CloudNationHQ/terraform-azure-rg/issues/19)) ([bb14c2e](https://github.com/CloudNationHQ/terraform-azure-rg/commit/bb14c2e3d77d38c627085ef6edf8b1f146b3c7a2))

## [0.7.1](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.7.0...v0.7.1) (2024-04-17)


### Bug Fixes

* small correction output existing groups ([#17](https://github.com/CloudNationHQ/terraform-azure-rg/issues/17)) ([b6fb6cb](https://github.com/CloudNationHQ/terraform-azure-rg/commit/b6fb6cbe6338af0902aa9cbbf769438d9f77ea10))

## [0.7.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.6.0...v0.7.0) (2024-04-10)


### Features

* resource group handling now conditionally includes a global parameter for existing groups ([#15](https://github.com/CloudNationHQ/terraform-azure-rg/issues/15)) ([c8d2901](https://github.com/CloudNationHQ/terraform-azure-rg/commit/c8d29013388ead5a8cbf77e75ac8cb740166ce5e))

## [0.6.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.5.0...v0.6.0) (2024-03-22)


### Features

* small update documentation and added existing groups output ([#13](https://github.com/CloudNationHQ/terraform-azure-rg/issues/13)) ([23c9a8a](https://github.com/CloudNationHQ/terraform-azure-rg/commit/23c9a8a6989cf193ebab28defa6fee48a7dbae90))

## [0.5.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.4.1...v0.5.0) (2024-03-22)


### Features

* add support for existing groups ([#11](https://github.com/CloudNationHQ/terraform-azure-rg/issues/11)) ([1911630](https://github.com/CloudNationHQ/terraform-azure-rg/commit/1911630cd0c155dad29d53cf62493d4c0e33df7f))

## [0.4.1](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.4.0...v0.4.1) (2024-03-21)


### Bug Fixes

* fix expressional conditions location ([#9](https://github.com/CloudNationHQ/terraform-azure-rg/issues/9)) ([c1f6517](https://github.com/CloudNationHQ/terraform-azure-rg/commit/c1f65175ffa7b26c43a278b405cd420f4829f853))

## [0.4.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.3.0...v0.4.0) (2024-03-21)


### Features

* introduced the capability to utilize some global properties ([#7](https://github.com/CloudNationHQ/terraform-azure-rg/issues/7)) ([1a79181](https://github.com/CloudNationHQ/terraform-azure-rg/commit/1a791814f20aff1733adf0504b135b87b2488fd1))

## [0.3.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.2.0...v0.3.0) (2024-01-19)


### Features

* small refactor workflows ([#5](https://github.com/CloudNationHQ/terraform-azure-rg/issues/5)) ([a39df4f](https://github.com/CloudNationHQ/terraform-azure-rg/commit/a39df4f5406dc0244b04cab72a6a655e65f1f22d))

## [0.2.0](https://github.com/CloudNationHQ/terraform-azure-rg/compare/v0.1.0...v0.2.0) (2023-12-06)


### Features

* add optional tags support ([#3](https://github.com/CloudNationHQ/terraform-azure-rg/issues/3)) ([7ae05cc](https://github.com/CloudNationHQ/terraform-azure-rg/commit/7ae05cc10eaeb2f69266dd1c34f4579bd5d71bfa))

## 0.1.0 (2023-11-03)


### Features

* add initial resources ([#1](https://github.com/CloudNationHQ/terraform-azure-rg/issues/1)) ([0add3e1](https://github.com/CloudNationHQ/terraform-azure-rg/commit/0add3e146911040d12ff2915c17d882e6ed506cc))
