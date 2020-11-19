import 'package:flutter/material.dart';
import 'package:instastore/pages/paymentPage.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
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


  Widget _addressField() {
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
                labelText: 'Address',
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

  Widget _contactWidget() {
    return Column(
      children: <Widget>[
        _contactNameField(),
        _contactEmailField(),
        _contactPhoneField(),
        _addressField(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Checkout';
    return MaterialApp(
        title: appTitle,
        home: Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
              title: Text(appTitle),
              backgroundColor: Colors.green,
              brightness: Brightness.dark,
            ),
            body: SingleChildScrollView(
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
            )),
          bottomNavigationBar: Container(
            height: 60,
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            color: Colors.green,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentPage())),
                child: Container(
                  child:
                      Center(
                        child:
                          Text("Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),),
                      ),
                ),
              ),
            ),
          ),
        ),

    );
  }
}
