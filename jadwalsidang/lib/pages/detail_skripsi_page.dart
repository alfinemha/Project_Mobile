import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:http/http.dart' as http;
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:jadwalsidang/widgets/text_widget.dart';

class DetailSkripsiPage extends StatefulWidget {
  final String id;
  const DetailSkripsiPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailSkripsiPageState createState() => _DetailSkripsiPageState();
}

class _DetailSkripsiPageState extends State<DetailSkripsiPage> {
  Map? _skripsiData;
  bool _loading = false;

  Future _getDetailSkripsi() async {
    setState(() {
      _loading = true;
    });
    var url = Uri.parse(
        GlobalConstant.baseUrl + '/mahasiswa/pengajuan/skripsi/' + widget.id);
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
          _skripsiData = {};
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
    _getDetailSkripsi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Skripsi'),
        backgroundColor: primaryBlue,
      ),
      body: SingleChildScrollView(
        child: _loading
            ? Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/img/logo.png',
                            width: 60,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('SKRIPSI')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            decoration: BoxDecoration(
                                color: primaryBlue,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              _skripsiData!['mahasiswa']['nim'],
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            )),
                        Text(_skripsiData!['mahasiswa']['prodi'])
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(_skripsiData!['mahasiswa']['nama']),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 5,
                      child: Container(color: Colors.grey[200]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(title: 'Judul', content: _skripsiData!['judul']),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Dosen Pembimbing 1',
                        content: _skripsiData!['pembimbing_1']),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Dosen Pembimbing 2',
                        content: _skripsiData!['pembimbing_2']),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Waktu Pelaksanaan',
                        content: _skripsiData!['waktu'] == null
                            ? 'Waktu belum ada'
                            : _skripsiData!['waktu'].toString()),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Temapt Pelaksanaan',
                        content: _skripsiData!['tempat'] == null
                            ? 'Tempat belum ada'
                            : _skripsiData!['tempat'].toString()),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Nama Ruang',
                        content: _skripsiData!['nama_ruang'] == null
                            ? 'Nama ruang belum ada'
                            : _skripsiData!['nama_ruang'].toString()),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Link Zoom',
                        content: _skripsiData!['link'] == null
                            ? 'Link Zoom belum ada'
                            : _skripsiData!['link'].toString()),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
