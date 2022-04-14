import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State{

  final _formKey = GlobalKey<FormState>();
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
                validator: (value){
                  if (!EmailValidator.validate(emailController.text)) return "Пожалуйста введите Email";
                },
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
              color: Colors.green,
              child: TextButton(
                onPressed: () async {
                  if(!EmailValidator.validate(emailController.text)) {
                    //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Попробуйте еще раз"),));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Попробуйте еще раз"), backgroundColor: Colors.redAccent,));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Письмо с кодом подтверждения отправлено на ваш Email"), backgroundColor: Colors.green,));
                    try {
                      var response = await http.post(
                          Uri.parse('http://vdole.co/serv.php'),
                          body: {'mob': '4', 'comm': '25', 'logEmail': emailController.text});
                      print(response.body);
                  } finally {
                    }
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