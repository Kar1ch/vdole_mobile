import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:vdole_mobile/requests/requests.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vdole_mobile/storage.dart';

import 'newmemberpin.dart';

class NewMemberGen extends StatelessWidget{

  NewMemberGen({Key? key, required this.email, required this.model}) : super(key: key);

  AppModel model;
  String email = '';
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Пользовательское соглашение', textAlign: TextAlign.center, style: TextStyle(color: DarkThemeColors.white),),
        centerTitle: true,
        backgroundColor: DarkThemeColors.primary00,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        child: ListView(
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              /// Пользовательское соглашение
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed:(){ launchUrl(Uri.dataFromString('https://drive.google.com')); },
                          child: const Text('Польлзовательское соглашение', style: TextStyle(color: DarkThemeColors.white),))
                    ],
                  )
              ),
              /// Кнопка подписать
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    primary: DarkThemeColors.primary00,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      /// Проведение запроса на генерацию PIN кода для нового пользователя
                      var response = await newMemberGen(email);
                      /// Парсинг ответа из xml в строку без тегов
                      var responseXmlText = response[1].toString();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(responseXmlText),
                        backgroundColor: DarkThemeColors.primary00,)
                      );
                      /// Переход на следующую страницу без возможности возврата на предыдущую
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewMemberPin(email: email, model: model)));
                    } finally {}
                  },
                  child: const Text("Подписать", style: TextStyle(color: DarkThemeColors.white),),
                ),
              ),
            ]
        ),
      ),
      backgroundColor: DarkThemeColors.background01,
    );
  }
}