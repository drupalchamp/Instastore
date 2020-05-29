import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:instastore/pages/productDetail.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';
import 'package:instastore/pages/paymentPage.dart';

class AddToCartPage extends StatefulWidget {
  AddToCartPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
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

  //Product Name and Price in same row
  Widget _leftImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _namePrice(),
        _productImage(),
      ],
    );
  }

  //Product Name and Price in same row
  Widget _rightImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _productImage(),
        _namePrice(),
      ],
    );
  }

  Widget _quantityField() {
    return Container(
      width: 180,
      child: Column(
        children: <Widget>[
          TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Quantity',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(204, 204, 204, 1), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(204, 204, 204, 1), width: 1.0),
                  ),
                  fillColor: Color.fromRGBO(239, 240, 241, 1),
                  filled: true))
        ],
      ),
    );
  }

  Widget _buyNowButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PaymentPage()));
        //_onButtonPressed(context);
      },
      child: Container(
        width: 180,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.green),
        child: Text(
          'Buy Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  //Quantity and Add to Cart in same row
  Widget _quantityAddToCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _quantityField(),
        _buyNowButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Add To Cart'),
          backgroundColor: Colors.green,
          brightness: Brightness.dark,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              _leftImageRow(),
              SizedBox(
                height: 20,
              ),
              _quantityAddToCart(),
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
              _rightImageRow(),
              SizedBox(
                height: 20,
              ),
              _quantityAddToCart(),
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
              _leftImageRow(),
              SizedBox(
                height: 20,
              ),
              _quantityAddToCart(),
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
              _rightImageRow(),
              SizedBox(
                height: 20,
              ),
              _quantityAddToCart(),
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
              _leftImageRow(),
              SizedBox(
                height: 20,
              ),
              _quantityAddToCart(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
