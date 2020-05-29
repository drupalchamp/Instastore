import 'dart:io';
import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery/image_gallery.dart';
import 'package:instastore/src/Widget/nav-drawer.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _GalleryPageState createState() => new _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  Map<dynamic, dynamic> allImageInfo = new HashMap();
  List allImage = new List();
  List allNameList = new List();

  @override
  void initState() {
    super.initState();
    loadImageList();
  }

  Future<void> loadImageList() async {
    Map<dynamic, dynamic> allImageTemp;
    allImageTemp = await FlutterGallaryPlugin.getAllImages;
    print(" call $allImageTemp.length");

    setState(() {
      this.allImage = allImageTemp['URIList'] as List;
      this.allNameList = allImageTemp['DISPLAY_NAME'] as List;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Gallery';
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text(appTitle),
          backgroundColor: Colors.green,
          brightness: Brightness.dark,
        ),
        body: _buildGrid(),
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.extent(
        maxCrossAxisExtent: 150.0,
        // padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _buildGridTileList(allImage.length));
  }

  List<Container> _buildGridTileList(int count) {
    return List<Container>.generate(
        count,
        (int index) => Container(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.file(
                  File(allImage[index].toString()),
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                )
              ],
            )
        ));
  }
}
