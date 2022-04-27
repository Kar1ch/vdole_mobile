import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:vdole_mobile/storage.dart';

class PortfolioPage extends StatelessWidget{
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
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
      backgroundColor: DarkThemeColors.background01,
    );
  }
}