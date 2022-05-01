import 'package:http/http.dart';
import 'package:xml_parser/xml_parser.dart';

var mob = '4';
var link = Uri.parse('http://vdole.co/serv.php');

/// Запрос на получение пользователем PIN кода
Future<dynamic> preLogRequest(String logEmail) async{
  var response = await post(
      link,
      body: {
        'mob' : mob,
        'comm' : '25',
        'logEmail' : logEmail,
      }
  );
  var responseXml = XmlElement.parseString(response.body);
  var responseXmlText = XmlText.parseString(response.body);
  return [responseXml![0], responseXmlText![0]];
}

/// Запрос на авторизацию пользователя
Future<dynamic> memberPin(String logEmail, String logPin) async{
  var response = await post(
      link,
      body: {
        'mob' : mob,
        'comm' : '1',
        'email' : logEmail,
        'code' : logPin,
      }
  );
  var responseXml = XmlElement.parseString(response.body);
  var responseXmlText = XmlText.parseString(response.body);
  return [responseXml![0], responseXmlText![0]];
}

/// Запрос на создание нового пользователя и отправки ему PIN коода для подтверждения почты
Future<dynamic> newMemberGen(String logEmail) async{
  var response = await post(
      link,
      body: {
        'mob' : mob,
        'comm' : '25',
        'newLogEmail' : logEmail,
      }
  );
  var responseXml = XmlElement.parseString(response.body);
  var responseXmlText = XmlText.parseString(response.body);
  return [responseXml![0], responseXmlText![0]];
}

/// Запрос на подтверждение почты новым пользователем
Future<dynamic> newMemberPin(String logEmail, String logPin) async{
  var response = await post(
      link,
      body: {
        'mob' : mob,
        'comm' : '11',
        'status_r' : '1',
        'mail_r' : logEmail,
        'code_r' : logPin,
        'agent' : '1',
      }
  );
  var responseXml = XmlElement.parseString(response.body);
  var responseXmlText = XmlText.parseString(response.body);
  return [responseXml![0], responseXmlText![0]];
}

/// Запрос на подтверждение авто-авторизации пользователя
Future<dynamic> autoAuth(String cookie) async{
  var response = await post(
      link,
      body: {
        'mob' : mob,
        'comm' : '3',
        'cookie' : cookie,
      }
  );
  var responseXml = XmlElement.parseString(response.body);
  var responseXmlText = XmlText.parseString(response.body);
  return [responseXml![0], responseXmlText![0]];
}

/// Запрос на выход из профиля
Future<dynamic> exitFromProfile() async{
  var response = await post(
      link,
      body: {
        'mob' : mob,
        'comm' : '2',
      }
  );
  var responseXml = XmlElement.parseString(response.body);
  var responseXmlText = XmlText.parseString(response.body);
  return [responseXml![0], responseXmlText![0]];
}

/// Запрос на удаление профиля
Future<dynamic> deleteProfile(Future<String?> cookie) async{
  String? _cookie = await cookie;
  var response = await post(
      link,
      body: {
        'mob' : mob,
        'comm' : '4',
        'cookie' : _cookie.toString(),
        'order' : '3',
      }
  );
  var responseXml = XmlElement.parseString(response.body);
  var responseXmlText = XmlText.parseString(response.body);
  return [responseXml![0], responseXmlText![0]];
}
