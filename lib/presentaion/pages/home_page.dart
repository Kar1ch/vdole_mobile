import 'package:flutter/material.dart';
import 'package:vdole_mobile/presentaion/colors.dart';
import 'package:vdole_mobile/presentaion/pages/rating/rating_page.dart';
import 'package:vdole_mobile/presentaion/pages/profile/profile_page.dart';
import 'package:vdole_mobile/presentaion/pages/portfolio/portfolio.dart';
import 'package:vdole_mobile/storage.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key, required this.model}) : super(key: key);
  final AppModel model;
  @override
  _HomePageState createState() => _HomePageState();//Единица указана до тех пор пока не прекратится отладка профиля

}

class _HomePageState extends State<HomePage>{

  int _activePage = 0;

  @override
  Widget build(BuildContext context){
    widget.model.checkAuth();
    final List<Widget> _tabItems = [const RatingPage(), const PortfolioPage(), ProfilePage(model: widget.model)];
    return Scaffold(
      body: _tabItems[_activePage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: DarkThemeColors.tinkbg01,
        selectedItemColor: DarkThemeColors.primary00,
        selectedLabelStyle: const TextStyle(color: DarkThemeColors.white),
        unselectedItemColor: DarkThemeColors.deactive,
        currentIndex: _activePage,
        onTap: (index) => setState(() => _activePage = index),
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.shopping_bag),
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Портфолио',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outlined),
            label: 'Профиль',
          ),
        ],
      ),
      backgroundColor: DarkThemeColors.background01,
    );
  }
}