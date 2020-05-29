import 'package:flutter/material.dart';
import 'package:instastore/pages/paymentPage.dart';
import 'package:flutter/services.dart';
import 'package:instastore/pages/codPage.dart';
import 'package:url_launcher/url_launcher.dart';

class PaypalPaymentPage extends StatefulWidget {
  PaypalPaymentPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PaypalPaymentPageState createState() => _PaypalPaymentPageState();
}

class _PaypalPaymentPageState extends State<PaypalPaymentPage> {

  Widget _cardPayment() {
    return Container(
        width: 110,
        height: 100,
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.grey)),
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
            BoxDecoration(border: Border.all(width: 3, color: Colors.greenAccent)),
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
        decoration:
            BoxDecoration(border: Border.all(width: 3, color: Colors.grey)),
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

  //Product Name and Price in same row
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


  Widget _totalAmount() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        //width: 180,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.topLeft,
        child: Text(
          'TOTAL AMOUNT:',
          style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _totalPrice() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 180,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          '\$265.90',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  //Product Name and Price in same row
  Widget _grossAmount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _totalAmount(),
        _totalPrice(),
      ],
    );
  }


  // Call Support
  Widget _paypalURL() {
    _launchURL() async {
      const url = 'https://www.paypal.com/signin';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Container(
        child: InkWell(
          onTap: () => _launchURL(),
          child: Container(
            padding: EdgeInsets.all(25.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromRGBO(0, 31, 107, 1)),
            child: Text(
              'PAYPAL CHECKOUT',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ));
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _paymentMethod(),SizedBox(
                height: 200,
              ),
              _grossAmount(),
              SizedBox(
                height: 20,
              ),
              _paypalURL(),
            ],
          ),
        ));
  }
}
