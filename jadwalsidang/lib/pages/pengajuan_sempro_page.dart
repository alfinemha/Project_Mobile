import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/drawer.dart';
import 'package:jadwalsidang/pages/sempro_page.dart';
import 'package:jadwalsidang/pages/tab_page.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;

class PengajuanSemproPage extends StatefulWidget {
  const PengajuanSemproPage({Key? key}) : super(key: key);

  @override
  _PengajuanSemproPageState createState() => _PengajuanSemproPageState();
}

class _PengajuanSemproPageState extends State<PengajuanSemproPage> {
  TextEditingController _judul1 = TextEditingController();
  TextEditingController _judul2 = TextEditingController();
  TextEditingController _judul3 = TextEditingController();
  TextEditingController _pembimbing1 = TextEditingController();
  TextEditingController _pembimbing2 = TextEditingController();

  Future _submit() async {
    var url = Uri.parse(GlobalConstant.baseUrl + '/mahasiswa/pengajuan/sempro');
    try {
      var response = await http.post(url, headers: {
        'Authorization': 'Bearer ' + GlobalConstant.getToken()
      }, body: {
        'judul_1': _judul1.text,
        'judul_2': _judul2.text,
        'judul_3': _judul3.text,
        'pembimbing_1': _pembimbing1.text,
        'pembimbing_2': _pembimbing2.text,
      });
      if (response.statusCode == 200) {
        BottomSheetFeedback.success(
            context, 'Selamat', 'Pengajuan sempro berhasil');
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TabPage()));
        });
      } else {
        BottomSheetFeedback.error(context, 'Error', 'Pengajuan sempro gagal!');
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
          title: Text('Pengajuan Sempro'),
          // automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: textWhiteGrey,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextField(
                    controller: _judul1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Judul 1',
                      hintStyle: heading6.copyWith(color: textGrey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: textWhiteGrey,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextField(
                    controller: _judul2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Judul 2',
                      hintStyle: heading6.copyWith(color: textGrey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: textWhiteGrey,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextField(
                    controller: _judul3,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Judul 3',
                      hintStyle: heading6.copyWith(color: textGrey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: textWhiteGrey,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextField(
                    controller: _pembimbing1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Pembimbing 1',
                      hintStyle: heading6.copyWith(color: textGrey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: textWhiteGrey,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: TextField(
                    controller: _pembimbing2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Pembimbing 2',
                      hintStyle: heading6.copyWith(color: textGrey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Material(
                  borderRadius: BorderRadius.circular(14.0),
                  elevation: 0,
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (_judul1.text.isEmpty ||
                              _pembimbing1.text.isEmpty ||
                              _pembimbing2.text.isEmpty) {
                            BottomSheetFeedback.error(context, 'Mohon maaf!',
                                'Judul 1 dan Nama Pembimbing harus diisi');
                          } else {
                            _submit();
                          }
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: DrawerWidget());
  }
}
