import 'package:localstorage/localstorage.dart';

class CookieStorage {
  final LocalStorage cookiestorage = LocalStorage('vdole_localstorage');

  CookieStorage(){
    cookiestorage.setItem('cookie', '');
  }

  void setcookie(var newcookie) {
    cookiestorage.setItem('cookie', newcookie);
  }

  String getcookie(){
    return cookiestorage.getItem('cookie');
  }

  void deletecookie() {
    cookiestorage.setItem('cookie', '');
  }

  bool isauthorised(){
    return cookiestorage.getItem('cookie') == '' ? false : true;
  }
}

CookieStorage cookieStorage = CookieStorage();