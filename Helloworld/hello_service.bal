// A system package containing protocol access constructs
// Package objects referenced with 'http:' in code
import ballerina/http;
import ballerina/io;


// A service endpoint represents a listener
endpoint http:Listener listener {
    port: 9090
};

// A service is a network-accessible API
// Advertised on '/hello', port comes from listener endpoint
@http:ServiceConfig {
   basePath: "/"
}
service<http:Service> hello bind listener {

    // A resource is an invokable API method
    // Accessible at '/hello/sayHello
    // 'caller' is the client invoking this resource 
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/"
    }
    sayHello(endpoint caller, http:Request request) {

        // Create object to carry data back to caller
        http:Response response = new;

        // Objects and structs can have function calls
        response.setTextPayload("Hello Ballerina!\n");

        // Send a response back to caller
        // Errors are ignored with '_'
        // -> indicates a synchronous network-bound call
        _ = caller->respond(response);
    }
}