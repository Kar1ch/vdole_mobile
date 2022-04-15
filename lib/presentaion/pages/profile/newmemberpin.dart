import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:xml_parser/xml_parser.dart' as xml;
import 'package:url_launcher/url_launcher.dart';

class NewMemberPin extends StatefulWidget{
  var email = '';
  NewMemberPin(var Email, {Key? key}) : super(key: key){
    email = Email;
  }
  @override
  State<StatefulWidget> createState() => NewMemberPinState(email);
}

class NewMemberPinState extends State{
  var email = '';
  TextEditingController pinController = TextEditingController();
  var isagreed = false;
  NewMemberPinState(var Email){
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: TextFormField(
                  controller: pinController,
                  style: const TextStyle(color: DarkThemeColors.white),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: DarkThemeColors.deactive,
                        )
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: DarkThemeColors.deactive,
                        )
                    ),
                    hintText: "Введите PIN",
                    hintStyle: TextStyle(color: DarkThemeColors.deactive),
                    //fillColor: DarkThemeColors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Row(
                  children: [
                    Checkbox(
                      value: isagreed,
                      onChanged: (var value){
                        setState(() {
                          isagreed = value!;
                        });
                      },
                    ),
                    RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Пользовательское соглашение',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () { launch('https://drive.google.com/file/d/0B2nuss8lF_0iX29LWF8wLW5zLXc/view?usp=sharing'); }
                            )
                          ]
                        )
                    ),
                  ],
                )
              ),
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
                    if (isagreed) {
                      try {
                        var response = await http.post(
                            Uri.parse('http://vdole.co/serv.php'),
                            body: {
                              'mob': '4',
                              'comm': '11',
                              'status_r': '1',
                              'mail_r': email,
                              'code_r': pinController.text,
                              'agent': '1'
                            });
                        var responseXml = xml.XmlElement.parseString(
                            response.body)![0];
                        var responseXmlText = xml.XmlText.parseString(
                            response.body)![0].toString();
                        if (responseXml.toString().contains('0')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(
                                  'Указан неверный E-mail или пароль!'),
                                backgroundColor: Colors.redAccent,));
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(responseXmlText),
                            backgroundColor: Colors.green,));
                        }
                      } finally {}
                    }
                    else{

                    }
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