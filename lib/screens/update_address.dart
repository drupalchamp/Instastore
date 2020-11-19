import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instastore/scoped-models/main.dart';
import 'package:instastore/models/address.dart';
import 'package:instastore/utils/connectivity_state.dart';
import 'package:instastore/utils/constants.dart';
import 'package:instastore/utils/locator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateAddress extends StatefulWidget {
  final bool order;
  final Address shipAddress;
  UpdateAddress(this.shipAddress, this.order);
  @override
  State<StatefulWidget> createState() {
    return _UpdateAddressState();
  }
}

class _UpdateAddressState extends State<UpdateAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _profile_id = 0;
  bool _countryEmpty = false;
  bool _isCountryChecked = false;
  bool _isLoading = false;
  String _firstName = '';
  String _lastName = '';
  String _companyName = '';
  String selectedCountry = 'Country';
  String _address1 = '';
  String _address2 = '';
  String _city = '';
  String _stateName = '';
  String _mobile = '';
  String _pincode = '';
  bool _isDefault = false;
  String _countryCode = '';
  Map<String, dynamic> data = Map();
  Map<String, dynamic> address = Map();
  Map<String, String> headers = Map();
  String url = '';
  static List<Map<String, dynamic>> country = [];
  @override
  void initState() {
    //getCountry();
    // getUserInfo();
    super.initState();
    if (widget.shipAddress != null) {
      _profile_id = widget.shipAddress.id;
      _isCountryChecked = true;
      selectedCountry = widget.shipAddress.countryName;
      _countryCode = widget.shipAddress.countryAbbr;
      _firstName = widget.shipAddress.firstName;
      _lastName = widget.shipAddress.lastName;
      _companyName = widget.shipAddress.companyName;
      _address1 = widget.shipAddress.address1;
      _address2 = widget.shipAddress.address2;
      _city = widget.shipAddress.city;
      _stateName = widget.shipAddress.stateName;
      _pincode = widget.shipAddress.pincode;
      _mobile = widget.shipAddress.mobile;
      _isDefault = widget.shipAddress.isDefault;
    }
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
        appBar: AppBar(
          centerTitle: false,
          title: Text(
              widget.shipAddress != null ? 'Update Address' : 'Add Address'),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: _isLoading
              ? PreferredSize(
                  child: LinearProgressIndicator(),
                  preferredSize: Size.fromHeight(10),
                )
              : PreferredSize(
                  child: Container(),
                  preferredSize: Size.fromHeight(10),
                ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(4),
              child: IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  submitAddress(model);
                },
              ),
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(25),
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              buildFirstNameField('First Name'),
              SizedBox(
                height: 40,
              ),
              buildLastNameField('Last Name'),
              SizedBox(
                height: 40,
              ),
              buildCompanyField('Organisation Name'),
              SizedBox(
                height: 40,
              ),
              buildAddressField('Street Address'),
              SizedBox(
                height: 40,
              ),
              buildTownField('City/Town'),
              SizedBox(
                height: 40,
              ),
              buildCityField('District'),
              SizedBox(
                height: 40,
              ),
              buildStateField('State'),
              SizedBox(
                height: 40,
              ),
              buildPinCodeField('Pincode'),
              SizedBox(
                height: 40,
              ),
              sendButton(),
            ],
          ),
        ),
      );
    });
  }

  Widget buildFirstNameField(String label) {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'First Name is required';
        }
      },
      decoration: inputDecoration(label),
      initialValue: _firstName,
      onChanged: (String value) {
        setState(() {
          _firstName = value;
        });
      },
    );
  }

  Widget buildLastNameField(String label) {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last Name is required';
        }
      },
      decoration: inputDecoration(label),
      initialValue: _lastName,
      onChanged: (String value) {
        setState(() {
          _lastName = value;
        });
      },
    );
  }

  Widget buildCompanyField(String label) {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Organisation Name is required';
        }
      },
      decoration: inputDecoration(label),
      initialValue: _companyName,
      onChanged: (String value) {
        setState(() {
          _companyName = value;
        });
      },
    );
  }

  Widget buildAddressField(String label) {
    return TextFormField(
      // maxLines: 5,
      initialValue: _address1,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is required';
        }
      },
      decoration: inputDecoration(label),
      onChanged: (String value) {
        setState(() {
          _address1 = value;
        });
      },
    );
  }

  Widget buildTownField(String label) {
    return TextFormField(
      initialValue: _address2,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Locality/Town is required';
        }
      },
      decoration: inputDecoration(label),
      onChanged: (String value) {
        setState(() {
          _address2 = value;
        });
      },
    );
  }

  Widget buildCityField(String label) {
    return TextFormField(
      initialValue: _city,
      validator: (String value) {
        if (value.isEmpty) {
          return 'City is required';
        }
      },
      decoration: inputDecoration(label),
      onChanged: (String value) {
        setState(() {
          _city = value;
        });
      },
    );
  }

  Widget buildStateField(String label) {
    return TextFormField(
      // maxLines: 5,
      initialValue: _stateName,
      validator: (String value) {
        if (value.isEmpty) {
          return 'State is required';
        }
      },
      decoration: inputDecoration(label),
      onChanged: (String value) {
        setState(() {
          _stateName = value;
        });
      },
    );
  }

  Widget buildCountryField(String label) {
    List<CupertinoActionSheetAction> actions = country.map((item) {
      return CupertinoActionSheetAction(
        child: Text(
          item['name'],
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey.shade500),
        ),
        onPressed: () {
          Navigator.pop(context, item['code']);
        },
      );
    }).toList();
    return GestureDetector(
        onTap: () {
          containerForSheet<String>(
            context: context,
            child: CupertinoActionSheet(
              title: Text(
                'Select country',
                style: TextStyle(color: Colors.grey.shade500),
              ),
              actions: actions,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.40,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  selectedCountry,
                  style: TextStyle(
                      color: _isCountryChecked
                          ? Colors.black
                          : Colors.grey.shade500,
                      fontSize: 16),
                )),
            SizedBox(
              height: 6,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Divider(
                // endIndent: ,
                color: Colors.black,
              ),
            ),
            _countryEmpty
                ? Text(
                    "Country is required.",
                    style: TextStyle(color: Colors.red),
                  )
                : Container()
          ],
        ));
  }

  Widget buildMobileField(String label) {
    return TextFormField(
      initialValue: _mobile,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mobile No. is required!';
        } else if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Please enter numeric value only';
        } else if (value.trim().length != 10) {
          return 'Mobile No. should be 10 digits only!';
        }
      },
      decoration: inputDecoration(label),
      onSaved: (String value) {
        setState(() {
          _mobile = value;
        });
      },
    );
  }

  Widget buildPinCodeField(String label) {
    return TextFormField(
      initialValue: _pincode,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pincode is required!';
        } else if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Please enter numeric value only';
        } else if (value.trim().length != 6) {
          return 'Pincode should be 6 digits only!';
        }
      },
      decoration: inputDecoration(label),
      onSaved: (String value) {
        setState(() {
          _pincode = value;
        });
      },
    );
  }

  getCountry() async {
    Map<String, dynamic> countryResponse;
    http.Response response = await http.get(
        'http://instastore.responsivewebsolution.com/api/country?_format=json');

    countryResponse = json.decode(response.body);
    print("countryResponse $countryResponse");
    countryResponse['country'].forEach((countries) {
      print("country $countries");
      setState(() {
        country.add(countries);
      });
    });
    if (widget.shipAddress == null) {
      setState(() {
        selectedCountry = 'Country';
      });
    }
  }

  void containerForSheet<Map>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<Map>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((Map value) {
      setState(() {
        if (value == null) {
          selectedCountry = 'Country';
        } else {
          _isCountryChecked = true;
          _countryEmpty = false;
          selectedCountry = value.toString();
          country.forEach((country) {
            if (country.containsValue(value.toString())) {
              _countryCode = country['code'];
            }
          });
        }
      });
    });
  }

  submitAddress(MainModel model) async {
    Map<dynamic, dynamic> updateResponse;
    Map<dynamic, dynamic> orderUpdateResponse;

    debugPrint("Submit Address");

    if (!_formKey.currentState.validate()) {
      debugPrint("Submit Validate");
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    // getUserInfo();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    address = {
      "profile_id": _profile_id,
      "country_code": 'IN',
      "address_line1": _address1,
      "address_line2": _address2,
      "administrative_area": _stateName,
      "family_name": _lastName,
      "given_name": _firstName,
      "locality": _city,
      "organization": _companyName,
      "postal_code": _pincode,
      "is_default": (_isDefault) ? 1 : 0,
    };
    debugPrint("address $address");

    if(widget.shipAddress == null) {
      http.Response response = await http.post(
          'http://instastore.responsivewebsolution.com/api/add/1/address?_format=json',
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(address));
      updateResponse = json.decode(response.body);
      debugPrint("address $updateResponse");
      if (response.statusCode == 200) {
        await model.getAddress();
        setState(() {
          _isLoading = false;
        });
        _showSuccessDialog(context);
      }
    }else {
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
        setState(() {
          _isLoading = false;
        });
        _showSuccessDialog(context);
      }
    }
  }

  Widget sendButton() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return FlatButton(
        color: Colors.deepOrange,
        onPressed: () {
          submitAddress(model);
        },
        child: Text(
          'SAVE ADDRESS',
          style: TextStyle(color: Colors.white),
        ),
      );
    });
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

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey.shade500),
        contentPadding: EdgeInsets.all(0.0));
  }
}
