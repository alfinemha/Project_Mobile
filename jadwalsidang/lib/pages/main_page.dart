import 'package:flutter/material.dart';
import 'package:jadwalsidang/pages/drawer.dart';
import 'package:jadwalsidang/pages/home_page.dart';
import 'package:jadwalsidang/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: Text('Home'),
          // automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(child: HomePage()),
        drawer: DrawerWidget());
  }
}
