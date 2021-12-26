import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/theme.dart';

class InformasiPage extends StatefulWidget {
  const InformasiPage({Key? key}) : super(key: key);

  @override
  _InformasiPageState createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: Text('Informasi'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/img/logo.png',
                width: 150,
              ),
              Text(
                'Aplikasi Jadwal Seminar Proposal dan Sidang Skripsi',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: primaryBlue),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Aplikasi Android yang dapat mengelola jadwal seminar proposal (sempro) dan ujian akhir/sidang skripsi D4 Teknik Informatika.',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
