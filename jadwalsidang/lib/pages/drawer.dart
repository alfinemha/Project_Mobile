import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/home_page.dart';
import 'package:jadwalsidang/pages/login_page.dart';
import 'package:jadwalsidang/pages/main_page.dart';
import 'package:jadwalsidang/pages/pengajuan_sempro_page.dart';
import 'package:jadwalsidang/pages/profile_page.dart';
import 'package:jadwalsidang/pages/sempro_page.dart';
import 'package:jadwalsidang/pages/setting_page.dart';
import 'package:jadwalsidang/pages/skripsi_page.dart';
import 'package:jadwalsidang/pages/tab_page.dart';
import 'package:jadwalsidang/state/mahasiswa_state.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: CircleAvatar(
                    backgroundImage: MahasiswaState.getMahasiswa()['photo'] !=
                            null
                        ? NetworkImage(
                            MahasiswaState.getMahasiswa()['photo'].toString())
                        : NetworkImage(
                            "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1214428300?k=20&m=1214428300&s=170667a&w=0&h=NPyJe8rXdOnLZDSSCdLvLWOtIeC9HjbWFIx8wg5nIks="),
                    radius: 30,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  MahasiswaState.getMahasiswa()['nama'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  MahasiswaState.getMahasiswa()['email'],
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.upload_file),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Pengajuan'),
                )
              ],
            ),
            onTap: () {
              BottomSheetFeedback.pengajuan(context);
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TabPage()));
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.settings),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Setting'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage()));
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
