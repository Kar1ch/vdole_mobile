import 'package:flutter/material.dart';
import 'package:vdole_mobile/storage.dart';
import 'presentaion/pages/home_page.dart';
import 'package:vdole_mobile/requests/requests.dart';

void main() async {
  final model = AppModel();
  if(model.isAuth){
    autoAuth(model.storage.getCookie().toString());
  }
  runApp(MaterialApp(
    home: HomePage(model: model),
      debugShowCheckedModeBanner: false,
  ));
}

