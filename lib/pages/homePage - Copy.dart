import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instastore/services/api_services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';
import 'package:instastore/pages/productDetail.dart';
import 'package:instastore/pages/addToCartPage.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List categoriesLists = List();
  var isLoading = false;

  _fetchData() async {
    APIServices.getProductCategory().then((categories) {
      debugPrint('categories ${categories}');
      if (categories != null) {
        categoriesLists = categories;
        return categoriesLists;
      }
    });
  }

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

  Widget _productCategory(categoryName) {
    return RichText(
      softWrap: true,
      text: TextSpan(
        text: categoryName.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _viewMoreButton() {
    return InkWell(
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage()));
        _onButtonPressed(context);
      },
      child: Container(
        width: 100,
        //padding: EdgeInsets.only(left: 5.0, top:15.0, right:5.0, bottom: 15.0),
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.red),
        child: Text(
          'View More',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }

  //Product Category and View More in same row
  Widget _categoryViewMore(categoryName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _productCategory(categoryName),
        _viewMoreButton(),
      ],
    );
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
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetailPage()));
        //_onButtonPressed(context);
      },
      child: Container(
        width: 180,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.topLeft,
        child: Text(
          'Product Title',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _productPrice() {
    return RichText(
      softWrap: true,
      textAlign: TextAlign.left,
      text: TextSpan(
        text: '\$11.00 / \$40.00',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _productTitle(),
        _productPrice(),
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

  //Quantity and Add to Cart in same row
  Widget _quantityAddToCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _quantityField(),
        _addToCartButton(),
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
          child: _namePrice(),
        ),
        SizedBox(
          height: 20,
        ),
        _quantityAddToCart(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //_fetchData();
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Instastore'),
          backgroundColor: Colors.green,
          brightness: Brightness.dark,
        ),
        body: FutureBuilder(
            future: _fetchData(),
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  return SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          children: categoriesLists
                              .map((categoryInfo) => Container(
                                      child: Column(children: <Widget>[
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: _categoryViewMore(categoryInfo['name']),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    _productWrapperWidget(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                      height: 20,
                                      thickness: 1,
                                    ),
                                  ])))
                              .toList()));
              }
            }));
  }
}
