import 'package:localstorage/localstorage.dart';

class CookieStorage {
  final LocalStorage cookiestorage = LocalStorage('vdole_localstorage');

  void setcookie(var newcookie) {
    cookiestorage.setItem('cookie', newcookie);
  }

  String getcookie(){
    return cookiestorage.getItem('cookie');
  }

  void deletecookie() {
    cookiestorage.deleteItem('cookie');
  }
}

CookieStorage cookieStorage = CookieStorage();