import 'package:flutter/material.dart';

class TestingPage extends StatefulWidget {
  TestingPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: const Text('Home', overflow: TextOverflow.ellipsis),
        ),
        body: Container(
          color: Color(0xFFCCCCCC),
          child: ListView(
            children: <Widget>[

            ],
          ),
        )
    );
  }
}