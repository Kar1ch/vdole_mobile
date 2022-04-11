import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State{

  final _formKey = GlobalKey<FormState>();

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
                key: _formKey,
                style: const TextStyle(color: DarkThemeColors.deactive),
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
                  //fillColor: DarkThemeColors.tinkbg01,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              color: Colors.green,
              child: TextButton(
                onPressed: (){
                  //if(_formKey.currentState.)
                },
                child: Text("Отправить", style: TextStyle(color: DarkThemeColors.tinkbg00),),
              ),
            )
          ]
        ),
      ),
      backgroundColor: DarkThemeColors.tinkbg00,
    );
  }
}