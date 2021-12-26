import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/pages/drawer_admin.dart';
import 'package:jadwalsidang/pages/home_page.dart';
import 'package:jadwalsidang/theme.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: Text('Home'),
          // automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(child: HomePage()),
        drawer: DrawerAdminWidget());
  }
}
