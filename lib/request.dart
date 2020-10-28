class Request {
  Request(this.url, this.query, {this.headers, this.variables});

  String url;
  String headers;
  String query;
  String variables;
}

final requests = <Request>[];
