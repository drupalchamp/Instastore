import 'package:flutter/material.dart';

import 'package:instastore/pages/homePage.dart';
import 'package:instastore/pages/loginPage.dart';
import 'package:instastore/pages/myProfilePage.dart';
import 'package:instastore/pages/myOrderPage.dart';
import 'package:instastore/pages/aboutPage.dart';
import 'package:instastore/pages/contactPage.dart';
import 'package:instastore/pages/paymentPage.dart';
import 'package:instastore/pages/testingPage.dart';
import 'package:instastore/pages/addToCartPage.dart';
import 'package:instastore/scoped-models/main.dart';
import 'package:instastore/screens/address.dart';
import 'package:instastore/screens/auth.dart';
import 'package:instastore/screens/my_address.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model)
    {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/menu.jpg')
                  )
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text('My Profile'),
              onTap: () {
                if (model.isAuthenticated) {
                  MaterialPageRoute account =
                  MaterialPageRoute(builder: (context) => MyProfilePage());
                  Navigator.push(context, account);
                } else {
                  MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => Authentication(0));

                  Navigator.push(context, route);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text('My Address'),
              onTap: () {
                if (model.isAuthenticated) {
                  MaterialPageRoute account =
                  MaterialPageRoute(builder: (context) => MyAddressPage());
                  Navigator.push(context, account);
                } else {
                  MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => Authentication(0));

                  Navigator.push(context, route);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.local_mall),
              title: Text('My Order'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyOrderPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text('Add to Cart'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddToCartPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Payment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.compare),
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
            ),
            logOutButton(),
            /*ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                _showDialog(context, model);
              },
            )*/
            ListTile(
              leading: Icon(Icons.adb),
              title: Text('Testing Page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestingPage(),
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  String userName = '';
  Widget logOutButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.isAuthenticated) {
          return ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.grey,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              // logoutUser(model);
              _showDialog(context, model);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _showDialog(context, model) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sign Out"),
            content: new Text("Are you sure you want to sign out?"),
            actions: <Widget>[
              new FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  logoutUser(model);
                },
              )
            ],
          );
        });
  }

  logoutUser(MainModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    model.clearData();
    model.loggedInUser();
    model.fetchCurrentOrder();
  }
}