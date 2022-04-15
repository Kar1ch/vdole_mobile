import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:http/http.dart' as http;
import 'package:xml_parser/xml_parser.dart' as xml;
import 'package:url_launcher/url_launcher.dart';

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
        title: const Text('Регистрация', textAlign: TextAlign.center, style: TextStyle(color: DarkThemeColors.white),),
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
                              style: const TextStyle(color: DarkThemeColors.deactive),
                              children: [
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
                      var response = await http.post(Uri.parse('http://vdole.co/serv.php'), body: {
                        'mob': '4',
                        'comm': '25',
                        'newLogEmail':email,
                      });
                      // Парсинг ответа из xml в строку с тэгами
                      var responseXml = xml.XmlElement.parseString(
                          response.body)![0];
                      // Парсинг ответа из xml в строку без тегов
                      var responseXmlText = xml.XmlText.parseString(
                          response.body)![0].toString();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(responseXmlText),
                        backgroundColor: Colors.green,));
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