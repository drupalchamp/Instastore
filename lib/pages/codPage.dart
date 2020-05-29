import 'package:flutter/material.dart';
import 'package:instastore/pages/homePage.dart';
import 'package:instastore/pages/paymentPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:instastore/pages/paypalPage.dart';

class CODPaymentPage extends StatefulWidget {
  CODPaymentPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CODPaymentPageState createState() => _CODPaymentPageState();
}

class _CODPaymentPageState extends State<CODPaymentPage> {
  // Alert custom images
  _successAlert(context) {
    Alert(
      context: context,
      title: "Order Confirm",
      // desc: "Your order has been placed successfully..",
      image: Image.asset(
        "assets/success.png",
        width: 100,
        height: 100,
      ),
    ).show();
  }

  Widget _billingAddress() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromRGBO(179, 179, 179, 1)),
      alignment: Alignment.topLeft,
      child: Text(
        'BILLING ADDRESS',
        style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 25,
            color: Colors.black),
      ),
    );
  }

  Widget _cardPayment() {
    return Container(
        width: 110,
        height: 100,
        padding: const EdgeInsets.all(3.0),
        decoration:
            BoxDecoration(border: Border.all(width: 3, color: Colors.grey)),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentPage()));
            //_onButtonPressed(context);
          },
          child: Container(
            child: ClipRRect(
              child: Image.asset('assets/card.jpg'),
            ),
          ),
        ));
  }

  Widget _paypalPayment() {
    return Container(
        width: 110,
        height: 100,
        padding: const EdgeInsets.all(3.0),
        decoration:
            BoxDecoration(border: Border.all(width: 3, color: Colors.grey)),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaypalPaymentPage()));
            //_onButtonPressed(context);
          },
          child: Container(
            child: ClipRRect(
              child: Image.asset('assets/paypal.png'),
            ),
          ),
        ));
  }

  Widget _codPayment() {
    return Container(
        width: 110,
        height: 100,
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.greenAccent)),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CODPaymentPage()));
            // _onButtonPressed(context);
          },
          child: Container(
            child: ClipRRect(
              child: Image.asset('assets/cod.jpg'),
            ),
          ),
        ));
  }

  Widget _paymentMethod() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _cardPayment(),
        _paypalPayment(),
        _codPayment(),
      ],
    );
  }

  final userName = TextEditingController();
  final userEmail = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final country = TextEditingController();
  final zipCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();

  Widget _userEmailField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: userEmail,
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

  Widget _userNameField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: userName,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'Name'),
          ),
        ],
      ),
    );
  }

  Widget _addressOneField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: address,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'Address 1'),
          ),
        ],
      ),
    );
  }

  Widget _addressTwoField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: address,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'Address 2'),
          ),
        ],
      ),
    );
  }

  Widget _countryField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: country,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'Country'),
          ),
        ],
      ),
    );
  }

  Widget _zipCodeField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
            ],
            keyboardType: TextInputType.number,
            controller: zipCode,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'Zipcode'),
          ),
        ],
      ),
    );
  }

  Widget _cityField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: city,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'City'),
          ),
        ],
      ),
    );
  }

  Widget _stateField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: state,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'State'),
          ),
        ],
      ),
    );
  }

  Widget _phoneField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            keyboardType: TextInputType.number,
            controller: phone,
            autocorrect: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: 'Phone'),
          ),
        ],
      ),
    );
  }

  Widget _userBillingDetails() {
    return Column(
      children: <Widget>[
        _userEmailField(),
        _userNameField(),
        _addressOneField(),
        _addressTwoField(),
        _countryField(),
        _zipCodeField(),
        _cityField(),
        _stateField(),
        _phoneField(),
      ],
    );
  }

  // Confirm Submit Button
  Widget _confirmToPayment() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        _successAlert(context);
      },
      child: Container(
        //width: 100,
        //padding: EdgeInsets.only(left: 5.0, top:15.0, right:5.0, bottom: 15.0),
        padding: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.green),
        child: Text(
          'CONFIRM TO PAYMENT',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
          backgroundColor: Colors.green,
          brightness: Brightness.dark,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              _paymentMethod(),
              SizedBox(
                height: 20,
              ),
              _billingAddress(),
              SizedBox(
                height: 20,
              ),
              _userBillingDetails(),
              _confirmToPayment(),
            ],
          ),
        ));
  }
}
