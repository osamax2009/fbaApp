import 'package:fba/Models/AppRequest.dart';
import 'package:fba/Screens/SignInScreen/SignInScreen.dart';
import 'package:fba/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Models/Video.dart';
import '../constants.dart';
import 'User.dart';

class SendData {

  Future<String> updateuserinfo(data) async {

    try {
      final response = await http.post(
        Uri.parse('https://faadminpanel.herokuapp.com/api/auth/updateuserinfo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        print( "user body  ${jsonDecode(response.body)}");


        print("the update user result ....... ${jsonDecode(response.body)}");
        if (jsonDecode(response.body)['status'] as bool) {
          return 'success';
        } else {
          print("the update user result ....... ${jsonDecode(response.body)}");
          return jsonDecode(response.body)['message'] ??
              "you have error";
        }
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        print("the update user result ....... ${jsonDecode(response.body)}");
        return 'failed';
        throw Exception('Failed to create album.');
      }
    }catch(e) {
      print("the update user result ....... ${e.toString()}");

      return 'failed';
    }
  }



  Future storeImage(String filepath) async {
    String addimageUrl =
        'https://faadminpanel.herokuapp.com/api/auth/storeimage';
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    try  {
      final request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', filepath));

      http.Response response =
      await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['imagepath']);
        return jsonDecode(response.body)['imagepath'];
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        return 'Failed';
        throw Exception('Failed to store image .');
      }
    }catch (e) {
      return e.toString();
    }
  }

  Future<String> sendOtp(String otp, phone) async {
    print(phone);
    try {
      final response = await http.post(
        Uri.parse('https://faadminpanel.herokuapp.com/api/auth/getotp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"phone": phone, "code": otp}),
      );

      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        print(jsonDecode(response.body));


        print("the otp result ....... ${jsonDecode(response.body)['status']}");
        if (jsonDecode(response.body)['status'] as bool) {
          return 'success';
        } else {
          return jsonDecode(response.body)['errors']['phone'][0] ??
              "you have error";
        }
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        print((response.body));
        return 'failed';
        throw Exception('Failed to create album.');
      }
    }catch(e) {
      return 'failed';
    }
  }

  Future<String> Register(data) async {
    try  {
      final response = await http.post(
        Uri.parse('https://faadminpanel.herokuapp.com/api/auth/createaccount'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        print(jsonDecode(response.body)['token']);
        saveToken(jsonDecode(response.body)['token']);
        return 'success';
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        print((response.body));
        return 'failed';
        throw Exception('Failed to create album.');
      }
    }catch (e){
      return 'failed';
    }
  }

  Future<String> login(data) async {
    final response = await http.post(
      Uri.parse('https://faadminpanel.herokuapp.com/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(jsonDecode(response.body)['token']);
      saveToken(jsonDecode(response.body)['token']);
      return 'success';
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print((response.body));
      return 'failed';
      throw Exception('Failed to create album.');
    }
  }

  Future<String> setLocation(data) async {
    print("ok am in my app  ");
    try {
      final response = await http.post(
        Uri.parse('https://faadminpanel.herokuapp.com/api/auth/setlocation'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        print(jsonDecode(response.body)['message']);

        return 'success';
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        print((response.body));
        return 'failed';
        throw Exception('Failed to create album.');
      }
    }catch (e){
      return 'failed';
    }
  }

  Future<List<AppRequest>> getallrequest() async {
    var token;
    await getToken().then((value) => token = value);
    print(token);
    var data = {
      'token': token
    };
    final response = await http.post(
      Uri.parse('https://faadminpanel.herokuapp.com/api/auth/getallrequests'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("success is success ");
      print(jsonDecode(response.body)["requestlist"]);
      List<AppRequest> myAppRequest = [];
      jsonDecode(response.body)["requestlist"].forEach(
              (itme) => myAppRequest.add(AppRequest.fromJson(itme))
      );


      return myAppRequest;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print((response.body));

      throw Exception('Failed to create album.');
    }
  }

  void saveToken(token) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('token', token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    var token = (prefs.getString('token') ?? 'failed');
    print("getToken() $token");
    return token;
  }

  void logOut(context) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('token', 'failed');
    Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
  }


  showAlert(text, context) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: const Text("Error"),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  color: pressed,
                  padding: const EdgeInsets.all(14),
                  child: const Text("okay"),
                ),
              ),
            ],
          ),
    );
  }

  Future<List<User>> getAlltheappContacts(data) async {
    List<User> myappusers = [];
    print(data["token"]);
    print("data[token]");

    final response = await http.post(
      Uri.parse('https://faadminpanel.herokuapp.com/api/auth/getcontacts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },


      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
        print("we are innnnnnnnnnnnnnn for now");
      var jsonList = jsonDecode(response.body)['appcontacts'];

      jsonList.forEach((itme) {
        User currentContact = User.fromJson(itme as Map<String, dynamic>);

        myappusers.add(currentContact);
      });

      return myappusers;
    } else {
      print("we are innnnnnnnnnnnnnn errorrrrr ");
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print("osama contact + ${jsonDecode(response.body)}");
      return [];
      throw Exception('Failed to create album.');
    }
  }

  Future<bool> addmeasfamily(data) async {
    print(jsonEncode(data));
    final response = await http.post(
      Uri.parse('https://faadminpanel.herokuapp.com/api/auth/addmeasfamily'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },


      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      var addFlowersstate = jsonDecode(response.body)['status'];



      print(" am now check the send request state $addFlowersstate ");

      return addFlowersstate;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      return false;
      throw Exception('Failed to create album.');
    }
  }

  Future<bool> ConfirmFriendShip(requestList) async {
    var data = {
      'requestListchangeState': requestList
    };
    print(jsonEncode(data));
    final response = await http.post(
      Uri.parse('https://faadminpanel.herokuapp.com/api/auth/confirmfriendship'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },


      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      var addFlowersstate = jsonDecode(response.body)['status'];


      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return false;

      throw Exception('Failed to create album.');
    }
  }

  Future<bool> UploadVideo(datax) async {
    var token ;
    await  getToken().then(
            (value) => token = value
    );
    print("token $token");

    String addvideoUrl =
        'https://faadminpanel.herokuapp.com/api/auth/videouploading';
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    final request = http.MultipartRequest('POST', Uri.parse(addvideoUrl))
      ..headers.addAll(headers)
      ..fields['token']=token
      ..fields['title']=datax['title']
      ..fields['description']= datax['description']
      ..files.add(await http.MultipartFile.fromPath('video', datax['video']));

    http.Response response =
    await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.body);
      return false;

      throw Exception('Failed to create album.');
    }
  }

  Stream<List<dynamic>> getThemAll(context) async* {
    var token ;
    await  getToken().then(
            (value) => token = value
    );
    print("token $token");
    var data = {
      'token': token
    };


    print(jsonEncode(data));
    final response = await http.post(
      Uri.parse('https://faadminpanel.herokuapp.com/api/auth/getitall'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },


      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.


      print("am herere today ");
      List<User> familylist = [];
      List<User> friendslist = [];


      await (jsonDecode(response.body)['familylist']).forEach(
              (element) {
            print("begin");
            familylist.add((User.fromJson(element as Map<String, dynamic>)));
            print((User.fromJson(element as Map<String, dynamic>)).email);
          }


      );

      await (jsonDecode(response.body)['friendslist']).forEach(
              (element) {
            print("begin");
            friendslist.add((User.fromJson(element as Map<String, dynamic>)));
            print((User.fromJson(element as Map<String, dynamic>)).email);
          }


      );

      User currentuser = await User.fromJson(jsonDecode(response.body)['user']);
      List<Video>  downloadedVideos =[] ;
      await   (jsonDecode(response.body)['myvideos']).forEach((currentVideo)=>

          downloadedVideos.add(Video.fromJson(currentVideo ))
      );



      var alllist = [currentuser, familylist, friendslist,downloadedVideos];
      yield alllist;
    } else {
      ('Failed to am in gethem all fucntion .');
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      yield [];


      throw Exception('Failed to create album.');
    }
  }


}
