import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:vdole_mobile/requests/requests.dart';
import 'package:url_launcher/url_launcher.dart';

import 'newmemberpin.dart';

class NewMemberGen extends StatefulWidget{
  var email = '';
  NewMemberGen(var Email, {Key? key}) : super(key: key){
    email = Email;
  }
  @override
  State<StatefulWidget> createState() => NewMemberGenState(email);
}

class NewMemberGenState extends State{
  var email = '';
  TextEditingController pinController = TextEditingController();
  NewMemberGenState(var Email){
    email = Email;
  }

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
              // Пользовательское соглашение
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(color: DarkThemeColors.white),
                              //text: 'Для создания аккаунта прочтите и подпишите',
                              children:[
                                TextSpan(
                                    text: 'Пользовательское соглашение',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () { launch('https://drive.google.com'); }
                                )
                              ]
                          )
                      ),
                    ],
                  )
              ),
              // Кнопка подписать
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
                      var response = await newMemberGen(email);
                      // Парсинг ответа из xml в строку без тегов
                      var responseXmlText = response[1].toString();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(responseXmlText),
                        backgroundColor: DarkThemeColors.primary00,));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewMemberPin(email)));
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