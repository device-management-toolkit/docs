## Release Highlights

<div style="text-align:center;">
  <iframe width="800" height="450" src="https://www.youtube.com/embed/1yf0ZBafRdA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
<br>

!!! note "Note From the Team"
    Hey everyone,

    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

    Find out [what's new](#whats-new) and delve into the [details](#get-the-details) below-- and enjoy our new release of the toolkit.

    *Best wishes,*  
    *Team Member | Team Member's Title | The Device Management Toolkit Team*


## What's New?

:material-new-box:** Feature: New Feature Here**

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

:   **CODE COVERAGE NET RESULT:**  Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

:   **BOTTOM LINE:** Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

:material-star:** Customer Request: Request Here**

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


:material-new-box:** New Feature Here**

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


:material-auto-fix:** Import Fix Here **

Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## Get the Details

### Additions, Modifications, and Removals
#### Code Example
- Method property is removed from wsman header in response and is now a property of the wsman body

    before:
    ``` json
    "responses": {
        "Header": {
            "To": "http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous",
            "RelatesTo": "1",
            "Action": "http://schemas.xmlsoap.org/ws/2004/09/transfer/GetResponse",
            "MessageID": "uuid:00000000-8086-8086-8086-0000000000FA",
            "ResourceURI": "http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_ComputerSystemPackage",
            "Method": "CIM_ComputerSystemPackage"
        },
        "Body": {
            "Antecedent": {
    ```
    after:
    ``` json
    "responses": [
        {
            "Header": {
                "To": "http://schemas.xmlsoap.org/ws/2004/08/addressing/role/anonymous",
                "RelatesTo": 0,
                "Action": "http://schemas.xmlsoap.org/ws/2004/09/transfer/GetResponse",
                "MessageID": "uuid:00000000-8086-8086-8086-000000000002",
                "ResourceURI": "http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_ComputerSystemPackage"
            },
            "Body": {
                "CIM_ComputerSystemPackage": {
                    "Antecedent": {
    ```

- SelectorSet values no longer includes @name and Value properties

- While these technically constitute a breaking change, ultimately we decided to NOT rev the major version of the toolkit as we felt these changes have minimal impact. We will be revamping the /AMT routes in a future version and will rev to 3.x at that time
#### Device Management Toolkit

#### MPS

#### RPS

#### RPC-Go

#### Sample Web UI

#### UI Toolkit

### Resolved Issues
#### Device Management Toolkit

#### MPS

#### RPS

#### RPC-Go

#### Sample Web UI

#### UI Toolkit

### Open Issues and Requests
#### Device Management Toolkit

#### RPS

#### MPS

#### RPC

#### Sample Web UI

#### UI Toolkit



