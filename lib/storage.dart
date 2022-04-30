import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage{
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getCookie() => _secureStorage.read(key: 'cookie');
  Future<void> setCookie(String value) => _secureStorage.write(key: 'cookie', value: value);
  Future<void> delCookie() => _secureStorage.delete(key: 'cookie');
}

class AppModel{
  final storage = Storage();
  var _isauth = false;
  bool get isAuth => _isauth;

  Future<void> checkAuth() async{
    final cookie = await storage.getCookie();
    _isauth = cookie != null;
  }
}