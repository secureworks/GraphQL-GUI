import 'package:astronaut/request_details.dart';
import 'package:astronaut/request.dart';
import 'package:astronaut/request_list.dart';
import 'package:flutter/material.dart';

class MasterDetailContainer extends StatefulWidget {
  @override
  _RequestMasterDetailContainerState createState() =>
      _RequestMasterDetailContainerState();
}

class _RequestMasterDetailContainerState extends State<MasterDetailContainer> {
  static const int kTabletBreakpoint = 600;

  Request _selectedRequest;

  Widget _buildMobileLayout() {
    return RequestList((request) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return RequestDetails(request, false);
      }));
    });
  }

  Widget _buildTabletLayout() {
    return Row(children: <Widget>[
      Flexible(
          flex: 1,
          child: Material(
              elevation: 4.0,
              child: RequestList((request) {
                setState(() {
                  _selectedRequest = request;
                });
              }))),
      Flexible(flex: 3, child: RequestDetails(_selectedRequest, true))
    ]);
  }

  void _addToList() {
    print("asdf");

    setState(() {
      requests.add(Request("", ""));
      _selectedRequest = requests[requests.length - 1];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    var shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileLayout();
    } else {
      content = _buildTabletLayout();
    }

    return Scaffold(
        appBar: AppBar(title: Text("GraphQL API Queryer")),
        body: content,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _addToList();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}
