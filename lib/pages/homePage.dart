import 'dart:async';
import 'dart:convert';

import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instastore/scoped-models/main.dart';
import 'package:instastore/screens/cart.dart';
import 'package:instastore/screens/search.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:sticky_headers/sticky_headers.dart';

import 'package:instastore/pages/productDetail.dart';
import 'package:instastore/services/api_services.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';
import 'package:instastore/pages/addToCartPage.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  /*final String title;
  final String productId;
  final String deltaId;
  HomeScreen(
      {Key key, this.title, @required this.productId, @required this.deltaId})
      : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();*/

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final MainModel _model = MainModel();
  Size _deviceSize;
  List categoriesLists = List();
  List categoryWithProducts = List();

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> _fetchData() async =>
      await http.get(API.PRODUCT_CATEGORY_URL, headers: {
        "Content-Type": "application/json",
      }).then((response) {
        // TODO: handle value
        List<dynamic> productCategoryJson = json.decode(response.body);
        //debugPrint('productCategoryJson ${productCategoryJson}');
        if (response.statusCode == 200) {
          categoryWithProducts = productCategoryJson;
          return categoryWithProducts;
        }
      });

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

  Widget _addToCartButton(productId, deltaId) {
    return InkWell(
      onTap: () {
        /* Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetailPage()));*/
        http.get(API.CART_URL, headers: {
          "Content-Type": "application/json",
        }).then((response) {
          // TODO: handle value
          List<dynamic> cartResponseJson = json.decode(response.body);
          // debugPrint('cartResponseJson $cartResponseJson');
          if (response.statusCode == 200) {
            http.post(API.ADD_TO_CART_URL,
                body: json.encode([
                  {
                    "purchased_entity_type": "commerce_product_variation",
                    "purchased_entity_id": productId,
                    "quantity": "1",
                    "delta": deltaId
                  }
                ]),
                headers: {
                  "Content-Type": "application/json",
                }).then((response) {
              // TODO: handle value
              List<dynamic> addCartResponseJson = json.decode(response.body);
              //debugPrint('addCartResponseJson $addCartResponseJson');
              if (response.statusCode == 200) {
                _successAlert(context);
              }
            });
          }
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 5.0,
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                  color: Colors.green,
                ),
                child: Text(
                  'ADD',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: 30.0,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 4.5, horizontal: 5.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(68, 157, 68, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(5.0),
                ),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topShopingCartIcon() {
    return IconButton(
      icon: Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
      onPressed: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => AddToCartPage()));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      },
    );
  }

  Widget _loadingController() {
    return Center(
      child: Text(
        'Loading...',
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
      ),
    );
  }

  Widget searchBar() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return GestureDetector(
              onTap: () {
                MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => ProductSearch());
                Navigator.of(context).push(route);
              },
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  width: _deviceSize.width,
                  height: 49,
                  margin: EdgeInsets.all(010),
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: Text(
                      'Search Products...',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                model.isLoading ? LinearProgressIndicator() : Container()
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    //final ScrollController _scrollController = ScrollController();
    //_fetchData();
    debugPrint('categoryWithProducts $categoryWithProducts');
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model)
    {
      return Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            title: Text('Instastore'),
            backgroundColor: Colors.green,
            brightness: Brightness.dark,
            actions: <Widget>[
              // _topSearchIcon(),
              _topShopingCartIcon(),
            ],
            bottom: PreferredSize(
              preferredSize: Size(_deviceSize.width, 70),
              child: searchBar(),
            ),
          ),
          resizeToAvoidBottomPadding: false,
          body: FutureBuilder(
              future: _fetchData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return _loadingController();
                    break;
                  case ConnectionState.active:
                    return _loadingController();
                    break;
                  case ConnectionState.done:
                    return gridHeader();
                }
              }));
    });
  }

  num countValue = 2;
  //num aspectWidth = 2 ;
  num aspectHeight = 0.76;

  Widget gridHeader() {
    return ListView.builder(
      itemCount: categoryWithProducts.length,
      itemBuilder: (context, index) {
        return StickyHeader(
          header: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            margin: EdgeInsets.only(
                top: 5.0, bottom: 20.0, left: 10.0, right: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromRGBO(80, 200, 100, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              HtmlUnescape().convert(categoryWithProducts[index]['name']),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            padding: EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  jsonDecode(categoryWithProducts[index]['products']).length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //crossAxisCount: 2,
                // childAspectRatio: 0.76,
                crossAxisCount: countValue,
                childAspectRatio: aspectHeight,
              ),
              itemBuilder: (contxt, indx) {
                //List p = jsonDecode(categoryWithProducts[index]['products']);
                return Card(
                  elevation: 1.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          4.7,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              4.0,
                                      margin: EdgeInsets.only(right: 5.0),
                                      alignment: Alignment.topLeft,
                                      child: InkWell(
                                        onTap: () {
                                          String productId = jsonDecode(
                                              categoryWithProducts[index]
                                                  ['products'])[indx]['id'];

                                          String deltaId = jsonDecode(
                                              categoryWithProducts[index]
                                                  ['products'])[indx]['delta'];

                                          //debugPrint('deltaId $deltaId');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailPage(
                                                        productId: productId,
                                                         deltatId: deltaId, deltaId: null,
                                                      )));
                                          //_onButtonPressed(context);
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              child: Image.network(
                                                jsonDecode(categoryWithProducts[
                                                            index]
                                                        ['products'])[indx]
                                                    ['image'],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          jsonDecode(categoryWithProducts[index]
                                                      ['products'])[indx]
                                                  ['sell_price']
                                              .split('.')[0],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5.5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          jsonDecode(categoryWithProducts[index]
                                                      ['products'])[indx]
                                                  ['list_price']
                                              .split('.')[0],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5.5,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: EdgeInsets.all(2.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          jsonDecode(categoryWithProducts[index]
                                              ['products'])[indx]['discount'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  String productId = jsonDecode(
                                      categoryWithProducts[index]
                                          ['products'])[indx]['id'];

                                  String deltaId = jsonDecode(
                                      categoryWithProducts[index]
                                          ['products'])[indx]['delta'];

                                  //debugPrint('productId $productId');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailPage(
                                                  productId: productId,
                                                  deltaId: deltaId)));
                                  //_onButtonPressed(context);
                                },
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    HtmlUnescape().convert(jsonDecode(
                                        categoryWithProducts[index]
                                            ['products'])[indx]['name']),
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    HtmlUnescape().convert(jsonDecode(
                                        categoryWithProducts[index]
                                            ['products'])[indx]['weight']),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        _addToCartButton(
                                            jsonDecode(
                                                categoryWithProducts[index]
                                                    ['products'])[indx]['id'],
                                            jsonDecode(
                                                    categoryWithProducts[index]
                                                        ['products'])[indx]
                                                ['delta']),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      shrinkWrap: true,
    );
  }
}
