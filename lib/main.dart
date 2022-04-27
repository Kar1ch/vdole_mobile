import 'package:flutter/material.dart';
import 'package:vdole_mobile/storage.dart';
import 'presentaion/pages/home_page.dart';
import 'package:localstorage/localstorage.dart';

class CookieStorage {
  final LocalStorage cookiestorage = LocalStorage('vdole_localstorage');

  CookieStorage(){
    cookiestorage.setItem('cookie', '');
  }

  void setcookie(var newcookie) {
    cookiestorage.setItem('cookie', newcookie);
  }

  String getcookie(){
    return cookiestorage.getItem('cookie');
  }

  void deletecookie() {
    cookiestorage.setItem('cookie', '');
  }

  bool isauthorised(){
    return cookiestorage.getItem('cookie') == '' ? false : true;
  }
}

void main() {

  runApp(const MaterialApp(
    home: HomePage(),
      debugShowCheckedModeBanner: false,
  ));
}

