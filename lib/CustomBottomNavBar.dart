import 'package:fba/Screens/Home/HomeSceen.dart';
import 'package:fba/Screens/Settings/SettingsScreen.dart';
import 'package:fba/size_config.dart';
import 'package:flutter/material.dart';
import 'Screens/RequestScreen/RequestScreen.dart';
import 'Screens/Video Screen/VideoScreen.dart';
import 'constants.dart';
import 'enums.dart';


class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
     // padding: EdgeInsets.symmetric(vertical: 14),
      height: SizeConfig.screenHeight * 0.08,
      decoration: BoxDecoration(
        color: yellow,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],

      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: ()=>
              Navigator.pushNamed(context,RequestScreen.routeName ),
                child: Container(
                  width: SizeConfig.screenWidth * 0.25,
                  height: double.infinity,
                  decoration: BoxDecoration(
                   color:  MenuState.request == selectedMenu
                       ? whightbg
                       : yellow,
            border: Border.all(
                width: 1,
                color: MenuState.request == selectedMenu
                    ? primaryColor
                    : yellow,
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
            ),
          ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(Icons.chat_bubble,
                          color: MenuState.request == selectedMenu
                              ? primaryColor
                              : whightbg,
                        ),
                      Text(
                        "Requests",
                        style: TextStyle(color: MenuState.request == selectedMenu
                            ? primaryColor
                            : whightbg,),
                      ),

                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: ()=>
                    Navigator.pushNamed(context,HomeScreen.routeName ),
                child: Container(
                  width: SizeConfig.screenWidth * 0.25,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color:  MenuState.home == selectedMenu
                        ? whightbg
                        : yellow,
                    border: Border.all(
                      width: 1,
                      color: MenuState.home == selectedMenu
                          ? primaryColor
                          : yellow,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home,
                        color: MenuState.home == selectedMenu
                            ? primaryColor
                            : whightbg,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(color: MenuState.home == selectedMenu
                            ? primaryColor
                            : whightbg,),
                      ),

                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: ()=>
                    Navigator.pushNamed(context,VideoScreen.routeName ),
                child: Container(
                  width: SizeConfig.screenWidth * 0.25,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color:  MenuState.videos == selectedMenu
                        ? whightbg
                        : yellow,
                    border: Border.all(
                      width: 1,
                      color: MenuState.videos == selectedMenu
                          ? primaryColor
                          : yellow,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.video_settings_rounded,
                        color: MenuState.videos == selectedMenu
                            ? primaryColor
                            : whightbg,
                      ),
                      Text(
                        "Videos",
                        style: TextStyle(color: MenuState.videos == selectedMenu
                            ? primaryColor
                            : whightbg,),
                      ),

                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: ()=>
                    Navigator.pushNamed(context,SettingScreen.routeName ),
                child: Container(
                  width: SizeConfig.screenWidth * 0.25,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color:  MenuState.settings == selectedMenu
                        ? whightbg
                        : yellow,
                    border: Border.all(
                      width: 1,
                      color: MenuState.settings == selectedMenu
                          ? primaryColor
                          : yellow,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings,
                        color: MenuState.settings == selectedMenu
                            ? primaryColor
                            : whightbg,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(color: MenuState.settings == selectedMenu
                            ? primaryColor
                            : whightbg,),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
