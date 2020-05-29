import 'package:flutter/material.dart';
import 'dart:async';
import 'package:instastore/src/Widget/nav-drawer.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
// Variable clear on submit
  final contactName = TextEditingController();
  final contactEmail = TextEditingController();
  final contactPhone = TextEditingController();

// Function to clear on submit click
  clearTextInput() {
    contactName.clear();
    contactEmail.clear();
    contactPhone.clear();
  }

  // Date field
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Select List field
  String _mySelection;
  List<Map> _myJson = [
    {"id": 0, "name": "Advocate"},
    {"id": 1, "name": "IT Service"},
    {"id": 2, "name": "Defence"},
    {"id": 3, "name": "Railways"},
    {"id": 4, "name": "Doctor"},
    {"id": 5, "name": "Police"}
  ];

  Widget _contactProfessionField() {
    return Container(
      alignment: Alignment.centerLeft,
      child: new Center(
        child: new DropdownButton<String>(
          isDense: true,
          hint: new Text("Select Profession"),
          value: _mySelection,
          onChanged: (String newValue) {
            setState(() {
              _mySelection = newValue;
            });
            print(_mySelection);
          },
          items: _myJson.map((Map map) {
            return new DropdownMenuItem<String>(
              value: map["id"].toString(),
              child: new Text(
                map["name"],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Input field
  Widget _contactNameField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: contactName,
            autocorrect: true,
            decoration: InputDecoration(
                labelText: 'Name',
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          ),
        ],
      ),
    );
  }

  Widget _contactEmailField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: contactEmail,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'Email'),
          ),
        ],
      ),
    );
  }

  Widget _contactPhoneField() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.number,
            controller: contactPhone,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'Mobile Number'),
          ),
        ],
      ),
    );
  }

  Widget _contactDOBField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("${selectedDate.toLocal()}".split(' ')[0]),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context),
            child: Text('D.O.B.'),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () => clearTextInput(),
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.green),
        child: Text(
          'Submit',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }



  Widget _contactWidget() {
    return Column(
      children: <Widget>[
        _contactNameField(),
        _contactEmailField(),
        _contactPhoneField(),
        _contactDOBField(),
        _contactProfessionField(),
        _submitButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Contact';
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
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _contactWidget(),
                        Expanded(
                          flex: 5,
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ))));
  }
}
