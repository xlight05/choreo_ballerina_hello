import ballerina/http;
import ballerina/log;

public type Payload record {|
    string code;
    string version = "v2";
|};

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"],
        allowMethods: ["*"]
    }
}

service /ai on new http:Listener(9093, {timeout: 180}) {
    resource function post code(Payload payload) returns json|error {
        log:printInfo("Mock api Key: " + apiKey);
        log:printInfo("Mock Service url: " + serviceUrl);
        return payload.toJson();
    }
}
