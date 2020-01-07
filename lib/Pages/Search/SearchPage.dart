import 'package:flutter/material.dart';

import 'SearchResults.dart';

class SerachPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SerachPageState();
  }
}

class _SerachPageState extends State<SerachPage> {
  double width;
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Container(
        child: getSearchContainer(),
      ),
    );
  }

  Widget getSearchContainer() {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          height: 50,
          width: width,
          color: Colors.green,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    autofocus: true,
                    controller: _searchController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SearchResults(_searchController),
        ),
      ],
    ));
  }
}
