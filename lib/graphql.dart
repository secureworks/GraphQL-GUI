import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchJSON(
    http.Client client, String request, String headers, String url) async {
  print(request);
  print(headers);
  print(url);
  Map<String, dynamic> body = {"query": request};
  if (headers == "") {
    headers = '{}';
  }
  Map<String, String> decodedHeaders = Map.castFrom(json.decode(headers));
  final resp = await client.post(
    url,
    headers: decodedHeaders,
    body: jsonEncode(body),
  );

  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(resp.body);
  return prettyprint;
}
