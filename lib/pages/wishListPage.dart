import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:instastore/pages/paymentPage.dart';
import 'package:instastore/pages/productDetail.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class WishlistPage extends StatefulWidget {
  WishlistPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {

  _successRemoveAlert(context) {
    Alert(
      context: context,
      title: "Successfully Removed",
      // desc: "Your order has been placed successfully..",
      image: Image.asset("assets/success.png", width: 100, height: 100, ),
    ).show();
  }

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
  Widget _leftImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _namePrice(),
        _productImage(),
      ],
    );
  }

  //Right Side Image
  Widget _rightImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _productImage(),
        _namePrice(),
      ],
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

//Remove form wishlist
  Widget _removeWishListButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WishlistPage()));
        _successRemoveAlert(context);
      },
      child: Container(
        width: 180,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.red),
        child: Text(
          'Remove',
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
        _removeWishListButton(),
        _buyNowButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Wishlist'),
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
