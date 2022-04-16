import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:vdole_mobile/requests/requests.dart';

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
              // Поле ввода PIN кода
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
              // Кнопка отправить
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
                      var response = await newMemberPin(email, pinController.text);
                        var responseXml = response[0].toString();
                        var responseXmlText = responseXml[1].toString();
                        if (responseXml.contains('0')) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Указан неверный PIN код!'),
                            backgroundColor: Colors.redAccent,));
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(responseXmlText),
                            backgroundColor: Colors.green,));
                        }
                      } finally {}
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