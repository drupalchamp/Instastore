import 'package:flutter/material.dart';
import 'package:instastore/services/makePayment.dart';
import 'package:url_launcher/url_launcher.dart';

class PaypalPaymentPage extends StatefulWidget {
  PaypalPaymentPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PaypalPaymentPageState createState() => _PaypalPaymentPageState();
}

class _PaypalPaymentPageState extends State<PaypalPaymentPage> {

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
          style: TextStyle(fontSize: 12, color: Colors.black54),
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
          style: TextStyle(fontSize: 13, color: Colors.black),
        ),
      ),
    );
  }

  //Product Name and Price in same row
  Widget _grossAmount() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          //onTap: () => _launchURL(),
          onTap: () => {
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => makePayment()))
          },
          child: Container(
            padding: EdgeInsets.all(15.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromRGBO(0, 31, 107, 1)),
            child: Text(
              'PAYPAL CHECKOUT',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text('Payment'),
          backgroundColor: Colors.blue,
          brightness: Brightness.dark,
        ),*/
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //_paymentMethod(),
              SizedBox(
                height: 20,
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
