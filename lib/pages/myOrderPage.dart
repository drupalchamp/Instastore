import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:instastore/pages/productDetail.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';

class MyOrderPage extends StatefulWidget {
  MyOrderPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  Widget _productImage() {
    return Container(
        width: 200,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductDetailPage()));
            //_onButtonPressed(context);
          },
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset('assets/about.jpg'),
            ),
          ),
        ));
  }

  Widget _productTitle() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetailPage()));
        //_onButtonPressed(context);
      },
      child: Container(
        // width: 180,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.topLeft,
        child: Text(
          'Product Title',
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _productPrice() {
    return RichText(
      softWrap: true,
      textAlign: TextAlign.left,
      text: TextSpan(
        text: '\$11.00',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  //Product Name and Price in same row
  Widget _namePrice() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _productTitle(),
        _productPrice(),
      ],
    );
  }

  //Left Side Image
  Widget _orderList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _namePrice(),
        _productImage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('My Order'),
          backgroundColor: Colors.green,
          brightness: Brightness.dark,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
              SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              _orderList(),
            ],
          ),
        ));
  }
}
