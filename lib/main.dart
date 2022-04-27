import 'package:flutter/material.dart';
import 'package:vdole_mobile/storage.dart';
import 'presentaion/pages/home_page.dart';
import 'package:localstorage/localstorage.dart';

void main() {

  runApp(const MaterialApp(
    home: HomePage(),
      debugShowCheckedModeBanner: false,
  ));
}

