import 'package:flutter/material.dart';
import 'package:instastore/pages/homePage.dart';
import 'package:instastore/pages/loginPage.dart';
import 'package:instastore/pages/myProfilePage.dart';
import 'package:instastore/pages/settingPage.dart';
import 'package:instastore/pages/feedbackPage.dart';
import 'package:instastore/pages/myOrderPage.dart';
import 'package:instastore/pages/aboutPage.dart';
import 'package:instastore/pages/contactPage.dart';
import 'package:instastore/pages/liveSupportPage.dart';
import 'package:instastore/pages/helpPage.dart';
import 'package:instastore/pages/paymentPage.dart';
import 'package:instastore/pages/testingPage.dart';
import 'package:instastore/pages/wishListPage.dart';
import 'package:instastore/pages/addToCartPage.dart';
import 'package:instastore/src/Widget/slideShow.dart';


class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 50, fontWeight:FontWeight.bold),
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
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_mall),
            title: Text('My Order'),
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyOrderPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Wishlists'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistPage(),
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
            leading: Icon(Icons.image),
            title: Text('Slideshow'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarouselDemo(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.compare),
            title: Text('About Us'),
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contact'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('24X7 Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LiveSupportPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
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
  }
}