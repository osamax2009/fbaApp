import 'package:fba/Controllers/SendData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CustomBottomNavBar.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../../size_config.dart';
import '../Home/TopHead.dart';
import '../RequestScreen/RequestScreen.dart';
import 'Components/ButtonForSettings.dart';
import 'SettingButtonMenu.dart';


class SettingScreen extends StatelessWidget {
  static String routeName  = 'setting';
  const SettingScreen({Key? key}) : super(key: key);

  Future<String> getUserInfo() async {
    SendData sendData = SendData();

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.settings),

        resizeToAvoidBottomInset: false,
        body: FutureBuilder<String>(
            future: getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  decoration: const BoxDecoration(color: primaryColor),
                  width: double.infinity,
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon:const Icon(Icons.arrow_back_ios,color: lightGrey  ,)),
                            Text("Settings",
                                style: TextStyle(
                                    color: lightGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      SettingButtonMenu(),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("Erorr in your data"),
                    ),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Go Back"))
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Go Back"))
                  ],
                );
              }
            }),
      ),
    );
  }
}



