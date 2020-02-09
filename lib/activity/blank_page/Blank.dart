
import 'package:yabo_bank/activity/blank_page/view/BlankMVPView.dart';
import 'package:yabo_bank/template/drawer/Menu.dart';
import 'package:yabo_bank/template/drawer/PlainDrawer.dart';
import 'package:yabo_bank/util/AppConstants.dart';
import 'package:flutter/material.dart';

class Blank extends StatefulWidget {
  @override
  _BlankState createState() => _BlankState();
}

class _BlankState extends State<Blank> implements BlankMVPView {
  List<Menu> menus = [
    Menu(title: "Usaha Saya", routename: "/Profile"),
    Menu(title: "Produk Saya", routename: "/Profile"),
    Menu(title: "Galeri", routename: "/Profile"),
    Menu(title: "Pengaturan", routename: "/Profile"),
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${AppConstants.APP_NAME}")),
      drawer: new PlainDrawer(
        menus: menus,
        onTap: ( Menu menu ){
            print( menu.routename );
        },
      ),
      body: new Container(),
    );
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  @override
  void showMessage(String message, int status) {
    // TODO: implement showMessage
  }

  @override
  void showProgress() {
    // TODO: implement showProgress
  }
}
