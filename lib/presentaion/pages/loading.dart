import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: DarkThemeColors.background01,
      body: Center(
        child: SpinKitRing(color: DarkThemeColors.primary00),
      ),
    );
  }
}