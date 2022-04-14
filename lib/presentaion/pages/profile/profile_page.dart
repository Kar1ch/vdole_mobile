import 'package:vdole_mobile/presentaion/pages/profile/memberpin.dart';
import 'package:xml_parser/xml_parser.dart' as xml;
import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:vdole_mobile/presentaion/pages/profile/newmemberpin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State{

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
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
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              //color: Colors.green,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                    primary: DarkThemeColors.primary00,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
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
                          body: {'mob': '4', 'comm': '25', 'logEmail': emailController.text});
                      var responseXml = xml.XmlElement.parseString(response.body)![0];
                      var responseXmlText = xml.XmlText.parseString(response.body)![0].toString();
                      if (responseXml.toString().contains('<error>')){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseXmlText.replaceAll('(#noMail)', '')), backgroundColor: Colors.redAccent,));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewMemberPin(emailController.text)));
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseXmlText), backgroundColor: Colors.green,));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MemberPin(emailController.text)));
                      }
                    } finally {}
                  }
                },
                child: const Text("Отправить", style: TextStyle(color: DarkThemeColors.tinkbg00),),
              ),
            )
          ]
        ),
      ),
      backgroundColor: DarkThemeColors.tinkbg00,
    );
  }
}