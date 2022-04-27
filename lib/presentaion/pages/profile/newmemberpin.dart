import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:vdole_mobile/presentaion/pages/profile/profile_page.dart';
import 'package:vdole_mobile/requests/requests.dart';
import 'package:vdole_mobile/presentaion/pages/home_page.dart';

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
                      if (pinController.text == ''){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('PIN код не введен'),
                          backgroundColor: Colors.redAccent,
                        ));
                      }
                      else{
                        var response = await newMemberPin(email, pinController.text);
                        print(response);
                        var responseXml = response[0].toString();
                        if (responseXml.contains('<error>')) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Указан неверный PIN код!'),
                            backgroundColor: Colors.redAccent,));
                        }
                        else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  backgroundColor: DarkThemeColors.tinkbg00,
                                  content: const Text('Регистрация прошла успешно! Теперь вы можете войти, запросив новый PIN код для авторизации.', style: TextStyle(color: DarkThemeColors.white),),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.popUntil(context, (route) => false);
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                                        },
                                        child: const Text('Ок', style: TextStyle(color: DarkThemeColors.primary00),)
                                    )],
                                );
                              });
                        }
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