import 'package:flutter/material.dart';
import 'package:flutterrestapi/src/View/AddTransaksi_view.dart';
import 'package:flutterrestapi/src/View/AddUser_view.dart';
import 'package:flutterrestapi/src/View/AddHadiah_view.dart';
import 'package:flutterrestapi/src/View/HomePage_view.dart';
import 'package:flutterrestapi/src/View/HadiahPage_view.dart';
import 'package:flutterrestapi/src/View/TransaksiPage_view.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class App extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("List User", Icons.people),
    new DrawerItem("List Transaksi", Icons.account_balance_wallet),
    new DrawerItem("List Hadiah", Icons.card_giftcard),
  ];

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedDrawerIndex = 0;
  int _checkActiveDrawer = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        _checkActiveDrawer = 0;
        return new HomeScreen();
      case 1:
        _checkActiveDrawer = 1;
        return new TransaksiScreen();
      case 2:
        _checkActiveDrawer = 2;
        return new HadiahScreen();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.pop(_scaffoldState.currentState.context, true);
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text(
            "Flutter Rest API",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                switch (_checkActiveDrawer) {
                  case 0:
                    var result = await Navigator.push(
                      _scaffoldState.currentContext,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return AddUser();
                      }),
                    );
                    if (result != null) {
                      setState(() {});
                    }
                    break;
                  case 1:
                    var result = await Navigator.push(
                      _scaffoldState.currentContext,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return AddTransaksi();
                      }),
                    );
                    if (result != null) {
                      setState(() {});
                    }
                    break;
                  case 2:
                    var result = await Navigator.push(
                      _scaffoldState.currentContext,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return AddHadiah();
                      }),
                    );
                    if (result != null) {
                      setState(() {});
                    }
                    break;
                }
                // var result = await Navigator.push(
                //   _scaffoldState.currentContext,
                //   MaterialPageRoute(builder: (BuildContext context) {
                //     return AddUser();
                //   }),
                // );
                // if (result != null) {
                //   setState(() {});
                // }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  accountName: new Text("Menu Admin"), accountEmail: null),
              new Column(children: drawerOptions)
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );
  }
}
