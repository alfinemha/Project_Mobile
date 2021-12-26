import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/drawer.dart';
import 'package:jadwalsidang/pages/profile_page.dart';
import 'package:jadwalsidang/state/mahasiswa_state.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:http/http.dart' as http;
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nim = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _noHp = TextEditingController();
  TextEditingController _kelas = TextEditingController();
  TextEditingController _prodi = TextEditingController();

  PickedFile? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.getImage(source: media);
    setState(() {
      _image = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Container(
              child: Text(
                'Pilih media untuk upload gambar',
                style: TextStyle(color: primaryBlue),
              ),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        SizedBox(
                          width: 10,
                        ),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        SizedBox(
                          width: 10,
                        ),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future _submit() async {
    var url = Uri.parse(GlobalConstant.baseUrl +
        '/mahasiswa/update/' +
        MahasiswaState.getMahasiswa()['id'].toString());
    try {
      Map<String, String> requestBody = <String, String>{
        'nama': _nama.text,
        'nim': _nim.text,
        'email': _email.text,
        'kelas': _kelas.text,
        'prodi': _prodi.text,
        'no_hp': _noHp.text,
      };
      Map<String, String> headers = <String, String>{
        'contentType': 'multipart/form-data',
        'Authorization': 'Bearer ' + GlobalConstant.token
      };

      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields.addAll(requestBody);
      if (_image != null) {
        request.files.add(http.MultipartFile(
            'image',
            File(_image!.path).readAsBytes().asStream(),
            File(_image!.path).lengthSync(),
            filename: _image!.path.split("/").last));
      }
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        BottomSheetFeedback.success(
            context, 'Selamat', 'Data Berhasil Diupdate');
        MahasiswaState.setMahasiswa(json.decode(respStr)['data']);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => ProfilePage()));
        });
      } else {
        BottomSheetFeedback.error(context, 'Error', 'Gagal update data');
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
  void initState() {
    super.initState();
    setState(() {
      _nim.text = MahasiswaState.getMahasiswa()['nim'] ?? "";
      _kelas.text = MahasiswaState.getMahasiswa()['kelas'] ?? "";
      _prodi.text = MahasiswaState.getMahasiswa()['prodi'] ?? "";
      _email.text = MahasiswaState.getMahasiswa()['email'] ?? "";
      _noHp.text = MahasiswaState.getMahasiswa()['no_hp'] ?? "";
      _nama.text = MahasiswaState.getMahasiswa()['nama'] ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: textWhiteGrey,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: TextField(
                      controller: _nim,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'NIM',
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
                      controller: _nama,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Nama Lengkap',
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
                      controller: _email,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                      controller: _noHp,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Nomor HP',
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
                      controller: _kelas,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Kelas',
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
                      controller: _prodi,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Program Studi',
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _image == null
                        ? GestureDetector(
                            onTap: () {
                              myAlert();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                height: 100,
                                width: 100,
                                child: DottedBorder(
                                  color: primaryBlue,
                                  strokeWidth: 2,
                                  dashPattern: [4, 4],
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Text(
                                          '+ Upload Foto',
                                          style: TextStyle(
                                              fontSize: 12, color: primaryBlue),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(_image!.path),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  )),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  myAlert();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: DottedBorder(
                                      color: primaryBlue,
                                      strokeWidth: 2,
                                      dashPattern: [4, 4],
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              '+ Edit Foto',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: primaryBlue),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            _submit();
                          },
                          child: Text('Submit')))
                ],
              ),
            ],
          ),
        )));
  }
}
