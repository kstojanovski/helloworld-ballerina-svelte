
import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/mime;

service sveltebackend on new http:Listener(9090) {
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/sentFormData",
        cors: {
            allowOrigins: ["http://localhost:5000"]
        }
        
    }
    resource function sentFormData(http:Caller caller, http:Request request) returns error? {
        log:printInfo("sentFormData begin");
        var bodyParts = request.getBodyParts();
        if (bodyParts is mime:Entity[]) {
            foreach var part in bodyParts {
                handleContent(part);
            }
        } else {
            log:printError("error");
        }
        var result = caller->respond("{\"status\" : \"ok\"}");
        if (result is error) {
           log:printError("Error on sending response from svelte service resource decode", result);
        }
        log:printInfo("sentFormData end");
    }

    @http:ResourceConfig {
        path: "/getTheJedi",
        cors: {
            allowOrigins: ["http://localhost:5000"]
        }
    }
    resource function getTheJedi(http:Caller caller, http:Request request) returns error? {
        log:printInfo("getTheJedi begin");
        var result = caller->respond("{\"name\" : \"Luke Skywalker\"}");
        if (result is error) {
           log:printError("Error on sending response from svelte service resource decode", result);
        }
        log:printInfo("getTheJedi end");
    }
}

function handleContent(mime:Entity bodyPart) {
        var mediaType = mime:getMediaType(bodyPart.getContentType());
        if (mediaType is error) {
                io:println("mediaType is unknown, use text!");
            var payload = bodyPart.getText();
            if (payload is string) {
                log:printInfo(payload);
            } else {
                log:printError("error");
            }
            return;
        } 
        if (mediaType is mime:MediaType) {
            string baseType = mediaType.getBaseType();
            if (mime:APPLICATION_XML == baseType || mime:TEXT_XML == baseType) {
                var payload = bodyPart.getXml();
                if (payload is xml) {
                    log:printInfo(payload.toString());
                } else {
                    log:printError("error");
                }
            } else if (mime:APPLICATION_JSON == baseType) {
                var payload = bodyPart.getJson();
                if (payload is json) {
                    log:printInfo(payload.toJsonString());
                } else {
                    log:printError("error");
                }
            } else if (mime:TEXT_PLAIN == baseType) {
                var payload = bodyPart.getText();
                if (payload is string) {
                    log:printInfo(payload);
                } else {
                    log:printError("error");
                }
            }
        }
    }