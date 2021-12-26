import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/constant/string_constant.dart';
import 'package:jadwalsidang/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _images = [
    "assets/img/polinema.png",
    "assets/img/gambar1.jpeg",
    "assets/img/gambar2.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Swiper(
              onIndexChanged: (index) {},
              autoplay: true,
              layout: SwiperLayout.DEFAULT,
              viewportFraction: 0.8,
              scale: 0.9,
              itemCount: _images.length,
              pagination: SwiperPagination(margin: EdgeInsets.all(5.0)),
              itemBuilder: (BuildContext context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(_images[index]), fit: BoxFit.fill),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Aplikasi Jadwal Seminar Proposal dan Sidang Skripsi',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 7,
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: primaryBlue),
              child: Text(
                'Program Studi D-III',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(StringConstant.d3),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: primaryBlue),
              child: Text(
                'Program Studi D-IV',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(StringConstant.d4),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: primaryBlue),
              child: Text(
                'Syarat',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(StringConstant.syarat),
          ),
        ],
      ),
    );
  }
}
