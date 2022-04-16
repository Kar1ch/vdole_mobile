import 'package:http/http.dart';
import 'package:xml_parser/xml_parser.dart';

var mob = '4';
var link = Uri.parse('http://vdole.co/serv.php');

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