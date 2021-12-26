import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:http/http.dart' as http;
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:jadwalsidang/widgets/text_widget.dart';

class DetailSemproPage extends StatefulWidget {
  final String id;
  const DetailSemproPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailSemproPageState createState() => _DetailSemproPageState();
}

class _DetailSemproPageState extends State<DetailSemproPage> {
  Map? _semproData;
  bool _loading = false;

  Future _getDetailSempro() async {
    setState(() {
      _loading = true;
    });
    var url = Uri.parse(
        GlobalConstant.baseUrl + '/mahasiswa/pengajuan/sempro/' + widget.id);
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
          _semproData = {};
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
    _getDetailSempro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Sempro'),
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
                          Text('SEMPRO')
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
                              _semproData!['mahasiswa']['nim'],
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            )),
                        Text(_semproData!['mahasiswa']['prodi'])
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(_semproData!['mahasiswa']['nama']),
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
                    TextWidget(
                        title: 'Judul 1', content: _semproData!['judul_1']),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Judul 2', content: _semproData!['judul_2']),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Judul 3', content: _semproData!['judul_3']),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Dosen Pembimbing 1',
                        content: _semproData!['pembimbing_1']),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Dosen Pembimbing 2',
                        content: _semproData!['pembimbing_2']),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Waktu Pelaksanaan',
                        content: _semproData!['waktu'] == null
                            ? 'Waktu belum ada'
                            : _semproData!['waktu'].toString()),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Temapt Pelaksanaan',
                        content: _semproData!['tempat'] == null
                            ? 'Tempat belum ada'
                            : _semproData!['tempat'].toString()),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Nama Ruang',
                        content: _semproData!['nama_ruang'] == null
                            ? 'Nama ruang belum ada'
                            : _semproData!['nama_ruang'].toString()),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                        title: 'Link Zoom',
                        content: _semproData!['link'] == null
                            ? 'Link Zoom belum ada'
                            : _semproData!['link'].toString()),
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
