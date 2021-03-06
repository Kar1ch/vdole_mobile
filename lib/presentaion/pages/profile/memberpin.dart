import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:vdole_mobile/requests/requests.dart';
import 'package:vdole_mobile/storage.dart';

class MemberPin extends StatelessWidget{
  MemberPin({Key? key, required this.model, required this.email}) : super(key: key);
  final AppModel model;
  String email = '';
  TextEditingController pinController = TextEditingController();

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
              /// Поле ввода PIN кода
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
              /// Кнопка отправить
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
                      try {
                        var response = await memberPin(email, pinController.text);
                        var responseXml = response[0].toString();
                        var responseXmlText = response[1].toString();
                        if (responseXmlText.contains('0')){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Указан неверный PIN код!'), backgroundColor: Colors.redAccent,));
                        }
                        else{
                          String cookie = responseXml.substring(responseXml.indexOf('cookie') + 8, responseXml.indexOf('"', responseXml.indexOf('cookie') + 8));
                          model.storage.setCookie(cookie);
                          Navigator.of(context).pushReplacementNamed('/');
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Указан верный PIN код!'), backgroundColor: DarkThemeColors.primary00,));
                        }
                      }
                      finally {}
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