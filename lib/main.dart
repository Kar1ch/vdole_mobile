import 'package:flutter/material.dart';
import 'package:vdole_mobile/storage.dart';
import 'presentaion/pages/home_page.dart';
import 'package:vdole_mobile/requests/requests.dart';

void main(){
  /// Инициализация модели зранения данных и проверки автоавторизации. Переменную model необхожимо передавать
  /// во все файлы, которые взаимодействуют с данными внутри приложения
  final model = AppModel();
  /// Проведение запроса на авто-авторизацию
  if(model.isAuth){
    autoAuth(model.storage.getCookie().toString());
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    /// Отвечает за хранение путей внутри приложения
    routes: {
      '/':(context) => HomePage(model: model)
    },
    /// Страница, которая будет открываться при запуске приложения
    initialRoute: '/',
  ));
}

