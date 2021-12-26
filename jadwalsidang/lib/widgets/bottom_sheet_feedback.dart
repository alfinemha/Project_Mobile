import 'package:flutter/material.dart';
import 'package:jadwalsidang/pages/pengajuan_sempro_page.dart';
import 'package:jadwalsidang/pages/pengajuan_skripsi_page.dart';

class BottomSheetFeedback {
  const BottomSheetFeedback(BuildContext context);

  static Future pengajuan(BuildContext context) async {
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
                  "Pilih Pengajuan",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PengajuanSemproPage()));
                        },
                        child: Text('Sempro')),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PengajuanSkripsiPage()));
                        },
                        child: Text('Skripsi'))
                  ],
                )
              ],
            ),
          );
        });
    return;
  }

  static Future error(
      BuildContext context, String title, String description) async {
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
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                    margin: EdgeInsets.only(top: 1),
                    child: Text(
                      description,
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          );
        });
    return;
  }

  static Future success(
      BuildContext context, String title, String description) async {
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
                  height: 2,
                ),
                Icon(
                  Icons.check_circle_outlined,
                  color: Colors.green,
                  size: 50,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Container(
                    margin: EdgeInsets.only(top: 1),
                    child: Text(
                      description,
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          );
        });
    return;
  }
}
