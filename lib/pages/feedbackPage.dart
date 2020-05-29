import 'package:flutter/material.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final feedbackHolder = TextEditingController();

  clearTextInput() {
    feedbackHolder.clear();
  }

  Widget _feedbackField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: feedbackHolder,
            autocorrect: true,
            maxLines: 12,
            decoration: InputDecoration(
                hintText: 'Submit Your Feedback',
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () => clearTextInput(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.green),
        child: Text(
          'Submit',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _feedbackWidget() {
    return Column(
      children: <Widget>[
        _feedbackField(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Feedback';
    return MaterialApp(
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        _feedbackWidget(),
                        SizedBox(
                          height: 100,
                        ),
                        _submitButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ))));
  }
}
