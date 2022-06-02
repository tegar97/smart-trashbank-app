import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String? _url = 'https://smartbank.nextcode.id/api/auth';
  // 192.168.1.2 is my IP, change with your IP address
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!)['token'];
  }

  auth(data, apiURL) async {
    Uri fullUrl =  Uri.parse(_url! + apiURL);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiURL) async {
    var fullUrl = Uri.parse(_url! + apiURL);
    await _getToken();
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
