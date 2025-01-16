// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/oauth2;
import ballerina/test;

configurable string clientId = "mockClientId";
configurable string clientSecret = "mockClientSecret";
configurable string refreshToken =  "mockRefreshToken";
configurable boolean enableClientOauth2 = false;

ConnectionConfig config = {
    auth: enableClientOauth2 ? {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        } : {token: "Bearer token"}
};

final Client taxes = check new (config);

//this object is used to test the Basic endpoints
SimplePublicObject basicTax = {
    createdAt: "",
    id: "",
    properties: {},
    updatedAt: ""
};

//this list is used to store the tax id's created in batch create
string[] batchTaxId = [];

@test:Config {
    groups: ["live_service_test"]
}
function testPostTax() returns error? {

    SimplePublicObjectInputForCreate payload = {
        associations: [],
        properties: {
            "hs_label": "A percentage-based tax of 8.5%",
            "hs_value": "8.5000",
            "hs_type": "PERCENT"
        }
    };

    SimplePublicObject response = check taxes->/.post(payload);

    test:assertEquals(response.properties["hs_label"], "A percentage-based tax of 8.5%", "Tax label is not created");
    test:assertEquals(response.properties["hs_value"], "8.5000", "Tax value is not created");
    test:assertEquals(response.properties["hs_type"], "PERCENT", "Tax type is not created");

    basicTax = response;
}

@test:Config {
    groups: ["live_service_test"]
}
function testGetTaxList() returns error? {

    GetCrmV3ObjectsTaxes_getpageQueries params = {
        'limit: 5,
        properties: ["hs_value", "hs_type", "hs_label"]
    };

    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check taxes->/.get({}, params);

    foreach var result in response.results {
        test:assertNotEquals(result.id, (), "Tax id is not found");
        test:assertNotEquals(result.properties, (), "Tax properties are not found");
        test:assertNotEquals(result.properties["hs_type"], (), "Tax type is not found");
        test:assertNotEquals(result.properties["hs_value"], (), "Tax value is not found");
        test:assertNotEquals(result.properties["hs_label"], (), "Tax label is not found");
    }
    test:assertTrue(response.results.length() <= 5, "Tax list is not found");

}

@test:Config {
    groups: ["live_service_test"],
    dependsOn: [testPostTax]
}
function testGetTaxbyID() returns error? {

    GetCrmV3ObjectsTaxesTaxid_getbyidQueries params = {
        properties: ["hs_value", "hs_type", "hs_label"]
    };

    final string taxId = basicTax.id;

    SimplePublicObjectWithAssociations response = check taxes->/[taxId].get({}, params);

    test:assertNotEquals(response.createdAt, (), "Tax created at is not found");
    test:assertNotEquals(response.updatedAt, (), "Tax updated at is not found");
    test:assertEquals(response.properties["hs_label"], "A percentage-based tax of 8.5%", "Tax label is not found");
    test:assertEquals(response.properties["hs_value"], "8.5000", "Tax value is not found");
    test:assertEquals(response.properties["hs_type"], "PERCENT", "Tax type is not found");
}

@test:Config {
    groups: ["live_service_test"],
    dependsOn: [testPatchTaxbyID]
}
function testDeleteTaxbyID() returns error? {

    final string taxId = basicTax.id;

    http:Response response = check taxes->/[taxId].delete();

    test:assertEquals(response.statusCode, 204, "Tax is not deleted");
}

@test:Config {
    groups: ["live_service_test"],
    dependsOn: [testGetTaxbyID]
}
function testPatchTaxbyID() returns error? {

    final string taxId = basicTax.id;

    SimplePublicObjectInput payload = {
        properties: {
            "hs_label": "A percentage-based tax of 6.75%",
            "hs_value": "6.7500",
            "hs_type": "PERCENT"
        }
    };

    SimplePublicObject response = check taxes->/[taxId].patch(payload);

    test:assertEquals(response.properties["hs_label"], "A percentage-based tax of 6.75%", "Tax label is not updated");
    test:assertEquals(response.properties["hs_value"], "6.7500", "Tax value is not updated");
    test:assertEquals(response.properties["hs_type"], "PERCENT", "Tax type is not updated");

}

@test:Config {
    groups: ["live_service_test"],
    dependsOn: [testPostBatchRead]
}
function testPostBatchUpdate() returns error? {

    BatchInputSimplePublicObjectBatchInput payload = {
        inputs: [
            {
                id: batchTaxId[0],
                properties: {
                    "hs_label": "A percentage-based tax of 3.5%",
                    "hs_value": "3.5000",
                    "hs_type": "PERCENT"
                }
            },
            {
                id: batchTaxId[1],
                properties: {
                    "hs_label": "A percentage-based tax of 3.75%",
                    "hs_value": "3.7500",
                    "hs_type": "PERCENT"
                }
            }
        ]
    };

    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = 
        check taxes->/batch/update.post(payload);

    if response is BatchResponseSimplePublicObjectWithErrors {
        test:assertFail("Error occured while batch updating taxes");
    }

    test:assertEquals(response.status, "COMPLETE", "Batch update failed");
    test:assertEquals(response.results.length(), 2, "Not all the taxes are updated");
    test:assertNotEquals(response.results[0].id, (), "Id of an updated tax is null");
    test:assertNotEquals(response.results[1].id, (), "Id of an updated tax is null");

    foreach var result in response.results {
        string id = result.id;
        string expectedLabel = id == batchTaxId[0] ? "A percentage-based tax of 3.5%" 
                                    : "A percentage-based tax of 3.75%";
        string expectedValue = id == batchTaxId[0] ? "3.5000" : "3.7500";
        test:assertEquals(result.properties["hs_label"], expectedLabel, "Tax label is not updated");
        test:assertEquals(result.properties["hs_value"], expectedValue, "Tax value is not updated");
    }
}

@test:Config {
    groups: ["live_service_test"],
    dependsOn: [testPostBatchcreate]
}
function testPostBatchRead() returns error? {

    BatchReadInputSimplePublicObjectId payload = {
        inputs: [{id: batchTaxId[0]}, {id: batchTaxId[1]}],
        properties: ["hs_value", "hs_type", "hs_label"],
        propertiesWithHistory: ["hs_value", "hs_type", "hs_label"]
    };

    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = 
        check taxes->/batch/read.post(payload);

    if response is BatchResponseSimplePublicObjectWithErrors {
        test:assertFail("Error occured while batch reading taxes");
    }
    else {
        test:assertEquals(response.results.length(), 2, "Not all the taxes are fetched");
        test:assertNotEquals(response.results[0].id, (), "Id of a fetched tax is null");
        test:assertNotEquals(response.results[1].properties, (), "properties of a fetched tax is null");
        test:assertNotEquals(response.results[0].propertiesWithHistory, (), 
                            "propertiesWithHistory of a fetched tax is null");
    }
}

@test:Config {
    groups: ["live_service_test"]
}
function testPostBatchcreate() returns error? {

    BatchInputSimplePublicObjectInputForCreate payload = {
        inputs: [
            {
                associations: [],
                properties: {
                    "hs_label": "A percentage-based tax of 2.5%",
                    "hs_value": "2.5000",
                    "hs_type": "PERCENT"
                }
            },
            {
                associations: [],
                properties: {
                    "hs_label": "A percentage-based tax of 2.75%",
                    "hs_value": "2.7500",
                    "hs_type": "PERCENT"
                }
            }
        ]
    };

    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = 
        check taxes->/batch/create.post(payload);

    if response is BatchResponseSimplePublicObjectWithErrors {
        test:assertFail("Error occured while batch creating taxes");
    }
    else {
        test:assertEquals(response.status, "COMPLETE", "Batch create failed");
        test:assertEquals(response.results.length(), 2, "Not all the taxes are created");
        test:assertNotEquals(response.results[0].id, (), "Id of a created tax is null");

        batchTaxId.push(response.results[0].id);
        batchTaxId.push(response.results[1].id);
    }

}

@test:Config {
    groups: ["live_service_test"]
}
isolated function testPostSearch() returns error? {
    PublicObjectSearchRequest payload = {
        sorts: ["hs_value"],
        query: "A percentage-based tax",
        'limit: 10,
        properties: ["hs_label", "hs_value", "hs_type"]
    };

    CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check taxes->/search.post(payload);

    test:assertNotEquals(response.results, [], "No search results found");
    test:assertTrue(response.results.length() <= 10, "Limit Exceeded");

    foreach SimplePublicObject result in response.results {
        test:assertNotEquals(result.id, (), "Tax ID is not found");
        test:assertNotEquals(result.properties, (), "Tax properties are not found");
        test:assertNotEquals(result.properties["hs_type"], (), "Tax type is not found");
        test:assertNotEquals(result.properties["hs_value"], (), "Tax value is not found");
    }
}

@test:Config {
    groups: ["live_service_test"],
    dependsOn: [testPostBatchUpdate]
}
function testPostBatchArchive() returns error? {

    BatchInputSimplePublicObjectId payload = {
        inputs: [{id: batchTaxId[0]}, {id: batchTaxId[1]}]
    };

    http:Response response = check taxes->/batch/archive.post(payload);

    test:assertEquals(response.statusCode, 204, "Batch archive failed");
}
