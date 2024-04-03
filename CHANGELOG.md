# Changelog

## [2.2.0](https://github.com/Excoriate/terraform-registry-aws-networking/compare/v2.1.0...v2.2.0) (2024-04-03)


### Features

* Add AWS provider configuration and input variables ([#4](https://github.com/Excoriate/terraform-registry-aws-networking/issues/4)) ([47ac446](https://github.com/Excoriate/terraform-registry-aws-networking/commit/47ac44650d6e523f98d6df54e59fc924e6756274))
* Add new security group configurations ([#6](https://github.com/Excoriate/terraform-registry-aws-networking/issues/6)) ([59711e9](https://github.com/Excoriate/terraform-registry-aws-networking/commit/59711e9ccc8a2432240eb20abda7610accdf013a))
* Align code indentation in unit tests ([#2](https://github.com/Excoriate/terraform-registry-aws-networking/issues/2)) ([aacc3b4](https://github.com/Excoriate/terraform-registry-aws-networking/commit/aacc3b49e4126c1aed3e76b08b23f80f69d23c8b))
* Update AWS VPC and Security Group module README ([#8](https://github.com/Excoriate/terraform-registry-aws-networking/issues/8)) ([334573c](https://github.com/Excoriate/terraform-registry-aws-networking/commit/334573cbc331e32c9d33e445935c4b6b4847c8ba))
* Upgrade Go version to 1.22.1 and adjust module paths for unit and recipes tests. ([#5](https://github.com/Excoriate/terraform-registry-aws-networking/issues/5)) ([a409d8f](https://github.com/Excoriate/terraform-registry-aws-networking/commit/a409d8fd7a3d8d79c1544c916c70f043a6bb50bd))

## [2.1.0](https://github.com/Excoriate/terraform-registry-aws-networking/compare/v2.0.0...v2.1.0) (2023-05-23)


### Features

* add acm certificate module ([7b5e32c](https://github.com/Excoriate/terraform-registry-aws-networking/commit/7b5e32c58cf94f1af75bd6ce93331c207f7e2f08))
* add acm module with proper validation ([8c7538c](https://github.com/Excoriate/terraform-registry-aws-networking/commit/8c7538c7076fb5bfbbd05b344f354aab8b211dd8))
* add acm module with proper validation ([409ca2c](https://github.com/Excoriate/terraform-registry-aws-networking/commit/409ca2cc5281b94633a574b66a41ce0a9ccd091f))
* add alb listener module ([8ff374d](https://github.com/Excoriate/terraform-registry-aws-networking/commit/8ff374d8a0b216f8c3c103db91685da1be7b8cf7))
* add alb listener rule ooo rules ([a3071c6](https://github.com/Excoriate/terraform-registry-aws-networking/commit/a3071c6a21402f4f63e0cd74137eea5f3d982ff4))
* add alb module ([322c2de](https://github.com/Excoriate/terraform-registry-aws-networking/commit/322c2de9a6c826e20f6ddc77d285b19e041fae9a))
* add alb target group module ([be286e9](https://github.com/Excoriate/terraform-registry-aws-networking/commit/be286e9384096c89e620a13b3dcaf92a5d5a91d6))
* add attacher for a target group ([69a9f4a](https://github.com/Excoriate/terraform-registry-aws-networking/commit/69a9f4afd47cbf689a8fede492e352a9ee59c726))
* add built-in cname generation per alias record ([1be7e04](https://github.com/Excoriate/terraform-registry-aws-networking/commit/1be7e04f5de04058a60521d4d505c88765546f42))
* add dynamic conditions ([7410005](https://github.com/Excoriate/terraform-registry-aws-networking/commit/74100056de4db9f2c048833d72907fdbad86df5b))
* add extra conditions for the oo alb listener rule ([c65638d](https://github.com/Excoriate/terraform-registry-aws-networking/commit/c65638d05e52701413675df9e3da927ea3663d16))
* add forward rule support ([4ed04b1](https://github.com/Excoriate/terraform-registry-aws-networking/commit/4ed04b125c5673fef2382adb57fa7d61e667aca5))
* add hosted zone module ([fe58655](https://github.com/Excoriate/terraform-registry-aws-networking/commit/fe586555222f1e110db0407e48c0922af5cfc770))
* add lifecycle changes ([5780f46](https://github.com/Excoriate/terraform-registry-aws-networking/commit/5780f465b1d27f077044e95b3b4d4e2501bb7cd4))
* add lookup for az for private subnets ([9abc8eb](https://github.com/Excoriate/terraform-registry-aws-networking/commit/9abc8ebd53a4fcd2e37f4258ff7665d98bbd4d3d))
* add lookup-data module ([74aa76e](https://github.com/Excoriate/terraform-registry-aws-networking/commit/74aa76ecdb3a5f0b2e6fef4a1854d09c256374cd))
* add multiple rules ([10c9ad7](https://github.com/Excoriate/terraform-registry-aws-networking/commit/10c9ad71455a59ed43e281e7818b13f1268647ae))
* add new version of hosted zone module ([e92a81c](https://github.com/Excoriate/terraform-registry-aws-networking/commit/e92a81ca2da47abbc2e40ceaace8e0baecf02585))
* add non-tested route53 dns record module ([a090cfb](https://github.com/Excoriate/terraform-registry-aws-networking/commit/a090cfb402d69bffb3ca800b3a9c59634fc3e194))
* add ooo rules for custom ports ([8e389f2](https://github.com/Excoriate/terraform-registry-aws-networking/commit/8e389f24788fcb7005ec2b71f22618d3dfb97b93))
* add outputs, refactor the code ([2639e57](https://github.com/Excoriate/terraform-registry-aws-networking/commit/2639e5706a91e08553b1bd68683cfbba0805e548))
* add rules logic, for sg groups ([5b22f9d](https://github.com/Excoriate/terraform-registry-aws-networking/commit/5b22f9d91995ce34a66abe637ba41dfddd73aef2))
* add security group rules module ([e2d11ce](https://github.com/Excoriate/terraform-registry-aws-networking/commit/e2d11cebd5d40bf4585661cd373be24ba66f4789))
* add sg functionality for vpc lookup ([4692713](https://github.com/Excoriate/terraform-registry-aws-networking/commit/46927137ec8b0257a0723e22dd6665652654062f))
* add sg ooo rules ([9660c58](https://github.com/Excoriate/terraform-registry-aws-networking/commit/9660c58c5400661e1ce70db10a00f8f1a1e90296))
* add subnets by az capability to the networking lookup module ([b136639](https://github.com/Excoriate/terraform-registry-aws-networking/commit/b136639afa137acc407290b5b62e417bd063f08b))
* add support for ns records ([7977e6d](https://github.com/Excoriate/terraform-registry-aws-networking/commit/7977e6d2f5fd618766bed9fcc0f85b9fdb25c536))
* add tags to identify subnets ([03ee195](https://github.com/Excoriate/terraform-registry-aws-networking/commit/03ee195bfd0dbcc0b4e632b079372f164419f6a5))
* add test for multiple conditions ([d0ebea9](https://github.com/Excoriate/terraform-registry-aws-networking/commit/d0ebea9024b05336ad5e0c43260d5f4e8c9c09f5))
* add tested target-group module ([ade9c62](https://github.com/Excoriate/terraform-registry-aws-networking/commit/ade9c6209ae2efc1d11827d884175f0684147ef6))
* add zone and acm certificate capability ([6d7336d](https://github.com/Excoriate/terraform-registry-aws-networking/commit/6d7336d5e4a9fb8c08e5769d25fa0b97b761b09a))
* first commit ([382a9ba](https://github.com/Excoriate/terraform-registry-aws-networking/commit/382a9bab590e3d233c17de9d9f1c19f059e4976d))
* first commit ([2aecb80](https://github.com/Excoriate/terraform-registry-aws-networking/commit/2aecb808e6018715135621af998666e58a17c796))
* reduce ttl ([f5127c8](https://github.com/Excoriate/terraform-registry-aws-networking/commit/f5127c80ab08e7d68596eef627511aed815acf47))


### Bug Fixes

* add create before destroy fix in sg module ([dc461cc](https://github.com/Excoriate/terraform-registry-aws-networking/commit/dc461cc67251d370bcabe321c2aaab4e07aa438e))
* add target type to tg module ([a8021b7](https://github.com/Excoriate/terraform-registry-aws-networking/commit/a8021b75cc1b53cd442b88fab06e98dc7ec381f7))
* allow fallback to ns records of the standalone zone ([e721296](https://github.com/Excoriate/terraform-registry-aws-networking/commit/e7212965ecc59888e008703b2e978fc606f5739c))
* change key from zone to record name in stand alone ns functionality ([82eabc1](https://github.com/Excoriate/terraform-registry-aws-networking/commit/82eabc17780fe5b168a80c501e7a2263323a3067))
* ci add updated workflow for tagging ([39e85a6](https://github.com/Excoriate/terraform-registry-aws-networking/commit/39e85a63ff2b02885f97c4952b2fe45890571ea3))
* enabled flag was not passed to health-check config in tg ([03f3c0f](https://github.com/Excoriate/terraform-registry-aws-networking/commit/03f3c0fe165ae0ec578cd6983c891a7dd9b1740c))
* fix lookup by zone in dns-records module ([4f66a4f](https://github.com/Excoriate/terraform-registry-aws-networking/commit/4f66a4f4cabda4243ba2647667e0af7ad646c80c))
* fix lookup by zone in dns-records module ([2461c4a](https://github.com/Excoriate/terraform-registry-aws-networking/commit/2461c4a56c33d6f8150c9a13460e6f16b36f13a8))
* handle scenario for mixed configs in lookup ([7c2c78a](https://github.com/Excoriate/terraform-registry-aws-networking/commit/7c2c78aeb93c2a3c775c9a7a51bc4689dbf215e5))
* unique condition per action in ooo alb listener rules ([dfad711](https://github.com/Excoriate/terraform-registry-aws-networking/commit/dfad711072dcd2ca11f42eb60d33b52b412e965c))


### Docs

* add docs ([c29605f](https://github.com/Excoriate/terraform-registry-aws-networking/commit/c29605fc6007ba0eae4832a27e80016c3728efdd))


### Refactoring

* add extra outputs in alb module ([8a12dfa](https://github.com/Excoriate/terraform-registry-aws-networking/commit/8a12dfaa581ef0d9b55ee1080f51f8d6419b023f))


### Other

* add release-please config ([a7df285](https://github.com/Excoriate/terraform-registry-aws-networking/commit/a7df2856b5af9bbbe13861b3e49a11fbc8f7e7aa))
