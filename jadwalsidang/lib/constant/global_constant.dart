import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GlobalConstant {
  static const _storage = FlutterSecureStorage();

  static const baseUrl = 'http://192.168.1.115:8000/api';
  static String token = '';
  // static String rule = '';

  static setToken(val) async {
    token = val;
    // await _storage.write(key: 'token', value: val);
  }

  static deleteToken() async {
    token = '';
    // await _storage.delete(key: 'token');
  }

  static deleteStorage() async {
    token = '';
    await _storage.deleteAll();
  }

  static getToken() {
    return token;
  }

  // static setRule(val) async {
  //   rule = val;
  //   await _storage.write(key: 'rule', value: val);
  // }
}
