import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({Key? key}) : super(key: key);

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
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Введите Email',
                ),
              ),
            )
          ]
        ),
      ),
      backgroundColor: DarkThemeColors.tinkbg00,
    );
  }
}