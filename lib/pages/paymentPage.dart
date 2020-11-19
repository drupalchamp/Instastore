import 'package:flutter/material.dart';
import 'package:instastore/pages/addCardDetail.dart';
import 'package:instastore/pages/paypalPage.dart';
import 'package:instastore/pages/codPage.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          flexibleSpace: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TabBar(
                tabs: [
                  Tab(text: "Add Card"),
                  Tab(text: "Paypal"),
                  Tab(text: "COD"),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddCard(),
            PaypalPaymentPage(),
            CODPaymentPage(),
          ],
        ),
      ),
    );
  }
}
