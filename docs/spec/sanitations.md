_Author_:  <!-- TODO: Add author name --> \
_Created_: <!-- TODO: Add date --> \
_Updated_: <!-- TODO: Add date --> \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from HubSpot CRM Commerce Taxes. 
<<<<<<< HEAD
The OpenAPI specification is obtained from [Taxes OpenAPI](https://github.com/HubSpot/HubSpot-public-api-spec-collection/blob/main/PublicApiSpecs/CRM/Taxes/Rollouts/424/v3/taxes.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. `date-time` type mentioned in `discounts.json` was changed to `datetime`.
2. Change the url property of the servers object:

    * Original: `https://api.hubapi.com`
    * Updated: `https://api.hubapi.com/crm/v3/objects/taxes`
    * Reason: This change is made to ensure that    all API paths are relative to the versioned base URL (crm/v3/objects/taxes), which improves the consistency and usability of the APIs.

3. Update API Paths:

    * Original: `/crm/v3/objects/taxes`
    * Updated: `/`
    * Reason: This modification simplifies the API paths, making them shorter and more readable. It also centralizes the versioning to the base URL, which is a common best practice.
=======
The OpenAPI specification is obtained from (TODO: Add source link).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

[//]: # (TODO: Add sanitation details)
1. 
2. 
3. 
>>>>>>> 943b169555cf521ef0d54ac605da027c60381b1b

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
<<<<<<< HEAD
bal openapi -i docs/spec/taxes.json --mode client --license docs/license.txt -o ballerina
=======
# TODO: Add OpenAPI CLI command used to generate the client
>>>>>>> 943b169555cf521ef0d54ac605da027c60381b1b
```
Note: The license year is hardcoded to 2024, change if necessary.
