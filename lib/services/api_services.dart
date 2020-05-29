import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class API {
  static final BASE_URL = "http://instastore.responsivewebsolution.com";
  static final SESSION_TOKEN_URL = BASE_URL + "/session/token";
  static final LOGIN_URL = BASE_URL + "/user/login?_format=json";
  static final REGISTER_URL = BASE_URL + "/user/register?_format=json";
  static final PRODUCT_CATEGORY_URL = BASE_URL + "/api/product-categories?_format=json";
  static final CATEGORY_PRODUCTS_URL = BASE_URL + "/api/category/%/products?_format=json";
}

class APIServices {
  // Token API
  static Future<String> getToken() async =>
      await http.get(API.SESSION_TOKEN_URL).then((response) {
        // TODO: handle value
        return response.body;
      }).catchError((error) {
        // TODO: handle value
        Fluttertoast.showToast(
            msg: error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });

  // User Login API
  static Future<dynamic> userLogin(token, body) async =>
      await http.post(API.LOGIN_URL, body: json.encode(body), headers: {
        "Content-Type": "application/json",
        'X-CSRF-Token': token,
      }).then((response) {
        debugPrint('token ${token}');
        debugPrint('body ${body}');
        // TODO: handle value
        Map<String, dynamic> loginResponseJson = json.decode(response.body);
        debugPrint('loginResponseJson ${loginResponseJson}');
        if (response.statusCode == 200) {
          return loginResponseJson;
        } else {
          Fluttertoast.showToast(
              msg: loginResponseJson['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          throw Error();
        }
      }).catchError((error) {
        // TODO: handle value
        debugPrint('error ${error.toString()}');
      });

  // User Login API
  static Future<dynamic> getProductCategory() async =>
      await http.get(API.PRODUCT_CATEGORY_URL, headers: {
        "Content-Type": "application/json",
      }).then((response) {
        // TODO: handle value
        List<dynamic> productCategoryJson = json.decode(response.body);
        //debugPrint('productCategoryJson ${productCategoryJson}');
        if (response.statusCode == 200) {
          return productCategoryJson;
        } else {
          /*Fluttertoast.showToast(
              msg: productCategoryJson['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );*/
          throw Error();
        }
      }).catchError((error) {
        // TODO: handle value
        debugPrint('error ${error.toString()}');
      });

  // User Login API
  static Future<dynamic> getCategoryProducts(categoryId) async =>
      await http.get(API.CATEGORY_PRODUCTS_URL.replaceAll('%', categoryId), headers: {
        "Content-Type": "application/json",
      }).then((response) {
        // TODO: handle value
        //debugPrint('categoryProductsJson ${response.body}');
        List<dynamic> categoryProductsJson = json.decode(response.body);
        //debugPrint('categoryProductsJson ${categoryProductsJson}');
        if (response.statusCode == 200) {
          return categoryProductsJson;
        } else {
          throw Error();
        }
      }).catchError((error) {
        // TODO: handle value
        debugPrint('error ${error.toString()}');
      });
}
