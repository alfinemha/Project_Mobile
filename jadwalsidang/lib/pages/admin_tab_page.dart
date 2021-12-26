import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/pages/admin_sempro_page.dart';
import 'package:jadwalsidang/pages/admin_skripsi_page.dart';
import 'package:jadwalsidang/pages/drawer.dart';
import 'package:jadwalsidang/pages/drawer_admin.dart';
import 'package:jadwalsidang/theme.dart';

class AdminTabPage extends StatefulWidget {
  @override
  _AdminTabPageState createState() => _AdminTabPageState();
}

class _AdminTabPageState extends State<AdminTabPage>
    with SingleTickerProviderStateMixin {
  //create controller untuk tabBar
  late TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: primaryBlue,
        title: new Text("Jadwal"),
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(
              text: 'SEMPRO',
            ),
            new Tab(
              text: 'SIDANG',
            ),
          ],
        ),
      ),
      body: new TabBarView(
        //controller untuk tab bar
        controller: controller,
        children: <Widget>[
          AdminSemproWidget(),
          AdminSkripsiWidget(),
        ],
      ),
      drawer: DrawerAdminWidget(),
    );
  }
}
