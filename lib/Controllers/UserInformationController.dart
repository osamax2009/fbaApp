


import 'dart:convert';
import 'package:fba/Controllers/SendData.dart';
import 'package:http/http.dart' as http;


import 'User.dart';


class UserInformationController {
  SendData sendData = SendData();
  Future<User?> getUserInfo() async {
    var token;
    await sendData.getToken().then((value) => token = value);

    final response = await http.post(
      Uri.parse('https://faadminpanel.herokuapp.com/api/auth/showuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },


      body: jsonEncode({
        "token": token
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("we are innnnnnnnnnnnnnn for now");
      var user = User.fromJson(jsonDecode(response.body));


      return user;
    }
  }
}