import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NearFromYou extends StatefulWidget {
  static const String routeName = '/near-from-you';
  const NearFromYou({super.key});

  @override
  State<NearFromYou> createState() => _NearFromYouState();
}

class _NearFromYouState extends State<NearFromYou> {
  List _Listdata = [];

  Future _getdata() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.6/ta_projek/crudtaprojek/read.php'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _Listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  bool isTextFieldFocused = false;
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          title: Container(
            width: double.infinity,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon:
                      isTextFieldFocused || _searchController.text.isNotEmpty
                          ? null
                          : const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.all(4.0),
                  hintText: 'Search..',
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintMaxLines: 1,
                ),
                onTap: () {
                  setState(() {
                    isTextFieldFocused = true;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    isTextFieldFocused = value.isNotEmpty;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    isTextFieldFocused = false;
                  });
                },
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/notification.png',
                height: 34.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/profile.png',
                height: 38.0,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD2E9FF), // Warna gradient awal
              Color(0xFFFFFFFF), // Warna gradient akhir
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Near from you',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/bookit.png',
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _Listdata
                    .length, // Ganti dengan jumlah item yang Anda inginkan
                itemBuilder: (BuildContext context, int index) {
                  String cleanedUrlFoto =
                      _Listdata[index]['url_foto'].replaceAll('\\', '');
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.173,
                    margin: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                        right: 20), // Atur margin jika diperlukan
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                                image: NetworkImage(cleanedUrlFoto),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      _Listdata[index]['nama_penginapan'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.save,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 0,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    _Listdata[index]['rating'],
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '/',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '(',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _Listdata[index]['jumlah_reviewer'],
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ')',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              Text(
                                _Listdata[index]['alamat'],
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Rp.',
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 8, 59, 134),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    formatInteger(_Listdata[index]['harga']
                                        .toString()), // Mengonversi integer ke string sebelum memanggil formatInteger
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 8, 59, 134),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatInteger(String numberString) {
    // Mengonversi string ke integer
    int number = int.parse(numberString);

    // Membuat objek NumberFormat untuk memformat angka
    NumberFormat formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(number);
  }
}
