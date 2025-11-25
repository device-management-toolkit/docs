--8<-- "References/abbreviations.md"

Middleware extensibility allows developers to implement new middleware handlers to both MPS or RPS. By adding custom functions, MPS and RPS will process and load these during server startup. The `loadCustomMiddleware` function that executes on startup can be found in `mps/src/server/webserver.ts` or `rps/src/index.ts`.

Example use-cases:

- Multitenancy
- Handling Custom Authentication Tokens
- Adding Trace IDs
- Debugging Requests

To demonstrate the execution, we'll use an example.  Let's say a custom auth token handler was implemented across all API endpoints.  When a call is then made against an API endpoint, the custom handler will execute first.  This handler might process the token.  After executing the custom function and calling `next()`, API execution will then continue as normal.

## Add a Custom Middleware Function

To add a new function, create a new typescript file in `/src/middleware/custom/`. An `example.ts` file is already provided in this directory.

The file **must have two key parts** in order to successfully load:

1. The desired function must be exported as a default. **Only the single, default function will be what is loaded into MPS or RPS.** Additional functions that need to be loaded will need their own separate `.ts` files.
2. Must call `next()`. This will allow execution to continue after processing the custom function.


### Multitenancy Code Example

Implementation might vary depending on cloud provider or other 3rd party solutions. This specific example implements against Microsoft Azure and the default Device Management Toolkit components. 

The following code might not be a final solution, but provides a starting point and template example.

The example implementation has a tenantId that is passed as part of the JWT token header when an API is called. The token is decoded and its tenantId is checked against the available tenants in MPS or RPS. This verifies that the user has the correct access to the MPS or RPS data being added, modified, or deleted.

!!! example "Multitenancy Example Code"
    ``` typescript
    import { Request, Response } from 'express'
    import { devices } from '../../server/mpsserver'
    import { Environment } from '../../utils/Environment'

      const tenantMiddleware = (req: Request, res: Response, next): void => {
      const jwtTokenHeader = Environment.Config.jwt_token_header ??     'x-id-token'
      const token = req.headers[jwtTokenHeader]
      req.tenantId = ''
      if (token != null && token !== '') {
        try {
          const decodedToken = Buffer.from(token as string, 'base64').  toString  ()
          if (decodedToken != null && decodedToken !== '') {
            const dt = JSON.parse(decodedToken)
            const tenantProp = Environment.Config.jwt_tenant_property ?? ''
            req.tenantId = dt[tenantProp] ?? ''
          }
        } catch (err) {
          console.error(err)
        }
      }
      next()
    }

    export default tenantMiddleware
    ```

After implementing the multitenancy code changes and starting the services, profiles and configs can be created by providing a `tenantID` as part of the [API calls](../APIs/indexRPS.md).

Then when activating and configuring the AMT device using RPC, provide the `-tenant` flag with the `tenantID` of the profile. [Find all RPC flags in the RPC CLI docs](./RPC/v2/commandsRPC.md).  See example command below.

```
rpc activate -u wss://server/activate -n -profile profilename -tenant profileTenantID
```

<br>