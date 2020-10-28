import 'request.dart';
import 'package:flutter/material.dart';

class RequestList extends StatelessWidget {
  RequestList(
    this.requestSelectedCallback, {
    this.selectedRequest,
  });

  final ValueChanged<Request> requestSelectedCallback;
  final Request selectedRequest;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
          child: ListView.builder(
              itemCount: requests.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(requests[index].query),
                    onTap: () => requestSelectedCallback(requests[index]),
                    selected: selectedRequest == requests[index]);
              }))
    ]);
    // return ListView(
    //     children: requests.map((request) {
    //   return ListTile(
    //       title: Text(request.query),
    //       onTap: () => requestSelectedCallback(request),
    //       selected: selectedRequest == request);
    // }).toList()
    // );
  }
}
