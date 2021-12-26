import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jadwalsidang/pages/drawer.dart';
import 'package:jadwalsidang/pages/edit_profile.dart';
import 'package:jadwalsidang/state/mahasiswa_state.dart';
import 'package:jadwalsidang/theme.dart';
import 'package:jadwalsidang/widgets/text_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryBlue,
          title: Text('Profil'),
          // automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                color: primaryBlue,
                height: 160,
                width: double.infinity,
              ),
              Positioned(
                top: 60,
                left: 30,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38.withOpacity(.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 400,
                  width: MediaQuery.of(context).size.width - 60,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            title: 'NIM',
                            content: MahasiswaState.getMahasiswa()['nim']),
                        SizedBox(
                          height: 16,
                        ),
                        TextWidget(
                            title: 'Nama Lengkap',
                            content: MahasiswaState.getMahasiswa()['nama']),
                        SizedBox(
                          height: 16,
                        ),
                        TextWidget(
                            title: 'Email',
                            content: MahasiswaState.getMahasiswa()['email']),
                        SizedBox(
                          height: 16,
                        ),
                        TextWidget(
                            title: 'Kelas',
                            content: MahasiswaState.getMahasiswa()['kelas']),
                        SizedBox(
                          height: 16,
                        ),
                        TextWidget(
                            title: 'Program Studi',
                            content: MahasiswaState.getMahasiswa()['prodi']),
                        SizedBox(
                          height: 16,
                        ),
                        TextWidget(
                            title: 'Nomor HP',
                            content: MahasiswaState.getMahasiswa()['no_hp']),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: -50,
                child: Align(
                  alignment: Alignment.center,
                  child: MahasiswaState.getMahasiswa()['photo'] != null
                      ? CachedNetworkImage(
                          width: 55,
                          imageUrl:
                              MahasiswaState.getMahasiswa()['photo'].toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Color(0xFFEBEBF4),
                            highlightColor: Color(0xFFEBEBF4),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryBlue,
                              ),
                              width: 55,
                              height: 55,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : CachedNetworkImage(
                          width: 55,
                          imageUrl:
                              "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1214428300?k=20&m=1214428300&s=170667a&w=0&h=NPyJe8rXdOnLZDSSCdLvLWOtIeC9HjbWFIx8wg5nIks=",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Color(0xFFEBEBF4),
                            highlightColor: Color(0xFFEBEBF4),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryBlue,
                              ),
                              width: 55,
                              height: 55,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                ),
              ),
              Positioned.fill(
                  right: -90,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    child: Icon(Icons.edit),
                  ))
            ],
          ),
        ),
        drawer: DrawerWidget());
  }
}
