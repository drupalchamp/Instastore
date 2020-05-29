import 'package:flutter/material.dart';


class TestingPage extends StatefulWidget {
  TestingPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/about.jpg"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Text("YOUR TEXT YOUR TEXT YOUR TEXT YOUR TEXT YOUR TEXT YOUR TEXT YOUR TEXT YOUR TEXT YOUR TEXT YOUR TEXT YOUR TEXT YOUR TEXT ",
        style: TextStyle(color: Colors.yellow, fontSize: 30),),
      ),
    );
  }

}