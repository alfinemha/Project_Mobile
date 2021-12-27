import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jadwalsidang/constant/global_constant.dart';
import 'package:jadwalsidang/pages/admin_login_page.dart';
import 'package:jadwalsidang/pages/main_page.dart';
import 'package:jadwalsidang/pages/register_page.dart';
import 'package:jadwalsidang/state/mahasiswa_state.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/bottom_sheet_feedback.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  void _checkAuth() {
    if (GlobalConstant.getToken() != '') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  Future _me() async {
    var url = Uri.parse(GlobalConstant.baseUrl + '/mahasiswa/me');
    try {
      var response = await http.post(url,
          headers: {'Authorization': 'Bearer ' + GlobalConstant.getToken()});
      if (response.statusCode == 200) {
        MahasiswaState.setMahasiswa(json.decode(response.body));
      }
    } on SocketException {
      print('No connection internet');
    } on HttpException {
      print('Failed');
    } on FormatException {
      print('Failed');
    }
  }

  Future _login() async {
    var url = Uri.parse(GlobalConstant.baseUrl + '/mahasiswa/login');
    try {
      var response = await http.post(url, body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      });
      print(response.body);
      if (response.statusCode == 200) {
        BottomSheetFeedback.success(context, 'Selamat', 'Login berhasil');
        GlobalConstant.setToken(json.decode(response.body)['access_token']);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        });
        _me();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/student.png',
                      width: 240,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'LOGIN MAHASISWA',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/img/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextField(
                        controller: _emailController,
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
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: heading6.copyWith(color: textGrey),
                          suffixIcon: IconButton(
                            color: textGrey,
                            splashRadius: 1,
                            icon: Icon(passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: togglePassword,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
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
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            BottomSheetFeedback.error(context, 'Mohon maaf!',
                                'Pastikan semua data terisi');
                          } else {
                            _login();
                          }
                        },
                        borderRadius: BorderRadius.circular(14.0),
                        child: Center(
                          child: Text(
                            'Login',
                            style: heading5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun ? ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        'Register',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login sebagai ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminLoginPage()));
                      },
                      child: Text(
                        'Admin',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
