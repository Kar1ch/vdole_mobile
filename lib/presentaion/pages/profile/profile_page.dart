import 'package:vdole_mobile/presentaion/pages/loading.dart';
import 'package:vdole_mobile/presentaion/pages/profile/memberpin.dart';
import 'package:vdole_mobile/presentaion/pages/profile/newmembergen.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:vdole_mobile/requests/requests.dart';
import 'package:vdole_mobile/storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State{

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context){
    if(!cookieStorage.isauthorised()) {
      return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 8),
          child: ListView(
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                // Поле ввода Email
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 20),
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
                // Кнопка отправить
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 20),
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
                      if (!EmailValidator.validate(emailController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Почта введена некорректно"),
                              backgroundColor: Colors.redAccent,));
                      }
                      else {
                        try {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => const LoadingPage()));
                          var response = await preLogRequest(
                              emailController.text);
                          var responseXml = response[0].toString();
                          var responseXmlText = response[1].toString();
                          if (responseXml.contains('<error>')) {
                            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseXmlText.replaceAll('(#noMail)', '')), backgroundColor: Colors.redAccent,));
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: DarkThemeColors.tinkbg00,
                                    content: Text(responseXmlText.replaceAll(
                                        '(#noMail)',
                                        'Создать для вас новый профиль инвестора?'),
                                      style: const TextStyle(
                                          color: DarkThemeColors.white),),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewMemberGen(
                                                            emailController
                                                                .text)));
                                          },
                                          child: const Text('Да',
                                            style: TextStyle(
                                                color: DarkThemeColors
                                                    .primary00),)
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Нет',
                                            style: TextStyle(
                                                color: DarkThemeColors
                                                    .deactive),)
                                      ),
                                    ],
                                  );
                                });
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(responseXmlText),
                              backgroundColor: DarkThemeColors.primary00,));
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    MemberPin(emailController.text)));
                          }
                        } finally {}
                      }
                    },
                    child: const Text("Отправить",
                      style: TextStyle(color: DarkThemeColors.white),),
                  ),
                )
              ]
          ),
        ),
        backgroundColor: DarkThemeColors.tinkbg00,
      );
    }
    else{
      return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 8),
          child: ListView(
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget> [
                      ListTile(
                        leading: const Icon(Icons.airline_seat_recline_extra_outlined, color: DarkThemeColors.primary00, size: 30,),
                        title: const Text('515 руб', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: DarkThemeColors.white), textAlign: TextAlign.left),
                        subtitle: Text(cookieStorage.getcookie(), style: const TextStyle(fontSize: 16, color: DarkThemeColors.white),),
                      ),
                    ],
                  ),
                  color: DarkThemeColors.background04,
                ),
              ],
          ),
        ),
        backgroundColor: DarkThemeColors.tinkbg00,
      );
    }
  }
}