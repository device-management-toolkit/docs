--8<-- "References/abbreviations.md"

## The wait is over – Console v1.0 is officially released!

We’re excited to announce the official release of Device Management Toolkit: Console v1.0! Download the latest v1.x release to access the most stable version and stay tuned for further improvements.

Console is an open-source management application that enables IT administrators to manage Intel® AMT devices within on-premises environments (or private networks). It provides direct access to activated AMT devices, enabling functions such as power control, remote keyboard-video-mouse (KVM), hardware inventory, and more.

Download the latest v1.x release:  [Console Releases](https://github.com/device-management-toolkit/console/releases)

## Getting Started with Console  

🔹 **First time using Console?** Get started with our [overview guide](./Reference/Console/overview.md) to learn key concepts and basic usage.  
🔹 **Upgrading from Beta?** Follow our [upgrade guide](./Reference/Console/upgrade.md#steps-to-upgrade-from-beta-to-v1x) to setup the latest version.  

## What's new?

:material-new-box: **Feature: Export AMT Audit and Event logs**

Administrators can now export AMT audit and event logs in CSV format, enabling easier compliance reporting, troubleshooting, and security analysis.
<br>

:material-new-box: **Feature: Select domain to profile export**

Profile management now includes the ability to select specific domains during profile exports, enabling better management in multi-domain environments.
<br>

:material-update: **Quality of Life Updates**

We've made several improvements, including UI enhancements, updates to the CI/CD pipeline, and fixes for minor bugs. These changes aim to improve the user experience with better navigation, while also optimizing the development and deployment processes.
<br>

## Updates to Other component 

:material-new-box: **Feature: CCM activation on new platforms**

Using the latest rpc-go, users can now activate newer platforms (AMT 19 and 20) in Client Control Mode (CCM), extending management capabilities to the latest Intel hardware.
<br>

:material-update: **Bug Fixes and Maintenance**

We've fixed issues in RPS (CIRA connections), MPS (KVM detection), Sample-Web-UI (fullscreen KVM, event logs), and updated all components with the latest security patches and dependency updates.
<br>

!!! note "Note From the Team"
    
    We’re thrilled to launch Console and remain committed to enhancing Console with new features and improvements. Up next: One-Click Recovery (OCR) support in Console, enabling OAuth 2.0/OIDC authentication in Console with customers' existing deployment, followed by updates for the transition from Open AMT Cloud Toolkit to the Device Management Toolkit, including reference renaming and documentation revisions.
    
    You can follow the progress of Console and everything else in our [Feature Backlog](https://github.com/orgs/device-management-toolkit/projects/10/views/2).
    
    *Best Wishes,* 

    *The Device Management Toolkit Team*


## Get the Details

### Additions, Modifications, and Removals

#### Console

v1.2.1

* allows pulling language file ([f954c09](https://github.com/device-management-toolkit/console/commit/f954c09f584d69ac059fcd08990be89faf39eea5))

v1.2.0

* allow insecure ciphers to be used ([c85dca1](https://github.com/device-management-toolkit/console/commit/c85dca10dbc2d6ed3fdd39ad3978cae7a9b40e0e)), closes [device-management-toolkit/go-wsman-messages#492](https://github.com/device-management-toolkit/go-wsman-messages/issues/492) [#445](https://github.com/device-management-toolkit/console/issues/445)

v1.1.0

* update API to enable/disable OCR status ([#514](https://github.com/device-management-toolkit/console/issues/514)) ([eac32d2](https://github.com/device-management-toolkit/console/commit/eac32d2716ecb4c2bbd28f97608f822dce24ec05))

v1.0.3

* add NGX_MONACO_EDITOR_CONFIG provider to ExplorerComponent ([#505](https://github.com/device-management-toolkit/console/issues/505)) ([c36de28](https://github.com/device-management-toolkit/console/commit/c36de28bc4c59a18accfed7083545afc6acf286b))

v1.0.2

* set env var for version in ci ([47154c2](https://github.com/device-management-toolkit/console/commit/47154c2555f95bdb32dbab45baba18e77707f849))

v1.0.1

* adjust ci to set version in correct file ([faf6256](https://github.com/device-management-toolkit/console/commit/faf62566d45b7999390c1660e880a18e798d3a58))

v1.0.0

* icons now showing correctly ([0a075e7](https://github.com/device-management-toolkit/console/commit/0a075e79f781e06843225fdf80d33ac2e55eefa7))

v1.0.0-beta.4

* adds specific domain to profile export ([#483](https://github.com/device-management-toolkit/console/issues/483)) ([693297f](https://github.com/device-management-toolkit/console/commit/693297fd2604a083b55fabf262553df6b6a02f99))
* align event log return type to use similar naming for audit log ([40b52e1](https://github.com/device-management-toolkit/console/commit/40b52e1f7f02d0f87861f1bee1c12109f65c81bf))
* event log fetch uses pagination ([#486](https://github.com/device-management-toolkit/console/issues/486)) ([f29bee2](https://github.com/device-management-toolkit/console/commit/f29bee218ee666a2afc3ee597901b655e8e93168))
* reads db url from config if not in env ([#478](https://github.com/device-management-toolkit/console/issues/478)) ([db5b059](https://github.com/device-management-toolkit/console/commit/db5b0596a8e0f9647040d283061c3d48f0291e05))
* feat!: enable oidc verification ([a60b122](https://github.com/device-management-toolkit/console/commit/a60b122037257ed7815da84dccab3ba72888c2dc))
* adds an api to download audit/event logs ([f916a2a](https://github.com/device-management-toolkit/console/commit/f916a2a37c92a00a004fe83800c34b37a49b6c05))
* moves JWT configuration to a new "auth" section in the config.yml along. View config.go for complete example.

v1.0.0-beta.3

* attempts to fix cicd CGO requirement ([2ad99e9](https://github.com/device-management-toolkit/console/commit/2ad99e9de474276b745e5d480b807503e394bdab))

#### RPC-Go

v2.43.1

* license generation ([#777](https://github.com/device-management-toolkit/rpc-go/issues/777)) ([5b914fa](https://github.com/device-management-toolkit/rpc-go/commit/5b914faf758be6d20e5bd65e55511b95b6c08caf))
* license generation ([#778](https://github.com/device-management-toolkit/rpc-go/issues/778)) ([8ba6993](https://github.com/device-management-toolkit/rpc-go/commit/8ba6993074b9629b55c845f6cd05204a9e078ce9))
* update go mod ([8a1e741](https://github.com/device-management-toolkit/rpc-go/commit/8a1e7419f905abb6520a1898a2a6e5abbb8aab8a))


v2.43.0

* ccm on tls only platforms ([#745](https://github.com/device-management-toolkit/rpc-go/issues/745)) ([80853ee](https://github.com/device-management-toolkit/rpc-go/commit/80853ee033e4370590e929ba2b6bd80cf092c6f0))

v2.42.8

* test ci ([8c5b3dd](https://github.com/device-management-toolkit/rpc-go/commit/8c5b3ddec5b3c8678fba93475675081aee99d8bb))
* test ci ([db52045](https://github.com/device-management-toolkit/rpc-go/commit/db52045bc8c7de7f9c7496d88edeca5ec4491ee0))

v2.42.7

* Use OS DNS suffix when DNS suffix set in MEBx is empty-like ([e89fd98](https://github.com/device-management-toolkit/rpc-go/commit/e89fd984915f998d5dd824bea04d84999b27a847))

v2.42.6

* opstate on amt 11 and below ([954f3d3](https://github.com/device-management-toolkit/rpc-go/commit/954f3d36bdd2fa076293536758772c492034aeba))

#### RPS

v2.23.0

* **docker:** add support for devcontainer ([#2025](https://github.com/device-management-toolkit/rps/issues/2025)) ([9cb7249](https://github.com/device-management-toolkit/rps/commit/9cb724929b782657627625cca5f0ab976f2cac35))


v2.22.15

* cira disconnect ([#1910](https://github.com/device-management-toolkit/rps/issues/1910)) ([fe86a7a](https://github.com/device-management-toolkit/rps/commit/fe86a7a58720e3453939919a19556fa552e1b9d6))

#### MPS

v2.14.1

* dependency updates

v2.14.0

* **docker:** update devcontainer.json format with prettier ([eb30af8](https://github.com/device-management-toolkit/mps/commit/eb30af898faec07369f5f1302bc16999aba2ca25))
* **docker:** add support for devcontainer (device-management-toolkit/cloud-deployment[#383](https://github.com/device-management-toolkit/mps/issues/383)) ([c91726c](https://github.com/device-management-toolkit/mps/commit/c91726c428a0d58a7be300c12b615b6aed0e3b75))

v2.13.22

* **api:** add kvmAvailable to get AMT features ([#1803](https://github.com/device-management-toolkit/mps/issues/1803)) ([c6596cc](https://github.com/device-management-toolkit/mps/commit/c6596ccfbdc213ad6467e1ae41063f418a6bd0ac))

#### Sample Web UI

v3.34.2

* address an issue where login token might not exist ([95d60b3](https://github.com/device-management-toolkit/sample-web-ui/commit/95d60b3509c756b27693a84bf844244d49b91599))

v3.34.0

* **docker:** add support for devcontainer ([#2534](https://github.com/device-management-toolkit/sample-web-ui/issues/2534)) ([bb597f4](https://github.com/device-management-toolkit/sample-web-ui/commit/bb597f4343b47d33d2659390390c6612e0f714e9))


v3.33.0

* replace momentjs with date fns ([2074d0e](https://github.com/device-management-toolkit/sample-web-ui/commit/2074d0e7d18dbf689f18788057acc234b790f2ed)), closes [device-management-toolkit#2519](https://github.com/device-management-toolkit/issues/2519)

v3.32.2

* Error messages truncated ([9b309ef](https://github.com/device-management-toolkit/sample-web-ui/commit/9b309ef67fb1b288d07cf53b17ed5acf100cd8f2)), closes [#2527](https://github.com/device-management-toolkit/sample-web-ui/issues/2527)

v3.32.1

* profile error messages truncated ([e8c3c25](https://github.com/device-management-toolkit/sample-web-ui/commit/e8c3c25da4759c93a58a0985842c3964da220a5e)), closes [#2486](https://github.com/device-management-toolkit/sample-web-ui/issues/2486)

v3.32.0

* **docker:** enable multiarch build ([4c10c0b](https://github.com/device-management-toolkit/sample-web-ui/commit/4c10c0bf45e8b4c64497e8e0d911d2e91a65e6f1))

v3.31.3

* dependency updates

v3.31.2

* add NGX_MONACO_EDITOR_CONFIG provider to ExplorerComponent ([063b087](https://github.com/device-management-toolkit/sample-web-ui/commit/063b0876fc02727dfbe7e0ce721d72a7e118110f))

v3.31.1

* disable kvm for ISM systems ([#2471](https://github.com/device-management-toolkit/sample-web-ui/issues/2471)) ([1ff7f56](https://github.com/device-management-toolkit/sample-web-ui/commit/1ff7f566737225dd782cc156617b960767d848d6))

v3.31.0

* enable support oauth 2.0 w/ PKCE ([3e47698](https://github.com/device-management-toolkit/sample-web-ui/commit/3e476984f355a34eac455887987a7fe2e3b23712))

v3.30.2

* add pagination for event logs ([#2456](https://github.com/device-management-toolkit/sample-web-ui/issues/2456)) ([fa63cbe](https://github.com/device-management-toolkit/sample-web-ui/commit/fa63cbe8d35b7a77fe8250f7d6870da4194377d5))

v3.30.1

* adds an option to select domain before profile export ([#2425](https://github.com/device-management-toolkit/sample-web-ui/issues/2425)) ([e80b424](https://github.com/device-management-toolkit/sample-web-ui/commit/e80b42460848bd44745ba46eb02d20cf53bd9cda))

v3.30.0

* enable KVM fullscreen mode ([#2418](https://github.com/device-management-toolkit/sample-web-ui/issues/2418)) ([df4c40c](https://github.com/device-management-toolkit/sample-web-ui/commit/df4c40c67657bc6336032f49379e652ea65c9e4a))

v3.29.0

* enable download for audit/event logs ([#2408](https://github.com/device-management-toolkit/sample-web-ui/issues/2408)) ([cf322b6](https://github.com/device-management-toolkit/sample-web-ui/commit/cf322b6261b87665ab055e6296fbfa0932679eb5))

v3.28.0

* make connection modes clearer ([0858fdf](https://github.com/device-management-toolkit/sample-web-ui/commit/0858fdf85119a614cce283cc6dbaef344fa0eac3))

v3.27.5

* update power button for hard reset ([93899a3](https://github.com/device-management-toolkit/sample-web-ui/commit/93899a3b21f11345d50c0fed522fe1f1e728940d))

#### Go WSMAN Messages

v2.21.0

* allow the use of insecure cipher suits ([#492](https://github.com/device-management-toolkit/go-wsman-messages/issues/492)) ([871493c](https://github.com/device-management-toolkit/go-wsman-messages/commit/871493cd355557be2b291a60b678ca6dcc06c3d1)), closes [device-management-toolkit/console#445](https://github.com/device-management-toolkit/console/issues/445)

v2.20.2

* adds missing selectors to policy applies to mps ([#497](https://github.com/device-management-toolkit/go-wsman-messages/issues/497)) ([f7fe59e](https://github.com/device-management-toolkit/go-wsman-messages/commit/f7fe59eae3ef2708b42ac1182508e976e0a48e0a))

v2.20.1

* support multiple selectors in header ([#495](https://github.com/device-management-toolkit/go-wsman-messages/issues/495)) ([b660ba5](https://github.com/device-management-toolkit/go-wsman-messages/commit/b660ba583ea090112ad03b9f26369da4c1c1e022))

v2.20.0

* **ips:** add RequestOSPowerSavingStateChange, Get, Pull, & Enumerate ([#491](https://github.com/device-management-toolkit/go-wsman-messages/issues/491)) ([ca76aad](https://github.com/device-management-toolkit/go-wsman-messages/commit/ca76aad6613a01f6244915f6b2db996dd1c8313c))

v2.19.0

* **cim:** add RequestStateChange in BootService ([#486](https://github.com/device-management-toolkit/go-wsman-messages/issues/486)) ([2d76f2d](https://github.com/device-management-toolkit/go-wsman-messages/commit/2d76f2d16cdb56560ecd875f27834abcfa929d71))

v2.18.0

* add TLS config support for newer platforms ([#481](https://github.com/device-management-toolkit/go-wsman-messages/issues/481)) ([b7cafca](https://github.com/device-management-toolkit/go-wsman-messages/commit/b7cafca78ecc3813a3a6d0e4470098dd6fc8c081))

v2.17.1

* identifier and maxReadRecords are configurable for event logs ([#478](https://github.com/device-management-toolkit/go-wsman-messages/issues/478)) ([5529d29](https://github.com/device-management-toolkit/go-wsman-messages/commit/5529d2947d5679fbfbf309720230018d7750f2b4))

#### UI Toolkit React

v4.0.0

* build(deps)!: upgrade to react 19 (#1608) ([cd061f3](https://github.com/device-management-toolkit/ui-toolkit-react/commit/cd061f3e0cdcfbfcb4eaefa4420c8deeaac564cf)), closes [#1608](https://github.com/device-management-toolkit/ui-toolkit-react/issues/1608)

#### UI Toolkit Angular

v9.1.2 and v9.1.1

* dependency updates

v9.1.0

* allow KVM fullscreen ([607a9c1](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/607a9c18a937a465966f9c5b915b63d697332844))

v9.0.0

* update build tasks, package.json and changelog ([#1668](https://github.com/device-management-toolkit/ui-toolkit-angular/issues/1668)) ([17294a2](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/17294a28b6e5eff874dfef7cc9c7edf67fc3195a))
* chore!: address incorrectly released breaking change ([b3a5414](https://github.com/device-management-toolkit/ui-toolkit-angular/commit/b3a541477b4c71795ff0754f501df3f59b61a4a1))
* move to angular 19 - build(deps): bump angular 18 to 19

#### UI Toolkit

v3.3.1

* dependency updates

v3.3.0

* allow resetting mouse offset ([17703e4](https://github.com/device-management-toolkit/ui-toolkit/commit/17703e46eec76d05cbe44b325480071b5b2c85fb))

#### WSMAN Messages

v5.9.0

* **ips:** add PowerManagementService interface in models ([#972](https://github.com/device-management-toolkit/wsman-messages/issues/972)) ([cd30da3](https://github.com/device-management-toolkit/wsman-messages/commit/cd30da3648a534b77f3d9625814d724edfd019d2))

v5.8.0

* **ips:** add RequestOSPowerSavingStateChange in PowerManagementService ([#967](https://github.com/device-management-toolkit/wsman-messages/issues/967)) ([82ea2ec](https://github.com/device-management-toolkit/wsman-messages/commit/82ea2ec1810cec22dcabaeac9ce0a696a94d65fa))

v5.7.0

* **cim:** add RequestStateChange in BootService ([#960](https://github.com/device-management-toolkit/wsman-messages/issues/960)) ([e4da726](https://github.com/device-management-toolkit/wsman-messages/commit/e4da726697b694b4787978848a9371e4a510070a))

## Project Boards

Check out our new [Sprint Planning](https://github.com/orgs/device-management-toolkit/projects/10/views/2) project board to see what stories the dev team is actively working on, what is in our backlog, and what is planned for the next sprint.
