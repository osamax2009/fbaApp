import 'dart:async';
import 'dart:io';

import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Screens/AddHome/AddHome.dart';
import 'package:fba/Screens/FetchContactScreen/AddFamilyScreen/AddFamilyMembersScreen.dart';
import 'package:fba/Screens/FetchContactScreen/FetchContactScreeen.dart';
import 'package:fba/Screens/Home/HomeSceen.dart';
import 'package:fba/Screens/SignInScreen/SignInScreen.dart';
import 'package:fba/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controllers/User.dart';



class Wrapper extends StatefulWidget {

  @override
  State<Wrapper> createState() => WrapperState();
}

class WrapperState extends State<Wrapper> {
  Future<void> checkTheInternet(context) async {
    SnackBar snackBar = SnackBar(content: Text("check you internet connection"));
    try {

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('disconnected');
    }}

SendData sendData = SendData();
Timer? _timer;
@override
void dispose() {
  super.dispose();
  _timer!.cancel();
}
bool isTrying = true;


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    checkTheInternet(context);
    return  FutureBuilder<String>(
          future: sendData.getToken(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == 'failed') {

               // return AddHome();
                return SignInScreen();
              } else {
               // return AddHome();
                return
                // FetchContact();
                  Consumer<List<dynamic>>(
                      builder: (context, List<dynamic> mylist, child) {

                        if (mylist.isEmpty){
                          // if (isTrying ) {
                          //   _timer = Timer(const Duration(seconds: 60), () {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //      const  SnackBar(content: Text(" you have to Login Again")
                          //       )
                          //     );
                          //     var route = MaterialPageRoute(builder: (context)=> const SignInScreen());
                          //     Navigator.push(context, route);
                          //     _timer!.cancel();
                          //     isTrying = false ;
                          //   });
                          // }


                        return
                          const Material(
                            child:  Scaffold(
                              body: Center(
                                  child:  CircularProgressIndicator()
                              ),
                            )

                        );
                        }else {
                          User user = mylist[0] as User;
                          if ( user.latitude == null){
                            return const AddHome();
                          }else if( mylist[1].isEmpty) {
                            return  FetchContact();
                          } else {
                            return  HomeScreen();
                          }

                        }

                    }
                  );
              }
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(child: CircularProgressIndicator());
            }


          }

    );
  }
}
