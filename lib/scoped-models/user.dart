import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:instastore/utils/constants.dart';
import 'package:instastore/models/address.dart';
import 'package:instastore/utils/headers.dart';
import 'package:instastore/scoped-models/main.dart';

mixin UserModel on Model {
  bool _isAuthenticated = false;
  MainModel model;
  List<Address> _shipAddress = [];

  bool get isAuthenticated {
    return _isAuthenticated;
  }

  List<Address> get shipAddress {
    return _shipAddress;
  }

  void set shipAddress(addr) {
    _shipAddress = addr;
    notifyListeners();
  }

  loggedInUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('spreeApiKey');
    if (token != null) {
      _isAuthenticated = true;
      notifyListeners();
    } else {
      _isAuthenticated = false;
      notifyListeners();
    }
  }

  getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = await getHeaders();
    List<dynamic> responseBody = List();
    http.Response response = await http.get(
        'http://instastore.responsivewebsolution.com/api/${prefs.getInt('id')}/address?_format=json',
        headers: headers);
    responseBody = json.decode(response.body);
    debugPrint("responseBody ${responseBody}");
    if (responseBody.length > 0) {
      debugPrint("address length ${responseBody.length}");
      _shipAddress = [];
      responseBody.forEach((address) {
        debugPrint("address ${address}");
        _shipAddress.add(Address(
          id: int.parse(address['profile_id']),
          countryName: address['country_name'],
          countryAbbr: address['country_code'],
          firstName: address['given_name'],
          lastName: address['family_name'],
          companyName: address['organization'],
          address1: address['address_line1'],
          address2: address['address_line2'],
          city: address['locality'],
          stateName: address['administrative_area'],
          pincode: address['postal_code'],
          mobile: '0123456789',
          isDefault: (address['is_default'] == "1") ? true : false,
        ));
      });

      debugPrint('Ship Address ${_shipAddress}');
      notifyListeners();
    } else {
      _shipAddress = [];
    }
  }
}
