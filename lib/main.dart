import 'package:astronaut/master_detail_container.dart';
import 'package:flutter/material.dart';
import 'graphql.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: MasterDetailContainer());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String body = "";
  String headers = "";
  String url = "";

  void _incrementCounter() {
    setState(() {
      body = bodyController.text;
      headers = headersController.text;
      url = urlController.text;
    });
  }

  final bodyController = TextEditingController();
  final headersController = TextEditingController();
  final urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'GraphQL Query',
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(5.0),
                child: RaisedButton(
                    onPressed: _incrementCounter,
                    child: Text('Make GraphQL request'))),
            Padding(padding: EdgeInsets.all(10.0)),
            FutureBuilder<String>(
              future: fetchJSON(http.Client(), "$body", "$headers", "$url"),
              builder: (context, response) {
                if (response.hasError) print(response.error);

                return response.hasData
                    ? Text(response.data)
                    // ? RichText(
                    //     text: TextSpan(
                    //         text: response.data,
                    //         style: TextStyle(color: Colors.black)))
                    : Center(child: CircularProgressIndicator());
              },
            )
          ],
        )
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
