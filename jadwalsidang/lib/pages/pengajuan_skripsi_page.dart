import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/drawer.dart';
import 'package:jadwalsidang/pages/sempro_page.dart';
import 'package:jadwalsidang/pages/skripsi_page.dart';
import 'package:jadwalsidang/pages/tab_page.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;

class PengajuanSkripsiPage extends StatefulWidget {
  const PengajuanSkripsiPage({Key? key}) : super(key: key);

  @override
  _PengajuanSkripsiPageState createState() => _PengajuanSkripsiPageState();
}

class _PengajuanSkripsiPageState extends State<PengajuanSkripsiPage> {
  TextEditingController _judul = TextEditingController();
  TextEditingController _pembimbing1 = TextEditingController();
  TextEditingController _pembimbing2 = TextEditingController();
  String _path = '';
  bool _loadingFile = false;
  String _filename = '';

  Future _getFile() async {
    setState(() {
      _loadingFile = true;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _path = file.path.toString();
        _filename = file.name.toString();
      });
    } else {
      // User canceled the picker
    }
    setState(() {
      _loadingFile = false;
    });
  }

  Future _submit() async {
    var url =
        Uri.parse(GlobalConstant.baseUrl + '/mahasiswa/pengajuan/skripsi');
    try {
      Map<String, String> requestBody = <String, String>{
        'judul': _judul.text,
        'pembimbing_1': _pembimbing1.text,
        'pembimbing_2': _pembimbing2.text,
      };
      Map<String, String> headers = <String, String>{
        'contentType': 'multipart/form-data',
        'Authorization': 'Bearer ' + GlobalConstant.token
      };

      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(
            headers) //if u have headers, basic auth, token bearer... Else remove line
        ..fields.addAll(requestBody);
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('file', _path);
      request.files.add(multipartFile);
      var response = await request.send();

      if (response.statusCode == 200) {
        BottomSheetFeedback.success(
            context, 'Selamat', 'Pengajuan skripsi berhasil');
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
                    controller: _judul,
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
                GestureDetector(
                  onTap: () {
                    _getFile();
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
                              Icons.upload_file,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Upload file',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        _loadingFile
                            ? Container(
                                width: 25,
                                height: 25,
                                child: Platform.isIOS
                                    ? CupertinoActivityIndicator()
                                    : CircularProgressIndicator())
                            : Container()
                      ],
                    ),
                  ),
                ),
                _filename != ''
                    ? SizedBox(
                        height: 20,
                      )
                    : Container(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(_filename != '' ? _filename : '')),
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
                          if (_judul.text.isEmpty ||
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
