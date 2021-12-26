import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/detail_sempro_page.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;

class SemproWidget extends StatefulWidget {
  const SemproWidget({Key? key}) : super(key: key);

  @override
  _SemproWidgetState createState() => _SemproWidgetState();
}

class _SemproWidgetState extends State<SemproWidget> {
  List _semproData = [];
  bool _loading = false;

  Future _getSempro() async {
    setState(() {
      _loading = true;
    });
    var url = Uri.parse(GlobalConstant.baseUrl + '/mahasiswa/pengajuan/sempro');
    try {
      var response = await http.get(url,
          headers: {'Authorization': 'Bearer ' + GlobalConstant.getToken()});
      if (response.statusCode == 200) {
        setState(() {
          _loading = false;
          _semproData = json.decode(response.body)['data'];
        });
      } else {
        setState(() {
          _semproData = [];
          _loading = false;
        });
        BottomSheetFeedback.error(
            context, 'Error', 'Gagal mendapatkan data sempro!');
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
    _getSempro();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
          )
        : _semproData.isEmpty
            ? Center(child: Text('Data masih kosong'))
            : Container(
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                    itemCount: _semproData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailSemproPage(
                                        id: _semproData[index]['id'].toString(),
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
                                        Text(_semproData[index]['waktu'] != null
                                            ? _semproData[index]['waktu']
                                            : 'Waktu belum ada')
                                      ],
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: _semproData[index]
                                                        ['status'] ==
                                                    'Sudah Diverifikasi'
                                                ? Colors.green
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text(
                                          _semproData[index]['status'],
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
                                          _semproData[index]['mahasiswa']
                                              ['nim'],
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _semproData[index]['mahasiswa']['nama'],
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
