import 'package:flutter/material.dart';
import 'package:flutterrestapi/src/View/AddUser_view.dart';
import 'package:flutterrestapi/src/View/HomePage_view.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class App extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("List User", Icons.info),
    new DrawerItem("List Transaksi", Icons.info),
    new DrawerItem("List Hadiah", Icons.info)
  ];

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeScreen();
      case 1:
        return new HomeScreen();
      case 2:
        return new HomeScreen();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
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
                var result = await Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return AddUser();
                  }),
                );
                if (result != null) {
                  setState(() {});
                }
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
        // drawer: Drawer(
        //   child: ListView(
        //     children: [
        //       DrawerHeader(
        //         child: Text(
        //           "Menu Admin",
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //         ),
        //       ),
        //       ListTile(
        //         title: Text(
        //           "List User",
        //           style: TextStyle(
        //             color: Colors.black,
        //           ),
        //         ),
        //         onTap: () {
        //           Navigator.of(context)
        //               .pushReplacement(new MaterialPageRoute(builder: (_) {
        //             return new App();
        //           }));
        //         },
        //       ),
        //       ListTile(
        //         title: Text(
        //           "List Transaksi",
        //           style: TextStyle(
        //             color: Colors.black,
        //           ),
        //         ),
        //         onTap: () {},
        //       ),
        //       ListTile(
        //         title: Text(
        //           "List Hadiah",
        //           style: TextStyle(
        //             color: Colors.black,
        //           ),
        //         ),
        //         onTap: () {},
        //       ),
        //     ],
        //   ),
        // ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );
  }
}
