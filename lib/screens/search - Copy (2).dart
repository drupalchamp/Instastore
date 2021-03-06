import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instastore/utils/connectivity_state.dart';
import 'package:instastore/utils/locator.dart';
import 'package:instastore/models/brand.dart';
import 'package:instastore/models/category.dart';
import 'package:instastore/models/product.dart';
import 'package:instastore/scoped-models/main.dart';
import 'package:instastore/utils/constants.dart';
import 'package:instastore/utils/headers.dart';
import 'package:instastore/widgets/product_container.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductSearch extends StatefulWidget {
  final String slug;
  ProductSearch({this.slug});
  @override
  State<StatefulWidget> createState() {
    return _ProductSearchState();
  }
}

class _ProductSearchState extends State<ProductSearch> {
  String slug = '';
  TextEditingController _controller = TextEditingController();
  // List<SearchProduct> searchProducts = [];
  List<Product> searchProducts = [];
  bool _isLoading = false;
  Product tappedProduct = Product();
  final int perPage = TWENTY;
  int currentPage = ONE;
  int subCatId = ZERO;
  bool isSearched = false;
  Size _deviceSize;
  int totalCount = 0;
  static const int PAGE_SIZE = 20;
  final scrollController = ScrollController();
  bool hasMore = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Category> _listViewData = [];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentItem;
  Map<dynamic, dynamic> responseBody;
  List<Brand> brands = [];
  List<Product> productsByBrand = [];
  String sortBy = '';
  List filterItems = [
    "Newest",
    "Avg.Customer Review",
    "Most Reviews",
    "A TO Z",
    "Z TO A",
    "Highest to Lowest"
  ];
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in filterItems) {
      items.add(new DropdownMenuItem(
        value: city,
        child: Text(
          city,
        ),
      ));
    }
    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sortBy = '';
    _dropDownMenuItems = getDropDownMenuItems();
    _currentItem = _dropDownMenuItems[0].value;
    if (widget.slug != null) {
      print("SLUG AVAILABLE ${widget.slug}");
      setState(() {
        slug = widget.slug;
        isSearched = true;
        searchProducts = [];
        currentPage = 1;
      });
      searchProduct();
    }
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        searchProduct();
      }
    });
    getBrandsList();
    locator<ConnectivityManager>().initConnectivity(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locator<ConnectivityManager>().dispose();
  }

  @override
  Widget build(BuildContext mainContext) {
    _deviceSize = MediaQuery.of(mainContext).size;
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Container(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    slug = value;
                  });
                },
                onSubmitted: (value) {
                  isSearched = true;
                  searchProducts = [];
                  currentPage = 1;
                  searchProduct();
                  // print("ENTER PRESSED ------> $value");
                },
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
              ),
            ),
            actions: <Widget>[
              Visibility(
                visible: slug != null && slug.isNotEmpty,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      slug = '';
                      setState(() {
                        searchProducts.clear();
                      });
                    });
                  },
                ),
              ),
            ],
          ),
          endDrawer: filterDrawer(),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: isSearched && !model.isLoading
                    ? Theme(
                        data: ThemeData(primarySwatch: Colors.green),
                        child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: searchProducts.length + 1,
                            itemBuilder: (mainContext, index) {
                              print("index ${index}");
                              print("index searchProducts ${searchProducts.length}");
                              if (index < searchProducts.length) {
                                final f = searchProducts[index];
                                return productContainer(
                                    _scaffoldKey.currentContext,
                                    f,
                                    index);
                              }
                              if (hasMore && searchProducts.length == 0) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50.0),
                                  child: Center(
                                    child: Text(
                                      'No Product Found',
                                      style: TextStyle(fontSize: 20.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                              if (!hasMore || model.isLoading) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      )
                    : Container(),
              ),
              Visibility(
                  visible: searchProducts.length > 0,
                  child: Material(
                    elevation: 2.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 16.0),
                        child: Text(
                          '$totalCount Results',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  )),
              /*Visibility(
                visible: searchProducts.length > 0,
                child: Container(
                  padding: EdgeInsets.only(right: 20.0, top: 20.0),
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),*/
              Visibility(
                  visible: model.isLoading,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  )),
              // )
            ],
          ));
    });
  }

  Future<List<Product>> searchProduct() async {
    Map<String, String> headers = await getHeaders();
    Map<String, dynamic> responseBody = Map();
    print('SENDING REQUEST $slug');
    setState(() {
      hasMore = false;
    });
    print(Settings.SERVER_URL +
        'api/v1/products?q[name_cont_all]=$slug&page=$currentPage&per_page=$perPage&q[s]=$sortBy&data_set=small');
    print('http://instastore.responsivewebsolution.com/api/product/search?_format=json&search=$slug');
    http.Response response;
    if (sortBy != null) {
      /*response = await http.get(
          Settings.SERVER_URL +
              'api/v1/products?q[name_cont_all]=$slug&page=$currentPage&per_page=$perPage&q[s]=$sortBy&data_set=small',
          headers: headers);*/
          response = await http.get('http://instastore.responsivewebsolution.com/api/product/search?_format=json&search=$slug',
              headers: headers);
          debugPrint("response1 ${response}");
    } else {
      print("searching $slug");
      /*response = await http.get(
          Settings.SERVER_URL +
              'api/v1/products?q[name_cont_all]=$slug&page=$currentPage&per_page=$perPage&data_set=small',
          headers: headers);*/
      response = await http.get('http://instastore.responsivewebsolution.com/api/product/search?_format=json&search=$slug',
          headers: headers);
      debugPrint("response2 ${response}");
    }
    currentPage++;
    responseBody = json.decode(response.body);
    List<dynamic> responseBodyJsonResults = responseBody['results'];
    searchProducts = [];
    responseBodyJsonResults.forEach((searchObj) {
      debugPrint("searchObj ${searchObj['avg_rating'].split('*')[0]}");

      searchProducts.add(Product(
          id: int.parse(searchObj['id']),
          reviewProductId: int.parse(searchObj['id']),
          name: searchObj['name'],
          image: searchObj['image'],
          currencySymbol: '₹',
          displayPrice: searchObj['displayPrice'],
          price: searchObj['price'],
          costPrice: searchObj['costPrice'],
          slug: searchObj['slug'],
          //avgRating: double.parse(searchObj['attributes']['avg_rating']),
          //reviewsCount: searchObj['attributes']['reviews_count'].toString()));
          avgRating: (searchObj['avg_rating'] != '') ? double.parse(searchObj['avg_rating'].split('*')[0]) : double.parse("0"),
          reviewsCount: '500'));
    });
    totalCount = (responseBodyJsonResults.length > 0) ? int.parse(responseBody['pager']['count']) : 0;
    setState(() {
      hasMore = true;
      _isLoading = false;
    });

    print(hasMore);
    print('length');
    print('length ${searchProducts.length}');

    return searchProducts;
  }

  Widget filterDrawer() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 3.0,
            child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.orange,
                height: 150.0,
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text(
                        'Sort By:  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0),
                      ),
                      DropdownButton(
                        underline: Container(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal),
                        hint: Text(
                          _currentItem,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                        value: null,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      )
                    ],
                  ),
                )),
          ),
          Expanded(
            child: Theme(
                data: ThemeData(primarySwatch: Colors.green),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          productsByBrand = [];
                          setState(() {
                            _isLoading = true;
                            slug = brands[index].name;
                            isSearched = true;
                            searchProducts = [];
                            currentPage = 1;
                            searchProduct();
                          });
                        },
                        child: Container(
                            width: _deviceSize.width,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              brands[index].name,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )));
                  },
                  itemCount: brands.length,
                )),
          ),
        ],
      ),
    );
  }

  getBrandsList() {
    http
        .get(Settings.SERVER_URL +
            'api/v1/taxonomies?q[name_cont]=Brands&set=nested')
        .then((response) {
      responseBody = json.decode(response.body);
      responseBody['taxonomies'][0]['root']['taxons'].forEach((brandObj) {
        setState(() {
          brands.add(Brand(name: brandObj['name'], id: brandObj['id']));
        });
      });
    });
  }

  void changedDropDownItem(String selectedCity) {
    String sortingWith = '';
    setState(() {
      _currentItem = selectedCity;
      switch (_currentItem) {
        case 'Newest':
          sortingWith = 'updated_at+asc';
          break;
        case 'Avg.Customer Review':
          sortingWith = 'avg_rating+desc ';
          break;
        case 'Most Reviews':
          sortingWith = 'reviews_count+desc';
          break;
        case 'A TO Z':
          sortingWith = 'name+asc';
          break;
        case 'Z TO A':
          sortingWith = 'name+desc';
          break;
      }
      isSearched = true;
      searchProducts = [];
      currentPage = 1;
      this.sortBy = sortingWith;
      searchProduct();
    });
  }
}
