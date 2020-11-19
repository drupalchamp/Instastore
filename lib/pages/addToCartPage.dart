import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';

import 'checkOutPage.dart';

class AddToCartPage extends StatefulWidget {
  AddToCartPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  final titles = ['Product Title'];

  final image = [Image.asset('about.jpg')];

  int _n = 0;

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  void add() {
    setState(() {
      _n++;
    });
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
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                elevation: 1.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(7.0),
                              child: Text('M.R.P.'),
                            ),
                          ],
                        ),
                        //Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Spacer(),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(7.0),
                              child: Text('\u20B9200'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(7.0),
                              child: Text('Products Discount'),
                            ),
                          ],
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(7.0),
                              child: Text(
                                '- \u20B950',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(7.0),
                              child: Text('Delivery Charge'),
                            ),
                          ],
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(7.0),
                              child: Text(
                                'FREE',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Sub total',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Flexible(fit: FlexFit.tight, child: SizedBox()),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Text(
                                '\u20B9200',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: Colors.black,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/about.jpg',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  // margin: EdgeInsets.symmetric(vertical: 20.0),
                                  //alignment: Alignment.topLeft,
                                  child: Text(
                                    '\u20b9200',
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
                                    '\u20b9800',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 2.0),
                                  //alignment: Alignment.center,
                                  child: Text(
                                    '75% OFF',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            margin: EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text('Product Title'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      child: Text('2Kg'),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 15.0),
                                      child: Row(
                                        //mainAxisAlignment:
                                        // MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    add();
                                                  }, // handle your onTap here
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.green,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 20.0),
                                                    child: Center(
                                                      child: Text('+',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20.0)),
                                                    ),
                                                  ),
                                                ),
                                                Text('$_n',
                                                    style: new TextStyle(
                                                        fontSize: 15.0)),
                                                InkWell(
                                                  onTap: () {
                                                    minus();
                                                  }, // handle your onTap here
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.green,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        left: 15.0),
                                                    child: Center(
                                                      child: Text('-',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20.0)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 40,
        padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
        color: Colors.green,
        child: Container(
          child: InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CheckOutPage())),
            child: Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Checkout",
                      style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: <Widget>[
                      Text('\u20b9200  \u2192',
                          style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
