import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:xml_parser/xml_parser.dart' as xml;

class MemberPin extends StatefulWidget{
  var email = '';
  MemberPin(var Email){
    email = Email;
  }

  @override
  State<StatefulWidget> createState() => MemberPinState(email);
}

class MemberPinState extends State{
  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  MemberPinState(String email){
    emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация', textAlign: TextAlign.center,),
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
                  controller: emailController,
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
                    hintText: "Введите Email",
                    hintStyle: TextStyle(color: DarkThemeColors.deactive),
                    //fillColor: DarkThemeColors.white,
                  ),
                ),
              ),
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
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                //color: Colors.green,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    primary: DarkThemeColors.primary00,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    if(!EmailValidator.validate(emailController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Попробуйте еще раз"), backgroundColor: Colors.redAccent,));
                    }
                    else{
                      try {
                        var response = await http.post(
                            Uri.parse('http://vdole.co/serv.php'),
                            body: {'mob': '4', 'comm': '1', 'logEmail': emailController.text, 'code':pinController.text});
                        var responseXml = xml.XmlElement.parseString(response.body)![0];
                        var responseXmlText = xml.XmlText.parseString(response.body)![0].toString();
                        if (responseXml.toString() == '0'){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Указан неверный E-mail или пароль!'), backgroundColor: Colors.redAccent,));
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseXmlText), backgroundColor: Colors.green,));
                        }
                      } finally {}
                    }
                  },
                  child: const Text("Отправить", style: TextStyle(color: DarkThemeColors.white),),
                ),
              ),
            ]
        ),
      ),
      backgroundColor: DarkThemeColors.background01,
    );
  }
}