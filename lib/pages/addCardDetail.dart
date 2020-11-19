import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  _onButtonPressed(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.red,
        ),
        constraints: BoxConstraints.expand(width: 500));

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: "Unavailable",
      desc: "This method is not available at this time.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  Widget _cardNumber() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Card Number',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  // Select List field
  String _monthSelection;
  List<Map> _monthJson = [
    {"id": 0, "name": "0"},
    {"id": 1, "name": "1"},
    {"id": 2, "name": "2"},
    {"id": 3, "name": "3"},
    {"id": 4, "name": "4"},
    {"id": 5, "name": "5"}
  ];

  Widget _expMonthDate() {
    return Container(
      width: 80,
      alignment: Alignment.centerLeft,
      child: new Center(
        child: new DropdownButton<String>(
          isDense: true,
          hint: new Text("Month"),
          value: _monthSelection,
          onChanged: (String newValue) {
            setState(() {
              _monthSelection = newValue;
            });
            print(_monthSelection);
          },
          items: _monthJson.map((Map map) {
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

  // Select List field
  String _yearSelection;
  List<Map> _yearJson = [
    {"id": 2022, "name": "2022"},
    {"id": 2023, "name": "2023"},
    {"id": 2024, "name": "2024"},
    {"id": 2025, "name": "2025"},
    {"id": 2026, "name": "2026"},
    {"id": 2027, "name": "2027"}
  ];

  Widget _expYearDate() {
    return Container(
      width: 80,
      alignment: Alignment.centerLeft,
      child: new Center(
        child: new DropdownButton<String>(
          isDense: true,
          hint: new Text("Year"),
          value: _yearSelection,
          onChanged: (String newValue) {
            setState(() {
              _yearSelection = newValue;
            });
            print(_yearSelection);
          },
          items: _yearJson.map((Map map) {
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

  Widget _cvv() {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'CVV',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))),
    );
  }

  //Product Name and Price in same row
  Widget _expMonthYear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _expMonthDate(),
        _expYearDate(),
      ],
    );
  }

  //Product Name and Price in same row
  Widget _expDateCVV() {
    return Row(
     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _expMonthYear(),
        _cvv(),
      ],
    );
  }

  Widget _cardHolderName() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Card Holder Name',
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
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
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _totalPrice() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        //width: 180,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _totalAmount(),
        _totalPrice(),
      ],
    );
  }

  Widget _confirmToPayment() {
    return InkWell(
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage()));
        _onButtonPressed(context);
      },
      child: Container(
        //width: 100,
        //padding: EdgeInsets.only(left: 5.0, top:15.0, right:5.0, bottom: 15.0),
        padding: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.blue),
        child: Text(
          'CONFIRM TO PAYMENT',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       /* appBar: AppBar(
          title: Text('Payment'),
          backgroundColor: Colors.blue,
          brightness: Brightness.dark,
        ),*/
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
             // _paymentMethod(),
              SizedBox(
                height: 20,
              ),
              _cardNumber(),
              SizedBox(
                height: 20,
              ),
              _expDateCVV(),
              SizedBox(
                height: 20,
              ),
              _cardHolderName(),
              SizedBox(
                height: 20,
              ),
              _grossAmount(),
              SizedBox(
                height: 60,
              ),
              _confirmToPayment(),
            ],
          ),
        ));
  }
}
