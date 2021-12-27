import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/admin_mahasiswa_page.dart';
import 'package:jadwalsidang/pages/admin_tab_page.dart';
import 'package:jadwalsidang/pages/pengajuan_sempro_page.dart';
import 'package:jadwalsidang/pages/pengajuan_skripsi_page.dart';
import 'package:http/http.dart' as http;
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BottomSheetSkripsi {
  const BottomSheetSkripsi(BuildContext context);

  static Future update(BuildContext context, String id) async {
    TextEditingController _waktu = TextEditingController();
    TextEditingController _tempat = TextEditingController();
    TextEditingController _namaRuang = TextEditingController();
    TextEditingController _link = TextEditingController();

    int? _radioValue1 = 0;

    Future _update(String id) async {
      var url =
          Uri.parse(GlobalConstant.baseUrl + '/admin/pengajuan/skripsi/' + id);
      try {
        var response = await http.put(url, headers: {
          'Authorization': 'Bearer ' + GlobalConstant.getToken()
        }, body: {
          'waktu': _waktu.text,
          'tempat': _tempat.text,
          'nama_ruang': _namaRuang.text,
          'link': _link.text,
          'status': _radioValue1 != null
              ? _radioValue1 == 1
                  ? 'Sudah Diverifikasi'
                  : 'Belum Diverifikasi'
              : 'Belum Diverifikasi',
        });

        if (response.statusCode == 200) {
          BottomSheetFeedback.success(
              context, 'Selamat', 'Verifikasi skripsi berhasil');
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminTabPage()));
          });
        } else {
          BottomSheetFeedback.error(
              context, 'Error', json.decode(response.body)['message']);
        }
      } on SocketException {
        BottomSheetFeedback.error(context, 'Error', 'No connection internet');
      } on HttpException {
        BottomSheetFeedback.error(context, 'Error', 'Failed ');
      } on FormatException {
        BottomSheetFeedback.error(context, 'Error', 'Failed');
      }
    }

    double _screenWidth = MediaQuery.of(context).size.width;
    await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 45),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: _screenWidth * (15 / 100),
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(7.5 / 2),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Verifikasi Skripsi",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2045, 6, 7), onChanged: (date) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          mystate(() {
                            _waktu.text = formattedDate.toString();
                          });
                        }, onConfirm: (date) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(date);
                          mystate(() {
                            _waktu.text = formattedDate.toString();
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.id);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  _waktu.text.isEmpty
                                      ? 'Pilih tanggal'
                                      : _waktu.text,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
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
                        controller: _tempat,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Tampat',
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
                        controller: _namaRuang,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Nama Ruang',
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
                        controller: _link,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Link Zoom ',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 0,
                          groupValue: _radioValue1,
                          onChanged: (value) {
                            mystate(() {
                              _radioValue1 = value as int?;

                              switch (_radioValue1) {
                                case 0:
                                  break;
                                case 1:
                                  break;
                                case 2:
                                  break;
                              }
                            });
                          },
                        ),
                        Text(
                          'Tidak Verifikasi',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Radio(
                          value: 1,
                          groupValue: _radioValue1,
                          onChanged: (value) {
                            mystate(() {
                              _radioValue1 = value as int?;

                              switch (_radioValue1) {
                                case 0:
                                  break;
                                case 1:
                                  break;
                              }
                            });
                          },
                        ),
                        Text(
                          'Verifikasi',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _update(id);
                        },
                        child: Text('Submit'))
                  ],
                ),
              ),
            );
          });
        });
    return;
  }
}
