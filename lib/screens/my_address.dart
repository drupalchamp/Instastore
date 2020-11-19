import 'package:flutter/material.dart';
import 'package:instastore/models/address.dart';
import 'package:instastore/scoped-models/main.dart';
import 'package:instastore/screens/update_address.dart';
import 'package:instastore/utils/connectivity_state.dart';
import 'package:instastore/utils/locator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyAddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAddressPageState();
  }
}

class _MyAddressPageState extends State<MyAddressPage> {
  bool stateChanged = true;
  final scrollController = ScrollController();
  Address noAddress;
  //final SharedPreferences prefs = await SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {}
    });
    locator<ConnectivityManager>().initConnectivity(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locator<ConnectivityManager>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
              title: Text('Addresses'),
              centerTitle: false,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              bottom: model.isLoading
                  ? PreferredSize(
                      child: LinearProgressIndicator(),
                      preferredSize: Size.fromHeight(10),
                    )
                  : PreferredSize(
                      child: Container(),
                      preferredSize: Size.fromHeight(10),
                    )),
          body: SingleChildScrollView(
              child: model.shipAddress == null
                  ? noAddressPage()
                  : Column(
                      children: <Widget>[
                        model.shipAddress != null
                            ? addressContainer()
                            : Container(),
                      ],
                    )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              MaterialPageRoute payment = MaterialPageRoute(
                  builder: (context) => UpdateAddress(noAddress, false));
              Navigator.push(context, payment);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.deepOrange,
          ));
    });
  }

  Widget textFieldContainer(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 17,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w100),
      ),
    );
  }

  Widget addressContainer() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.shipAddress != null) {
          return Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: model.shipAddress.length + 1,
                itemBuilder: (mainContext, index) {
                  if (index < model.shipAddress.length) {
                    return Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        margin: EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        //elevation: 10,
                        child: new Container(
                          padding: new EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            model.shipAddress[index].firstName +
                                                ' ' +
                                                model.shipAddress[index]
                                                    .lastName,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                          child: FlatButton(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            padding: EdgeInsets.all(0),
                                            child: Text(
                                              'EDIT',
                                              style:
                                                  TextStyle(color: Colors.red),
                                              textAlign: TextAlign.right,
                                            ),
                                            onPressed: () {
                                              MaterialPageRoute payment =
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateAddress(
                                                              model.shipAddress[
                                                                  index],
                                                              false));
                                              Navigator.push(context, payment);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      model.shipAddress[index].address1,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      model.shipAddress[index].address2,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      model.shipAddress[index].city +
                                          ' - ' +
                                          model.shipAddress[index].pincode,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      model.shipAddress[index].stateName,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  new EdgeInsets.only(top: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 24.0,
                                                    width: 24.0,
                                                    child: Checkbox(
                                                      value: (model
                                                              .shipAddress[
                                                                  index]
                                                              .isDefault)
                                                          ? true
                                                          : false,
                                                      checkColor: Colors
                                                          .white, // color of tick Mark
                                                      activeColor: Colors.black,
                                                      onChanged: (bool value) {
                                                        debugPrint(
                                                            "value $value");

                                                        Map<String, dynamic>
                                                            address = Map();
                                                        address = {
                                                          "profile_id": model
                                                              .shipAddress[
                                                                  index]
                                                              .id,
                                                          "country_code": model
                                                              .shipAddress[
                                                                  index]
                                                              .countryAbbr,
                                                          "address_line1": model
                                                              .shipAddress[
                                                                  index]
                                                              .address1,
                                                          "address_line2": model
                                                              .shipAddress[
                                                                  index]
                                                              .address2,
                                                          "administrative_area":
                                                              model
                                                                  .shipAddress[
                                                                      index]
                                                                  .stateName,
                                                          //"country_code": model.shipAddress[index],
                                                          "family_name": model
                                                              .shipAddress[
                                                                  index]
                                                              .lastName,
                                                          "given_name": model
                                                              .shipAddress[
                                                                  index]
                                                              .firstName,
                                                          "locality": model
                                                              .shipAddress[
                                                                  index]
                                                              .city,
                                                          //"organization": model.shipAddress[index],
                                                          "postal_code": model
                                                              .shipAddress[
                                                                  index]
                                                              .pincode,
                                                          //"sorting_code": model.shipAddress[index],
                                                          "is_default":
                                                              (value) ? 1 : 0,
                                                        };
                                                        updateAddress(
                                                            model, address);
                                                      },
                                                    ),
                                                  ),
                                                  new Text(
                                                      "  Use as the default shipping address"),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              Map<String, dynamic> address =
                                                  Map();
                                              address = {
                                                "profile_id":
                                                    model.shipAddress[index].id
                                              };
                                              deleteAddress(model, address);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
          );
        } else
          return Container();
      },
    );
  }

  updateAddress(MainModel model, address) async {
    debugPrint("address $address");
    Map<dynamic, dynamic> updateResponse;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response response = await http.post(
        'http://instastore.responsivewebsolution.com/api/edit/1/address?_format=json',
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(address));
    updateResponse = json.decode(response.body);
    debugPrint("address $updateResponse");
    if (response.statusCode == 200) {
      await model.getAddress();
      // Navigator.pop(context);
      /*setState(() {
        _isLoading = false;
      });*/
      //_showSuccessDialog(context);
    }
  }

  deleteAddress(MainModel model, address) async {
    Map<dynamic, dynamic> updateResponse;
    Map<dynamic, dynamic> orderUpdateResponse;

    debugPrint("Delete Address");

    // getUserInfo();
    //final SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response response = await http.post(
        'http://instastore.responsivewebsolution.com/api/delete/1/address?_format=json',
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(address));
    if (response.statusCode == 204) {
      await model.getAddress();
      /*setState(() {
          _isLoading = false;
        });
        _showSuccessDialog(context);*/
    }
  }

  void _showSuccessDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return AlertDialog(
              title: Text("Address Update"),
              content: new Text("Address updated successfully."),
              actions: <Widget>[
                new FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
        });
  }

  Widget noAddressPage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 220.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  size: 80.0,
                  color: Colors.grey,
                ),
                Center(
                  child: Container(
                    width: 60,
                    height: 8,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  'No Saved Addresses',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5),
                  child: Text(
                    'Let us know where to ship all of your Instastore goodies.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
