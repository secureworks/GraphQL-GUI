import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'request.dart';
import 'graphql.dart';

class RequestDetails extends StatefulWidget {
  RequestDetails(this.request, this.isInTabletLayout);
  final Request request;
  final bool isInTabletLayout;
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    final bodyController = TextEditingController(text: widget.request.query);
    final headersController =
        TextEditingController(text: widget.request.headers);
    final urlController = TextEditingController(text: widget.request.url);

    void _buttonPressed() {
      setState(() {});
    }

    final Widget content = Center(
        child: ListView(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                obscureText: false,
                controller: urlController,
                maxLines: null,
                onChanged: (value) => {widget.request.url = value},
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'GraphQL URL',
                ),
              )),
          Padding(
              padding: EdgeInsets.all(5.0),
              child: TextField(
                obscureText: false,
                keyboardType: TextInputType.multiline,
                minLines: 8,
                controller: headersController,
                maxLines: null,
                onChanged: (value) => {widget.request.headers = value},
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'GraphQL Headers',
                ),
              )),
          Padding(
              padding: EdgeInsets.all(5.0),
              child: TextField(
                obscureText: false,
                keyboardType: TextInputType.multiline,
                minLines: 8,
                controller: bodyController,
                maxLines: null,
                onChanged: (value) => {widget.request.query = value},
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'GraphQL Query',
                ),
              )),
          Padding(
              padding: EdgeInsets.all(5.0),
              child: RaisedButton(
                  onPressed: _buttonPressed,
                  child: Text('Make GraphQL request'))),
          Padding(padding: EdgeInsets.all(10.0)),
          FutureBuilder<String>(
            future: fetchJSON(http.Client(), widget.request.query,
                widget.request.headers, widget.request.url),
            builder: (context, response) {
              if (response.hasError) print(response.error);

              return response.hasData
                  ? RichText(
                      text: TextSpan(
                          text: response.data,
                          style: TextStyle(color: Colors.black)))
                  : Center(child: CircularProgressIndicator());
            },
          )
        ],
      )
    ]));

    if (widget.isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("GraphQL Request Details")),
        body: Center(child: content));
  }
}
