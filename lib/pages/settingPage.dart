import 'package:flutter/material.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';


class SettingPage extends StatefulWidget {
  SettingPage ({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SettingPageState createState() => _SettingPageState();

}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: Colors.green,
        brightness: Brightness.dark,
      ),
      body: Center(
        child: Text('Setting Page'),
      ),
      );
  }

}
