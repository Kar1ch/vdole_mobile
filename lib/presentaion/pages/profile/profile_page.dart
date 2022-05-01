import 'package:vdole_mobile/presentaion/pages/loading.dart';
import 'package:vdole_mobile/presentaion/pages/profile/memberpin.dart';
import 'package:vdole_mobile/presentaion/pages/profile/newmembergen.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:vdole_mobile/requests/requests.dart';
import 'package:vdole_mobile/storage.dart';

class ProfilePage extends StatelessWidget {

  ProfilePage({Key? key, required this.model}) : super(key: key);

  final AppModel model;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context){
    /// Проверка на автоавторизацию
    if(!model.isAuth) {
      return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 8),
          child: ListView(
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                /// Поле ввода Email
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
                /// Кнопка отправить
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
                      /// Проверка на корректность введенного email
                      if (!EmailValidator.validate(emailController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Почта введена некорректно"),
                              backgroundColor: Colors.redAccent,));
                      }
                      else {
                        try {
                          /// Страница заглушка
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadingPage()));
                          /// Отправка запроса на авторизацию и его последующий парсинг
                          var response = await preLogRequest(
                              emailController.text);
                          var responseXml = response[0].toString();
                          var responseXmlText = response[1].toString();
                          if (responseXml.contains('<error>')) {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: DarkThemeColors.tinkbg00,
                                    content: Text(responseXmlText.replaceAll('(#noMail)', 'Создать для вас новый профиль инвестора?'),
                                      style: const TextStyle(
                                          color: DarkThemeColors.white),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: (){
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(builder: (context) =>
                                                    NewMemberGen(
                                                      email: emailController.text,
                                                      model: model,)));
                                          },
                                          child: const Text('Да', style: TextStyle(color: DarkThemeColors.primary00),)
                                      ),
                                      TextButton(onPressed: () { Navigator.pop(context); },
                                          child: const Text('Нет', style: TextStyle(color: DarkThemeColors.deactive),)
                                      ),
                                    ],
                                  );
                                });
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(responseXmlText), backgroundColor: DarkThemeColors.primary00,));
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) =>
                                    MemberPin(
                                        email: emailController.text,
                                        model: model)
                                )
                            );
                          }
                        } finally {}
                      }
                    },
                    child: const Text("Отправить", style: TextStyle(color: DarkThemeColors.white),),
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
                /// Кнопка выхода из аккаунта
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      primary: DarkThemeColors.primary00,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),),
                    ),
                    onPressed: () {
                      /// Удаление локальный cookie анных пользователя и отправка запроса на прерывание сессии
                      model.storage.delCookie();
                      exitFromProfile();
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: const Text('Выйти из аккаунта', style: TextStyle(color: DarkThemeColors.white),),
                  ),
                ),
                /// Кнопка удаления аккаунта
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      primary: DarkThemeColors.primary00,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18),),
                    ),
                    onPressed: () async{
                      /// Отправка запроса на удаление профиля и удаление cookie данных
                      var response = await deleteProfile(model.storage.getCookie());
                      model.storage.delCookie();
                      var responseXml = response[0].toString();
                      String msg = responseXml.substring(responseXml.indexOf('<done>') + 6, responseXml.indexOf("</done", responseXml.indexOf('<done>') + 7)) + " " +
                          responseXml.substring(responseXml.indexOf('<STRONG>') + 8, responseXml.length - 24);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: DarkThemeColors.primary00,));
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: const Text('Удалить аккаунт', style: TextStyle(color: DarkThemeColors.white),),
                  ),
                ),
              ],
          ),
        ),
        backgroundColor: DarkThemeColors.tinkbg00,
      );
    }
  }
}