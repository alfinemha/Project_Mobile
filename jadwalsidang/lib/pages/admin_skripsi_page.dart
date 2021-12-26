import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/admin_detail_skripsi_page.dart';
import 'package:jadwalsidang/pages/detail_skripsi_page.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;

class AdminSkripsiWidget extends StatefulWidget {
  const AdminSkripsiWidget({Key? key}) : super(key: key);

  @override
  _AdminSkripsiWidgetState createState() => _AdminSkripsiWidgetState();
}

class _AdminSkripsiWidgetState extends State<AdminSkripsiWidget> {
  List _skrispiData = [];
  bool _loading = false;

  Future _getSkripsi() async {
    setState(() {
      _loading = true;
    });
    var url = Uri.parse(GlobalConstant.baseUrl + '/admin/pengajuan/skripsi');
    try {
      var response = await http.get(url,
          headers: {'Authorization': 'Bearer ' + GlobalConstant.getToken()});
      if (response.statusCode == 200) {
        setState(() {
          _loading = false;
          _skrispiData = json.decode(response.body)['data'];
        });
      } else {
        setState(() {
          _skrispiData = [];
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
    return _loading
        ? Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
          )
        : _skrispiData.isEmpty
            ? Center(child: Text('Data masih kosong'))
            : Container(
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                    itemCount: _skrispiData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDetailSkripsiPage(
                                        id: _skrispiData[index]['id']
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        Text(_skrispiData[index]['mahasiswa']
                                                ['kelas']
                                            .toString())
                                      ],
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: _skrispiData[index]
                                                        ['status'] ==
                                                    'Sudah Disetujui'
                                                ? Colors.green
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text(
                                          _skrispiData[index]['status'],
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
                                          _skrispiData[index]['mahasiswa']
                                              ['nim'],
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _skrispiData[index]['mahasiswa']['nama'],
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
              );
  }
}
