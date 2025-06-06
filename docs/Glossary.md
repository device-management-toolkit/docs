# Glossary
Device Management Toolkit related *Terminology, Technologies, and Acronyms*

[A](#a) | [B](#b) | [C](#c) | [D](#d) | [E](#e) | F | [G](#g) | H | [I](#i) | J | [K](#k) | L | [M](#m) | [N](#n) |[O](#n) | [P](#p) | Q | [R](#r) | S | T | [U](#u) |[V](#v) | [W](#w) | X | Y | Z

## A

**admin control mode (ACM):** A mode of provisioning Intel® AMT that requires a purchased provisioning certificate from a Certificate Authority (CA), the creation of a domain, and the creation of a profile in the Remote Provisioning Server (RPS) application. ACM achieves a higher level of trust than client control mode (CCM). This is the required mode for Keyboard, Video, Mouse (KVM) or Redirection without user consent. See also [CCM](#c) and [provisioning](#p).

**ACM Activation:** The act of loading a purchased certificate and associating it with an Device Management Toolkit profile.

**allowlist:** A list permitting access to a privilege, service, network, etc.

## B
**Basic Input/Output System (BIOS):** Firmware that performs hardware initialization and configuration upon startup. See [MEBX](#m). 

## C

**certificate (provisioning):** A digitally signed document used in the provisioning of an edge device featuring Intel® AMT. The Intel® AMT firmware is pre-loaded with Transport Layer Security (TLS) certificate thumbprints of different certificate vendors. A digital certificate binds the identity of the certificate holder to vendor-specific thumbprints. To provision an edge device, users must purchase a certificate from an approved vendor. 

**Client Initiated Remote Access (CIRA):** An out-of-band (OOB) management communication protocol that network clients can use to initiate a secure connection with a server. 

**Client Control Mode (CCM):** An alternative to ACM provisioning mode that does not require a purchased certificate. Use this mode to set up Device Management Toolkit software features quickly.

**Container (Docker*):** The instantiation, or running instance, of a Docker image.

## D

**Device Management Toolkit:** An open source software architecture consisting of modular microservices, applications and libraries for integration of out-of-band manageability into existing network infrastructures. The software enables network administrators and independent software vendors (ISVs) to explore key Intel® AMT features.

**development system:** The system on which Management Presence Server (MPS) and Remote Provision Server (RPS) are installed.

**Docker*:**  A platform that employs the idea of containerization, isolating a unit of software, such as an application, from its environment. Containerization creates applications as lightweight, discrete processes that can be deployed to the cloud as services. [See Docker for more information.](https://www.docker.com/) 

**Domain Name System (DNS) suffix:** A suffix appended to the hostname of a DNS name.

**domain suffix:** The top-level portion or end of a domain name (i.e., com, net, org).  

## E

**Edge Devices:**  A device or piece of hardware that serves as an entry point into an enterprise or service provider network. Edge devices include those related to banking, retail, hospitality, point-of-sale, etc. 

## G

**Globally Unique Identifier (GUID):** A 128-bit integer used to identify a system resource.

## I

**Intel® Active Management Technology (Intel® AMT):** A technology that provides out-of-band management and security features on an Intel vPro® Platform. [See general overview of features.](https://www.intel.com/content/www/us/en/architecture-and-technology/intel-active-management-technology.html)

**Intel vPro® Platform:** An Intel® platform created for business environments. Intel vPro® technology features Intel® Core™ i5, Intel® Core™ i7, and Intel® Core™ i9 vPro® processors, built-in security features, and out-of-band manageability using Intel® AMT.  [See more about the platform.](https://www.intel.com/content/www/us/en/architecture-and-technology/vpro/vpro-platform-general.html)

**Images (Docker*):**  a set of instructions that determine the creation of an instantiated container  on a Docker platform.

## K

**Keyboard, Video, Mouse (KVM):**  A technology, often a device, that allows a user to control multiple computers from a single keyboard, mouse, and video source.

## L

**lights-out management (LOM):** See [out-of-band management](#o). 

## M

**managed (edge) device:** An Intel vPro® Platform that features Intel® AMT and functions as an edge device.

**Manageability Engine BIOS Extensions (MEBX):** A BIOS extension that enables the configuration of the Intel® AMT.

**Management Presence Server (MPS):** A microservice that resides on the development system and enables platforms featuring featuring Intel® AMT. The MPS receives CIRA requests from the managed device. 

**microservice:** A software unit or module of a microservice architecture. In OAMTCT architecture, MPS and RPS are microservices residing on the development system. 

**microservice architecture:** An architecture in which the component parts are broken into discrete services, called microservices, that perform specific, limited functions. 

## N

**Node.js*:** An open source JavaScript* runtime created for asynchronous, event-driven backend network applications. [See more about node.js.](https://nodejs.org/en)

**Node Package Manager (npm):**  a command line utility in node.js. The utility enables the management of packages, versions, and dependencies in node projects. 

## O

**out-of-band (OOB) manageability:** A remote management technology that allows administrators to perform actions on network assets or devices using a secure alternative to LAN-based communication protocols. Actions include reboot, power up, power down, system updates, and more. As long as the network device or asset is connected to power, OAMTCT software can perform remote management, including powering up a system that is currently powered down. 

## P

**profile**:  A set of configuration information, including a password and provisioning method, provided to Intel® AMT firmware during the activation process. 

**provision or provisioning:** The act of setting up a remote client, system, or device, on a network using a digitally signed certificate as a security credential. 

## Q

## R

**Remote Provision Client (RPC):** A lightweight client application that resides on the managed device. The RPC communicates with the Manageability Engine Interface (MEI) in the Management Engine (ME) driver to activate Intel® AMT. 

**Remote Provision Server (RPS):** A node.js-based microservice that works with the Remote Provision Client (RPC) to activate Intel® AMT using a pre-defined profile.

**REpresentational State Transfer (REST) API**: An architectural style or set of rules describing constraints that allow administrators and developers to take advantage of various Web services. In the context of Device Management Toolkit, administrators can construct REST API calls and run them with node, use provided REST code snippets to expand the reference implementation console, and use provided REST code snippets as a springboard for developing and expanding custom consoles.



## S

**Sample Web UI:** A reference UI implementation serving as a demo vehicle and utilizing components of the UI toolkit.

## T

## U

**UI Toolkit:** A modular, REST-based API consisting of code snippets developers can use to implement AMT features and services to their manageability console. 

## V

**[vcpkg](https://github.com/microsoft/vcpkg):** A command-line application that helps manage package creation and C and C++ libraries on Windows*, Linux*, and MacOS*.

**[Vault storage](https://www.vaultproject.io/):** A service that manages encryption and storage of infrastructure secrets. 

## W

**WebSocket*:** A communication protocol that enables persistent connections and full-duplex communication between clients and servers.

**Web Service Management (WS-MAN):** A SOAP-based protocol for exchanging management data between network devices.

## X

## Y

## Z

