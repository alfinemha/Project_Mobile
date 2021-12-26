class MahasiswaState {
  static List _listMahasiswa = [];
  static Map _mahasiswa = {};

  static setListMahasiswa(List mahasiswa) {
    _listMahasiswa = mahasiswa;
  }

  static setMahasiswa(Map mahasiswa) {
    _mahasiswa = mahasiswa;
  }

  static Map getMahasiswa() {
    return _mahasiswa;
  }
}
