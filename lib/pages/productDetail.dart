import 'package:flutter/material.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:instastore/pages/paymentPage.dart';
import 'package:instastore/pages/addToCartPage.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  _successAlert(context) {
    Alert(
      context: context,
      title: "Added to cart",
      // desc: "Your order has been placed successfully..",
      image: Image.asset(
        "assets/success.png",
        width: 100,
        height: 100,
      ),
    ).show();
  }

  bool _isFavorited = true;
  //Quantity and Add to Cart in same row
  Widget _favIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited
                ? Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 35,
                  )
                : Icon(
                    Icons.favorite,
                    color: Colors.red[800],
                    size: 40,
                  )),
            onPressed: _toggleFavorite,
          ),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  Widget _productImage() {
    return Container(
        child: InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetailPage()));
        //_onButtonPressed(context);
      },
      child: Stack(
        children: <Widget>[
          Center(
            child: new Image.asset(
              'assets/about.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 5.0,
            right: 5.0,
            child: _favIcon(),
          ),
        ],
      ),
    ));
  }

  Widget _productTitle() {
      return Container(
        //width: 180,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.topLeft,
        child: Text(
          'Product Title',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
  }

  Widget _productPrice() {
    return RichText(
      softWrap: true,
      textAlign: TextAlign.left,
      text: TextSpan(
        text: 'Price: \$11.00',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _quantityField() {
    return Container(
      //width: 180,
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

  Widget _addToCartButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddToCartPage()));
        _successAlert(context);
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
          'Add To Cart',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
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

  //Product Name and Price in same row
  Widget _cartBuyNowButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _addToCartButton(),
        _buyNowButton(),
      ],
    );
  }

  Widget _productWrapperWidget() {
    return Column(
      children: <Widget>[
        _productImage(),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: _productTitle(),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: _productPrice(),
        ),
        SizedBox(
          height: 25,
        ),
        Align(
          alignment: Alignment.center,
          child: _quantityField(),
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: _cartBuyNowButton(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Product Detail'),
          backgroundColor: Colors.green,
          brightness: Brightness.dark,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              _productWrapperWidget(),
            ],
          ),
        ),
      );
  }
}
