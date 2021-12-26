import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/detail_sempro_page.dart';
import 'package:jadwalsidang/pages/drawer.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;
import 'package:jadwalsidang/widgets/sempro.dart';

class SemproPage extends StatefulWidget {
  const SemproPage({Key? key}) : super(key: key);

  @override
  _SemproPageState createState() => _SemproPageState();
}

class _SemproPageState extends State<SemproPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: Text('Data sempro'),
          // automaticallyImplyLeading: false,
        ),
        body: SemproWidget(),
        drawer: DrawerWidget());
  }
}
