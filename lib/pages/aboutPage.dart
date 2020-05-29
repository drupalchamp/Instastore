import 'package:flutter/material.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('About Us'),
          backgroundColor: Colors.green,
          brightness: Brightness.dark,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/about.jpg',
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing '
                            'and typesetting industry. Lorem Ipsum has been the '
                            'industry\'s standard dummy text ever since the '
                            '1500s, when an unknown printer took a galley of '
                            'type and scrambled it to make a type specimen book. '
                            'It has survived not only five centuries, but also '
                            'the leap into electronic typesetting, remaining '
                            'essentially unchanged. It was popularised in the '
                            '1960s with the release of Letraset sheets containing '
                            'Lorem Ipsum passages, and more recently with '
                            'desktop publishing software like Aldus PageMaker '
                            'including versions of Lorem Ipsum.',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
