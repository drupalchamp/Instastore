import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TestingPage extends StatefulWidget {
  TestingPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Testing Page'),
          backgroundColor: Colors.green,
          brightness: Brightness.dark,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


            ],
          ),
        ));
  }
}
