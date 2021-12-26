import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/drawer.dart';
import 'package:jadwalsidang/pages/informasi_page.dart';
import 'package:jadwalsidang/pages/login_page.dart';
import 'package:jadwalsidang/pages/profile_page.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future _logout() async {
    var url = Uri.parse(GlobalConstant.baseUrl + '/mahasiswa/logout');
    try {
      var response = await http.post(url,
          headers: {'Authorization': 'Bearer ' + GlobalConstant.getToken()});
      if (response.statusCode == 200) {
        BottomSheetFeedback.success(context, 'Selamat', 'Logout berhasil');
        GlobalConstant.deleteStorage();
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        });
      } else {
        BottomSheetFeedback.error(context, 'Error', 'Logout gagal!');
      }
    } on SocketException {
      BottomSheetFeedback.error(context, 'Error', 'No connection internet');
    } on HttpException {
      BottomSheetFeedback.error(context, 'Error', 'Failed ');
    } on FormatException {
      BottomSheetFeedback.error(context, 'Error', 'Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: Text('Setting'),
          // automaticallyImplyLeading: false,
        ),
        body: Container(
          child: ListView(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.account_circle),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Akun'),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.info_outline),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Informasi'),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InformasiPage()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.logout),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Logout'),
                    )
                  ],
                ),
                onTap: () {
                  _logout();
                },
              ),
            ],
          ),
        ),
        drawer: DrawerWidget());
  }
}
