class AdminState {
  static Map _admin = {};

  static setAdmin(Map admin) {
    _admin = admin;
  }

  static Map getAdmin() {
    return _admin;
  }
}
