import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';

class MyProfilePage extends StatelessWidget {
  final String _fullName = "Kumar Ashutosh";
  final String _points = "173";
  final String _myOrderItems = "24";
  final String _wishlistItems = "450";

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 4.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/cover.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/kumar.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Points", _points),
          _buildStatItem("My Order", _myOrderItems),
          _buildStatItem("Wishlists", _wishlistItems),
        ],
      ),
    );
  }

  //Billing Address

  Widget _billingAddress() {
    return Container(
      margin: EdgeInsets.only(left:20.0, right: 20.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromRGBO(179, 179, 179, 1)),
      alignment: Alignment.topLeft,
      child: Text(
        'BILLING ADDRESS',
        style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 25,
            color: Colors.black),
      ),
    );
  }

  Widget _userBillingAddress() {
    return Column(children: <Widget>[
      Row(
        //ROW 1
        children: [
          Container(
            margin: EdgeInsets.only(left:20.0, right: 20.0),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Email:- ashutosh.drupalchamp@gmail.com',
            softWrap: true,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),

      Row(//ROW 2
          children: [
        Container(
          margin: EdgeInsets.only(left:20.0, right: 20.0),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Address1:- 3RD Floor Savita Complex,',
            softWrap: true,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ]),

      Row(// ROW 3
          children: [
        Container(
          margin: EdgeInsets.only(left:20.0, right: 20.0),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Address2:- Mithanpura, Near Grand Mall',
            softWrap: true,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ]),
      Row(// ROW 3
          children: [
        Container(
          margin: EdgeInsets.only(left:20.0, right: 20.0),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'PinCode:- 842002',
            softWrap: true,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ]),
      Row(// ROW 3
          children: [
        Container(
          margin: EdgeInsets.only(left:20.0, right: 20.0),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'City:- Muzaffarpur',
            softWrap: true,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ]),
      Row(// ROW 3
          children: [
        Container(
          margin: EdgeInsets.only(left:20.0, right: 20.0),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'State:- Bihar',
            softWrap: true,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ]),
      Row(// ROW 3
          children: [
        Container(
          margin: EdgeInsets.only(left:20.0, right: 20.0),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Country:- India',
            softWrap: true,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ]),
      Row(// ROW 3
          children: [
        Container(
          margin: EdgeInsets.only(left:20.0, right: 20.0),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Mob. No:- 9876543210',
            softWrap: true,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ]),
    ]);
  }


  Widget _editButton() {
    return InkWell(
      onTap: () => null,
      child: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.green),
        child: Text(
          'Edit Profile \u{270D}',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'My Profile';
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
        title: appTitle,
        home: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            title: Text(appTitle),
            backgroundColor: Colors.green,
            brightness: Brightness.dark,
          ),
          body: Stack(
            children: <Widget>[
              _buildCoverImage(screenSize),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 6.4),
                      _buildProfileImage(),
                      _buildFullName(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildStatContainer(),
                      SizedBox(height: 20.0),
                      _billingAddress(),
                      SizedBox(height: 20.0),
                      _userBillingAddress(),
                      SizedBox(height:50.0),
                      _editButton(),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
