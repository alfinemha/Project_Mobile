import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/detail_sempro_page.dart';
import 'package:jadwalsidang/pages/detail_skripsi_page.dart';
import 'package:jadwalsidang/pages/drawer.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;

class SkripsiPage extends StatefulWidget {
  const SkripsiPage({Key? key}) : super(key: key);

  @override
  _SkripsiPageState createState() => _SkripsiPageState();
}

class _SkripsiPageState extends State<SkripsiPage> {
  List _skripsiData = [];
  bool _loading = false;

  Future _getSkripsi() async {
    setState(() {
      _loading = true;
    });
    var url =
        Uri.parse(GlobalConstant.baseUrl + '/mahasiswa/pengajuan/skripsi');
    try {
      var response = await http.get(url,
          headers: {'Authorization': 'Bearer ' + GlobalConstant.getToken()});
      if (response.statusCode == 200) {
        setState(() {
          _loading = false;
          _skripsiData = json.decode(response.body)['data'];
        });
      } else {
        setState(() {
          _skripsiData = [];
          _loading = false;
        });
        BottomSheetFeedback.error(
            context, 'Error', 'Gagal mendapatkan data skripsi!');
      }
    } on SocketException {
      BottomSheetFeedback.error(context, 'Error', 'No connection internet');
      setState(() {
        _loading = false;
      });
    } on HttpException {
      BottomSheetFeedback.error(context, 'Error', 'Failed ');
      setState(() {
        _loading = false;
      });
    } on FormatException {
      BottomSheetFeedback.error(context, 'Error', 'Failed');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getSkripsi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: Text('Data Skripsi'),
          // automaticallyImplyLeading: false,
        ),
        body: _loading
            ? Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(),
              )
            : _skripsiData.isEmpty
                ? Text('Data masih kosong')
                : Container(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                        itemCount: _skripsiData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailSkripsiPage(
                                            id: _skripsiData[index]['id']
                                                .toString(),
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(.2))),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/img/logo.png',
                                              width: 25,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(_skripsiData[index]['status']
                                                        .toString() !=
                                                    'Belum Disetujui'
                                                ? _skripsiData[index]['status']
                                                : 'Tanggal belum ada')
                                          ],
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              _skripsiData[index]['status'],
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: primaryBlue,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Text(
                                              _skripsiData[index]['mahasiswa']
                                                  ['nim'],
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _skripsiData[index]['mahasiswa']
                                              ['nama'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 5,
                                      child: Container(
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                            Text(_skripsiData[index]['judul']))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
        drawer: DrawerWidget());
  }
}
