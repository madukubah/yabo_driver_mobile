import 'dart:async';
import 'package:flutter/material.dart';
import '../../util/AppConstants.dart';
import 'MutationTab.dart';
import 'RequestTab.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
     TabController controller;

  @override
  void initState() {
    super.initState();
      // Initialize the Tab Controller
    controller = TabController(length: 3, vsync: this);
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        // Title
        title: Text( "${AppConstants.APP_NAME}"),
        // Set the background color of the App Bar
        backgroundColor: Colors.blue,
      ),
      // Set the TabBar view as the body of the Scaffold
      body: TabBarView(
        // Add tabs as widgets
        children: <Widget>[ MutationTab(), RequestTab( ), Text('data') ],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.blue,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Icon(Icons.credit_card),
              text: 'Mutasi',
            ),
            Tab(
              icon: Icon(Icons.airport_shuttle),
              text: 'Penjemputan',
            ),
            Tab(
              icon: Icon(Icons.person),
              text: 'Profil',
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}
