import ballerina/http;
import ballerina/log;
import ballerina/file;
import ballerina/lang.regexp;
import ballerina/io;

public type Payload record {|
    string code;
    string version = "latest";
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
        file:MetaData[] readDir = check file:readDir("Operation");
        map<json> jsonMap = {};
        foreach file:MetaData item in readDir {
            string[] path = (regexp:split(re `/`, item.absPath));
            string name = regexp:replace(re `.json`, path[path.length() - 1], "");
            json jsonString = check io:fileReadJson(item.absPath);
            jsonMap[name] = jsonString;
        }
        io:println(jsonMap);
        return payload.toJson();
    }
}
