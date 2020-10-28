# GraphQL GUI 

Flutter experiment to build a cross-platform GUI app to query abritrary GraphQL endpoints 

Uses [flutter](https://flutter.dev) and [hover](https://github.com/go-flutter-desktop/hover) to run on MacOS. Other platforms have not been tested yet, but there is no platform-specific code running so they should all work. 

Created during an internal Secureworks hackathon (Sept. 2020)

Currently: 
- Allows you to make GraphQL calls
- Includes a master/detail view; a list of requests that you can switch between 
- Displays string of json after making the request. 

100% written in Dart. 

Potential future work: 
- Fix initial state error when starting application
- GraphQL introspection
- Saving requests to disk
- Formatted graphql/json strings in both the input and output
- Automation of certain requests and environment variables (such as for tokens)
- REST API support
- Pipelines w/state management eg. 1) get token 2) use token in graphql call, extract data from response json 3) use extracted data in REST call 
- Autofill via GraphQL introspection, no-code query structuring 