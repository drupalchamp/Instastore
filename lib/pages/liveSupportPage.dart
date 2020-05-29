import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';

void main() => runApp(new LiveSupportPage());

class LiveSupportPage extends StatefulWidget {
  LiveSupportPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LiveSupportPageState createState() => _LiveSupportPageState();
}

class _LiveSupportPageState extends State<LiveSupportPage> {
  final String phone = '+919876543210';
  final String email = 'mailto:example@example.com';

  // Call Support
  Widget _callSupport() {
    void _callPhone() async {
      if (await canLaunch('tel:' + phone)) {
        await launch('tel:' + phone);
      } else {
        throw 'Could not Call !!';
      }
    }

    return Container(
        constraints: BoxConstraints(maxHeight: 260.0, minHeight: 50.0),
        child: InkWell(
          onTap: () => _callPhone(),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  Icons.phone,
                  color: Colors.green,
                  size: 150.0,
                ),
              ],
            ),
          ),
        ));
  }

  // SMS Support
  Widget _smsSupport() {
    void _sendSMS() async {
      if (await canLaunch('sms:' + phone)) {
        await launch('sms:' + phone);
      } else {
        throw 'Could not SMS !!';
      }
    }

    return Container(
        constraints: BoxConstraints(maxHeight: 260.0, minHeight: 50.0),
        child: InkWell(
          onTap: () => _sendSMS(),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  Icons.sms,
                  color: Colors.green,
                  size: 150.0,
                ),
              ],
            ),
          ),
        ));
  }

// Email Support
  Widget _emailSupport() {
    void _createMail() async {
      if (await canLaunch(email)) {
        await launch(email);
      } else {
        throw 'Could not Email !!';
      }
    }

    return Container(
        constraints: BoxConstraints(maxHeight: 260.0, minHeight: 50.0),
        child: InkWell(
          onTap: () => _createMail(),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.green,
                  size: 150.0,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _liveSupportWidget() {
    return Column(
      children: <Widget>[
        _callSupport(),
        _smsSupport(),
        _emailSupport(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = '24X7 Support';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              title: Text(appTitle),
              backgroundColor: Colors.green,
              brightness: Brightness.dark,
            ),
            body: Container(
                child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          _liveSupportWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))));
  }
}
