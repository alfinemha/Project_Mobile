import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/admin_home_page.dart';
import 'package:jadwalsidang/pages/admin_mahasiswa_page.dart';
import 'package:jadwalsidang/pages/admin_tab_page.dart';
import 'package:jadwalsidang/pages/home_page.dart';
import 'package:jadwalsidang/pages/login_page.dart';
import 'package:jadwalsidang/pages/main_page.dart';
import 'package:jadwalsidang/pages/pengajuan_sempro_page.dart';
import 'package:jadwalsidang/pages/profile_page.dart';
import 'package:jadwalsidang/pages/sempro_page.dart';
import 'package:jadwalsidang/pages/setting_page.dart';
import 'package:jadwalsidang/pages/skripsi_page.dart';
import 'package:jadwalsidang/pages/tab_page.dart';
import 'package:jadwalsidang/state/admin_state.dart';
import 'package:jadwalsidang/state/mahasiswa_state.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;

class DrawerAdminWidget extends StatefulWidget {
  const DrawerAdminWidget({Key? key}) : super(key: key);

  @override
  _DrawerAdminWidgetState createState() => _DrawerAdminWidgetState();
}

class _DrawerAdminWidgetState extends State<DrawerAdminWidget> {
  Future _logout() async {
    var url = Uri.parse(GlobalConstant.baseUrl + '/admin/logout');
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
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 16),
            color: primaryBlue,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1214428300?k=20&m=1214428300&s=170667a&w=0&h=NPyJe8rXdOnLZDSSCdLvLWOtIeC9HjbWFIx8wg5nIks="),
                  radius: 30,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  AdminState.getAdmin()['nama'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  AdminState.getAdmin()['email'],
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.home),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Home'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()));
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.people),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Mahasiswa'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminMahasiswaPage()));
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.calendar_today),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Jadwal'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminTabPage()));
            },
          ),
          ListTile(
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.red),
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }
}
