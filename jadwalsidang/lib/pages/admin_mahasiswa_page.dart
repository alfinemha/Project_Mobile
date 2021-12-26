import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/admin_detail_skripsi_page.dart';
import 'package:jadwalsidang/pages/detail_skripsi_page.dart';
import 'package:jadwalsidang/pages/drawer_admin.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;
import 'package:jadwalsidang/widgets/bottom_sheet_mhs.dart';

class AdminMahasiswaPage extends StatefulWidget {
  const AdminMahasiswaPage({Key? key}) : super(key: key);

  @override
  _AdminMahasiswaPageState createState() => _AdminMahasiswaPageState();
}

class _AdminMahasiswaPageState extends State<AdminMahasiswaPage> {
  List _mhsData = [];

  bool _loading = false;

  Future _getMahasiswa() async {
    setState(() {
      _loading = true;
    });
    var url = Uri.parse(GlobalConstant.baseUrl + '/admin/mahasiswa');
    try {
      var response = await http.get(url,
          headers: {'Authorization': 'Bearer ' + GlobalConstant.getToken()});
      if (response.statusCode == 200) {
        setState(() {
          _loading = false;
          _mhsData = json.decode(response.body)['data'];
        });
      } else {
        setState(() {
          _mhsData = [];
          _loading = false;
        });
        BottomSheetFeedback.error(
            context, 'Error', 'Gagal mendapatkan data mahasiswa!');
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
    _getMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: Text('Data Mahasiswa'),
        // automaticallyImplyLeading: false,
      ),
      body: _loading
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(),
            )
          : _mhsData.isEmpty
              ? Center(child: Text('Data masih kosong'))
              : Container(
                  padding: EdgeInsets.all(16),
                  child: ListView.builder(
                      itemCount: _mhsData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            BottomSheetMhs.update(
                                context, _mhsData[index]['id'].toString());
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
                                          Text(_mhsData[index]['kelas']
                                              .toString())
                                        ],
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 8),
                                          decoration: BoxDecoration(
                                              color:
                                                  _mhsData[index]['status'] == 1
                                                      ? Colors.green
                                                      : Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Text(
                                            _mhsData[index]['status'] == 1
                                                ? 'Sudah Diverifikasi'
                                                : 'Belum Diverifikasi',
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
                                            _mhsData[index]['nim'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _mhsData[index]['nama'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
      drawer: DrawerAdminWidget(),
    );
  }
}
