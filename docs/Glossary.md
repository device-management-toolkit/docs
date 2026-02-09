# Glossary
Device Management Toolkit related *Terminology, Technologies, and Acronyms*

[A](#a) | [B](#b) | [C](#c) | [D](#d) | [E](#e) | F | [G](#g) | H | [I](#i) | J | [K](#k) | L | [M](#m) | [N](#n) |[O](#n) | [P](#p) | Q | [R](#r) | S | T | [U](#u) |[V](#v) | [W](#w) | X | Y | Z

## A

**Admin Control Mode (ACM):** A mode of provisioning Intel® AMT that requires a purchased provisioning certificate from a Certificate Authority (CA), the creation of a domain, and the creation of a profile in the Remote Provisioning Server (RPS) application. ACM achieves a higher level of trust than client control mode (CCM). This is the required mode for Keyboard, Video, Mouse (KVM) or Redirection without user consent. See also [CCM](#c) and [provisioning](#p).

**ACM Activation:** The act of loading a purchased certificate and associating it with an Device Management Toolkit profile.

**Allowlist:** A list permitting access to a privilege, service, network, etc.

## B

**Basic Input/Output System (BIOS):** Firmware that performs hardware] initialization and configuration upon startup. See [MEBX](#m).

## C

**Certificate Authority (CA -or Certification Authority-):** It is an entity that stores, signs, and issues digital certificates. It is referred as a Certificate Vendor as well. The [Intel® AMT firmware](#i) is pre-loaded with Transport Layer Security (TLS) certificate thumbprints of different certificate vendors.

**Certificate (Provisioning):** A digitally signed document used in the provisioning of an edge device featuring Intel® AMT. The Intel® AMT firmware is pre-loaded with Transport Layer Security (TLS) certificate thumbprints of different certificate vendors. A digital certificate binds the identity of the certificate holder to vendor-specific thumbprints. To provision an edge device, users must purchase a certificate from an approved vendor.

**Client Initiated Remote Access (CIRA):** An out-of-band (OOB) management communication protocol that network clients can use to initiate a secure connection with a server.

**Client Control Mode (CCM):** An alternative to ACM provisioning mode that does not require a purchased certificate. Use this mode to set up Device Management Toolkit software features quickly.

**Console:** It is an application providing a 1:1, direct connection for Intel AMT devices for use in an enterprise environment. It supports multiple features such as power control, remote keyboard-video-mouse (KVM) control, and device monitoring. [See console project for more information.](https://github.com/device-management-toolkit/console)

**Container (Docker*):** The instantiation, or running instance, of a Docker image.

**Custom Certificate (Provisioning):** It is a custom certificate created by an ad-hoc Certificate Authority (i.e., untrusted) for development purposes only. It could be used to provision an edge device featuring Intel® AMT. However, they are not pre-loaded in the Intel® AMT firmware, so the user (or developer) needs to incorporate them manually (for example, using the USBFile utility of the [Intel AMT SDK](https://www.intel.com/content/www/us/en/download/704388/intel-active-management-technology-intel-amt-software-development-kit-sdk.html)). To provision an edge device, users must purchase a certificate from an approved vendor.

## D

**Device Management Toolkit:** An open source software architecture consisting of modular microservices, applications and libraries for integration of out-of-band manageability into existing network infrastructures. The software enables network administrators and independent software vendors (ISVs) to explore key Intel® AMT features.

**Development System:** The system on which Management Presence Server (MPS) and Remote Provision Server (RPS) are installed.

**Docker*:**  A platform that employs the idea of containerization, isolating a unit of software, such as an application, from its environment. Containerization creates applications as lightweight, discrete processes that can be deployed to the cloud as services. [See Docker for more information.](https://www.docker.com/)

**Domain Name System (DNS) Suffix:** A suffix appended to the hostname of a DNS name.

**Domain Suffix:** The top-level portion or end of a domain name (i.e., com, net, org).  

## E

**Edge Devices:**  A device or piece of hardware that serves as an entry point into an enterprise or service provider network. Edge devices include those related to banking, retail, hospitality, point-of-sale, etc.

## F

**Firmware:** It is software that controls how hardware devices function reliably and efficiently, allowing communication between them and other software pieces. It incorporates the logic to startup, control, manage, and turn on/off the different hardware components.

## G

**Globally Unique Identifier (GUID):** A 128-bit integer used to identify a system resource.

## H

**Hypertext Transfer Protocol Secure (HTTPS):** It is an extension of the HTTP protocol that encrypts communication over a network using Secure Socket Layer (SSL).

## I

**Intel® Active Management Technology (Intel® AMT):** A technology that provides out-of-band management and security features on an Intel vPro® Platform. [See general overview of features.](https://www.intel.com/content/www/us/en/architecture-and-technology/intel-active-management-technology.html)

**Intel® AMT firmware:** It is software associated with the Intel Management Engine responsible for providing Out-of-band manageability in an edge device.

**Intel® AMT Software Development Kit (Intel® AMT SDK):** It is a set of tools, utilities, building blocks, and components to help developers create software based on Intel AMT technology. [See general overview.](https://www.intel.com/content/www/us/en/download/704388/intel-active-management-technology-intel-amt-software-development-kit-sdk.html)

**Intel vPro® Platform:** An Intel® platform created for business environments. Intel vPro® technology features Intel® Core™ i5, Intel® Core™ i7, and Intel® Core™ i9 vPro® processors, built-in security features, and out-of-band manageability using Intel® AMT.  [See more about the platform.](https://www.intel.com/content/www/us/en/architecture-and-technology/vpro/vpro-platform-general.html)

**Images (Docker*):**  a set of instructions that determine the creation of an instantiated container  on a Docker platform.

## J

**JSON Web Token (JWT):**  It represents claims transferred between two parties in a compact, URL-safe means. They are encoded as a JSON object used as the payload of a JSON Web Signature (JWS) structure or as the plaintext of a JSON Web Encryption (JWE) structure. It enables to digitally the claims to be digitally signed or integrity-protected with a Message Authentication Code (MAC) and/or encrypted. [See more about JWT.](https://www.rfc-editor.org/info/rfc7519)

## K

**Keyboard, Video, Mouse (KVM):**  A technology, often a device, that allows a user to control multiple computers from a single keyboard, mouse, and video source.

## L

**Lights-Out Management (LOM):** See [out-of-band management](#o).

## M

**Managed (Edge) Device:** An Intel vPro® Platform that features Intel® AMT and functions as an edge device.

**Manageability Engine BIOS Extensions (MEBX):** A BIOS extension that enables the configuration of the Intel® AMT.

**Management Presence Server (MPS):** A microservice that resides on the development system and enables platforms featuring featuring Intel® AMT. The MPS receives CIRA requests from the managed device.

**Microservice:** A software unit or module of a microservice architecture. In OAMTCT architecture, MPS and RPS are microservices residing on the development system.

**Microservice Architecture:** An architecture in which the component parts are broken into discrete services, called microservices, that perform specific, limited functions.

## N

**Node.js:** An open source JavaScript runtime created for asynchronous, event-driven backend network applications. [See more about node.js.](https://nodejs.org/en)

**Node Package Manager (NPM):**  a command line utility in node.js. The utility enables the management of packages, versions, and dependencies in node projects.

## O

**Out-of-Band (OOB) Manageability:** A remote management technology that allows administrators to perform actions on network assets or devices using a secure alternative to LAN-based communication protocols. Actions include reboot, power up, power down, system updates, and more. As long as the network device or asset is connected to power, OAMTCT software can perform remote management, including powering up a system that is currently powered down. 

## P

**Profile**: A set of configuration information, including a password and provisioning method, provided to Intel® AMT firmware during the activation process.

**Provision (or Provisioning):** The act of setting up a remote client, system, or device, on a network using a digitally signed certificate as a security credential.

**Public Key Infrastructure (PKI) Provisioning Record:**: It describes the PKI DNS suffix, MEBX password, Hash algorithm, and public key, among other data used for device provisioning. [USBFile](#u) creates two types of provisioning records: 1) Reusable can be used more than once, and 2) non-reusable records are single-use. MEBX detects and marks the PKI records once used in the booting when corresponding.

## Q

**Query Agent Presence Capabilities of the Intel AMT:** It queries the presence of software agents running in Intel AMT Devices. The Agent Presence feature enables management console applications to configure Intel AMT devices to monitor for the presence of software agents such as Anti-Virus and Firewall applications running on the Intel AMT system platform. [See additional details.](https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/default.htm)

## R

**Remote Provision Client (RPC):** A lightweight client application that resides on the managed device. The RPC communicates with the Manageability Engine Interface (MEI) in the Management Engine (ME) driver to activate Intel® AMT. RPC-Go is a utility written in the Go language used for Intel AMT devices' activation, deactivation, maintenance, and monitoring. [See additional details.](https://github.com/device-management-toolkit/rpc-go)

**Remote Provision Server (RPS):** A node.js-based microservice that works with the Remote Provision Client (RPC) to activate Intel® AMT using a pre-defined profile.

**REpresentational State Transfer (REST) API**: An architectural style or set of rules describing constraints that allow administrators and developers to take advantage of various Web services. In the context of Device Management Toolkit, administrators can construct REST API calls and run them with node, use provided REST code snippets to expand the reference implementation console, and use provided REST code snippets as a springboard for developing and expanding custom consoles.

## S

**Sample Web UI:** A reference UI implementation serving as a demo vehicle and utilizing components of the UI toolkit.

**Serial over LAN (SOL):** It redirects a managed system's serial port input and output over a local area network (LAN). Thus, a user can remotely access and manage a serial-based system on the edge.

## T

**Transport Layer Security (TLS):** This protocol aims to establish encrypted communication sessions over an IP network between an application and a server.

## U

**UI Toolkit:** A modular, REST-based API consisting of code snippets developers can use to implement AMT features and services to their manageability console.

**USBFile:** It is a command line tool available in the [Intel® AMT SDK](https://www.intel.com/content/www/us/en/download/704388/intel-active-management-technology-intel-amt-software-development-kit-sdk.html) aims to create records and store them in a USB drive to prepare an Intel AMT device for provisioning. It is a replacement for entering settings manually via the MEBX menu.

## V

**[Vcpkg](https://github.com/microsoft/vcpkg):** A command-line application that helps manage package creation and C and C++ libraries on Windows*, Linux*, and MacOS*.

**[Vault storage](https://www.vaultproject.io/):** A service that manages encryption and storage of infrastructure secrets.

## W

**WebSocket:** A communication protocol that enables persistent connections and full-duplex communication between clients and servers.

**Web Service Management (WS-MAN):** A SOAP-based protocol for exchanging management data between network devices.

## X

**XML Localization Interchange File Format (XLIFF):** It is a vocabulary that aims to store localizable data and carry it from one step of the localization process to another while allowing tool interoperability. [See more details.](https://docs.oasis-open.org/xliff/xliff-core/v2.2/xliff-core-v2.2-part1.html)

## Y

**YAML (YAML Ain't Markup Language):** It is a human-friendly data serialization language for all programming languages.  It is commonly used for configuration files and applications where data is stored or transmitted. [See more details.](https://yaml.org/)

## Z

**ZooKeeper (a.k.a Apache ZooKeeper):** It is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and group services. [See more details.](https://zookeeper.apache.org/)
