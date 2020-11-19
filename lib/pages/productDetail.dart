import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';
import 'package:instastore/services/api_services.dart';

class ProductDetailPage extends StatefulWidget {
  final String title;
  final String productId;
  final String deltaId;

  ProductDetailPage(
      {Key key,
      @required this.productId,
      this.title,
      @required this.deltaId,
      String deltatId})
      : super(key: key);

  @override
  _ProductDetailPageState createState() =>
      _ProductDetailPageState(productId, deltaId);
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List productsDetailLists = List();
  List productsDetail = List();

  _ProductDetailPageState(String productId, String deltatId);

  Future<dynamic> _fetchData(productId) async => await http
          .get(API.PRODUCT_DETAIL_URL.replaceAll('%', productId), headers: {
        "Content-Type": "application/json",
      }).then((response) {
        // TODO: handle value
        List<dynamic> productDetailsJson = json.decode(response.body);
        debugPrint('productCategoryJson ${productDetailsJson}');
        if (response.statusCode == 200) {
          productsDetail = productDetailsJson;
          return productsDetail;
        }
      }).catchError((error) {
        // TODO: handle value
        debugPrint('error ${error.toString()}');
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

  Widget _loadingController() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          'Loading...',
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        ),
      ),
    );
  }

  Widget _addToCartButton(productId) {
    return InkWell(
      onTap: () {
        /* Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetailPage()));*/
        http.get(API.CART_URL, headers: {
          "Content-Type": "application/json",
        }).then((response) {
          // TODO: handle value
          List<dynamic> cartResponseJson = json.decode(response.body);
          debugPrint('cartResponseJson $cartResponseJson');
          if (response.statusCode == 200) {
            http.post(API.ADD_TO_CART_URL,
                body: json.encode([
                  {
                    "purchased_entity_type": "commerce_product_variation",
                    "purchased_entity_id": productId,
                    "quantity": "1"
                  }
                ]),
                headers: {
                  "Content-Type": "application/json",
                }).then((response) {
              // TODO: handle value
              List<dynamic> addCartResponseJson = json.decode(response.body);
              debugPrint('addCartResponseJson $addCartResponseJson');
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
                height: 30.0,
                width: MediaQuery.of(context).size.width / 5.0,
                //padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    'ADD',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              width: 30.0,
              height: 30.0,
              alignment: Alignment.center,
              //padding: EdgeInsets.all(5.0),
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

  @override
  Widget build(BuildContext context) {
    //_fetchData();
    debugPrint('ProductsDetail ${productsDetail}');
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Product Details'),
          backgroundColor: Colors.green,
          brightness: Brightness.dark,
          actions: <Widget>[
            // _topSearchIcon(),
            // _topShopingCartIcon(),
          ],
        ),
        resizeToAvoidBottomPadding: false,
        body: FutureBuilder(
            future: _fetchData(widget.productId),
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
  }

  bool _selected = true;
  bool isSmall = false;

  Widget gridHeader() {
    return ListView.builder(
        itemCount: productsDetail.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: Image.network(productsDetail[index]['image']),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text(productsDetail[index]['name']),
                    ),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                       children: <Widget>[
                         Row(
                           children: <Widget>[
                             Icon(Icons.star, color: Colors.green, size: 12.0,),
                             Text('4.1', style: TextStyle(color: Colors.green, fontSize: 12.0),),
                           ],
                         ),
                         Text('(ratings)', style: TextStyle(color: Colors.grey, fontSize: 10.0),),
                       ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        productsDetail[index]['sell_price'].split('.')[0],
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        productsDetail[index]['list_price'].split('.')[0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                    Container(
                      //width: MediaQuery.of(context).size.width / 5.5,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
                      //alignment: Alignment.center,
                      child: Text(
                        productsDetail[index]['discount'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),
                    _addToCartButton(productsDetail[index]['id']),
                  ],
                ),
                const Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20.0),
                              child: Text('Unit'),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        child: InkWell(
                                          onTap: () => setState(
                                              () => _selected = !_selected),
                                          child: Container(
                                            // width: 100.0,
                                            //height: 50.0,
                                            padding: EdgeInsets.all(10.0),
                                            decoration: new BoxDecoration(
                                              //color: _selected1 ? Colors.grey : Colors.orange,
                                              border: _selected
                                                  ? Border.all(
                                                      color: Colors.grey,
                                                      width: 2.0)
                                                  : Border.all(
                                                      color: Colors.orange,
                                                      width: 2.0),
                                              // borderRadius: new BorderRadius.circular(10.0),
                                            ),
                                            child: Text(
                                              productsDetail[index]['quantity'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: _selected
                                                    ? Colors.grey
                                                    : Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 5.0,
                  thickness: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 20.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.grey),
                                  ),
                                ),
                                child: TabBar(
                                    labelStyle: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: isSmall ? 12.0 : 16.0),
                                    labelColor: Colors.black,
                                    indicatorColor: Colors.green,
                                    tabs: [
                                      Tab(
                                        text: "Highlights",
                                      ),
                                      Tab(text: "Info"),
                                    ]),
                              ),
                              Container(
                                //Add this to give height
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.grey),
                                  ),
                                ),
                                child: TabBarView(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.grey),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Html(
                                          data: productsDetail[index]
                                              ['description'],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.grey),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Html(
                                          data: productsDetail[index]
                                              ['description'],
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
