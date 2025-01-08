# Ballerina HubSpot CRM Commerce Taxes connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.taxes/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.taxes/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.taxes/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.taxes/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.taxes/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.taxes/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-hubspot.crm.commerce.taxes.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.commerce.taxes/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/hubspot.crm.commerce.taxes.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%hubspot.crm.commerce.taxes)

## Overview

<<<<<<< HEAD
[HubSpot](https://www.hubspot.com) is an AI-powered customer relationship management (CRM) platform. 

The ballerinax/hubspot.crm.commerce.taxes offers APIs to connect and interact with the [Taxes](https://developers.hubspot.com/docs/guides/api/crm/commerce/taxes) endpoints, specifically based on the [Taxes API Docs](https://developers.hubspot.com/docs/reference/api/crm/commerce/taxes)

## Setup guide

You need a [HubSpot developer account](https://developers.hubspot.com/get-started) with an [app](https://developers.hubspot.com/docs/guides/apps/public-apps/overview) to use HubSpot connectors.
>To create a HubSpot Developer account, [click here](https://app.hubspot.com/signup-hubspot/developers)

### Step 1: Create HubSpot Developer Project
1. [Login](https://app.hubspot.com/login) to HubSpot developer account.

2. Create a public app by clicking on `Create app`.![alt text](<./docs/setup/resources/build_public_app.png>)

3. Click on `Create app`.
![alt text](<./docs/setup/resources/create_app.png>)

4. Under `App Info`
   - Enter `Public app name`.
   - Update `App logo` (optional).
   - Update `Description` (optional). 

   ![alt text](<./docs/setup/resources/enter_app_details.png>)

- Then move to `Auth` tab.

5. Setup the `Redirect URLs` with respective links.
   >Example: http://localhost:9090  

   ![alt text](<./docs/setup/resources/auth_page.png>)

Finally `Create app`.

### Step 2: Get `Client ID` and `Client secret`.
Navigate to `Auth` tab.

![alt text](<./docs/setup/resources/client_id_secret.png>)

### Step 3: Get `access token` and `refresh token`.

1. Set scopes under `Auth` tab for your app based on the [API requirements](https://developers.hubspot.com/docs/reference/api).

   >Example: https://developers.hubspot.com/docs/reference/api/crm/commerce/taxes
   ![alt text](<./docs/setup/resources/exmaple_api_reference.png>)

2. Under `Auth` tab under `Sample install URL (OAuth)` section `Copy full URL`.
   >**Note:** The above copied URL is in the following format.
   ```
   https://app.hubspot.com/oauth/authorize?client_id=<client_id>&redirect_uri=<redirect_url>&scope=<scopes>
   ```

3. Choose the preferred account.

   ![alt text](<./docs/setup/resources/account_chose.png>)

   Choose account and authorize the client.

4. `This site can’t be reached` message will appear. Look in the URL and find the authorization code.
   >Example: code=na1-************************S

5. Send a http request to the HubSpot.

   * Linux/MacOS
      ```
      curl --request POST \ 
      --url https://api.hubapi.com/oauth/v1/token \ --header 'content-type: application/x-www-form-urlencoded' \ 
      --data 'grant_type=authorization_code&code=<code>&redirect_uri=http://localhost:9090&client_id=<client_id>&client_secret=<client_secret>'
      ```

6. Above command returns the `access token` and `refresh token`.

7. Use these tokens to authorize the client.

## Quickstart

To use the `HubSpot CRM Commerce Taxes` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `hubspot.crm.commerce.taxes` module and `oauth2` module.

```ballerina
import ballerinax/hubspot.crm.commerce.taxes;
import ballerina/oauth2;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and, configure the obtained credentials obtained in the above steps as follows:

   ```toml
    clientId = <Client Id>
    clientSecret = <Client Secret>
    refreshToken = <Refresh Token>
   ```

2. Instantiate a `OAuth2RefreshTokenGrantConfig` with the obtained credentials and initialize the connector with it.

    ```ballerina
   configurable string clientId = ?;
   configurable string clientSecret = ?;
   configurable string refreshToken = ?;

   taxes:ConnectionConfig config = {
      auth : {
         clientId,
         clientSecret,
         refreshToken,
         credentialBearer: oauth2:POST_BODY_BEARER 
      }
   };
   final taxes:Client hubSpotClient = check new taxes:Client(config);
   ```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations. A sample usecase is shown below.

#### Create a New Tax

```ballerina

   taxes:SimplePublicObjectInputForCreate payload = {

      associations: [],
      objectWriteTraceId: "1234",
      properties: {
         "hs_label": "A percentage-based tax of 6%",
         "hs_type": "PERCENT",
         "hs_value": "6"
      }

      taxes:SimplePublicObject|error response = check hubspotClientTax->/.post(payload);

   };
```
=======
[//]: # (TODO: Add overview mentioning the purpose of the module, supported REST API versions, and other high-level details.)

## Setup guide

[//]: # (TODO: Add detailed steps to obtain credentials and configure the module.)

## Quickstart

[//]: # (TODO: Add a quickstart guide to demonstrate a basic functionality of the module, including sample code snippets.)
>>>>>>> 943b169555cf521ef0d54ac605da027c60381b1b

## Examples

The `HubSpot CRM Commerce Taxes` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/module-ballerinax-hubspot.crm.commerce.taxes/tree/main/examples/), covering the following use cases:

<<<<<<< HEAD
1. [Manage Taxes](/examples/manage-taxes/) - see how the Hubspot taxes API can be used to create a tax and manage it through the sales pipeline.
2. 
=======
[//]: # (TODO: Add examples)
>>>>>>> 943b169555cf521ef0d54ac605da027c60381b1b

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`hubspot.crm.commerce.taxes` package](https://central.ballerina.io/ballerinax/hubspot.crm.commerce.taxes/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
