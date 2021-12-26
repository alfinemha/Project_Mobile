import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/admin_mahasiswa_page.dart';
import 'package:jadwalsidang/pages/pengajuan_sempro_page.dart';
import 'package:jadwalsidang/pages/pengajuan_skripsi_page.dart';
import 'package:http/http.dart' as http;
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';

class BottomSheetMhs {
  const BottomSheetMhs(BuildContext context);

  static Future update(BuildContext context, String id) async {
    Future _update(int status, String id) async {
      var url = Uri.parse(GlobalConstant.baseUrl + '/admin/mahasiswa/' + id);
      try {
        var response = await http.put(url, headers: {
          'Authorization': 'Bearer ' + GlobalConstant.getToken()
        }, body: {
          'status': status.toString(),
        });
        if (response.statusCode == 200) {
          BottomSheetFeedback.success(
              context, 'Selamat', 'Verifikasi mahasiswa berhasil');
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminMahasiswaPage()));
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
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
                  "Verifikasi Mahasiswa",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _update(1, id);
                        },
                        child: Text('Terima')),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _update(0, id);
                        },
                        child: Text('Tolak'))
                  ],
                )
              ],
            ),
          );
        });
    return;
  }
}
