import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Screens/FamilyMembers/FamilyMembers.dart';
import 'package:fba/Screens/FriendsMembers/FriendsMembers.dart';
import 'package:fba/Screens/Settings/SetRadius.dart';
import 'package:fba/Screens/Settings/TermsConditions.dart';
import 'package:flutter/cupertino.dart';

import '../../constants.dart';
import '../../size_config.dart';
import '../FetchContactScreen/FetchContactScreeen.dart';
import 'Components/ButtonForSettings.dart';

class SettingButtonMenu extends StatelessWidget {
  const SettingButtonMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight - SizeConfig.screenHeight * 0.29,
      decoration: const BoxDecoration(
          color: whightbg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      child: ListView(
        children: [
          ButtonForSettings(
            press: (){
              Navigator.pushNamed(context, SetRadius.routeName);
            },
            text: "Set Raduis",
            image: "assets/img/2972185.png",
          ),
          ButtonForSettings(
            press: (){
              Navigator.pushNamed(context, FamilyMembersScreen.routeName);
            },
            text: "Family Members",
            image: "assets/img/family.png",
          ),
          ButtonForSettings(
            press: (){
              Navigator.pushNamed(context, FriendsMembersScreen.routeName);
            },
            text: "Friends Members",
            image: "assets/img/friends.jpg",
          ),
          ButtonForSettings(
            press: (){},
            text: "Change Home location",
            image: "assets/img/changelocationicon.png",
          ),
          ButtonForSettings(
            press: (){},
            text: "Emergencey Number",
            image: "assets/img/phone.png",
          ),
          ButtonForSettings(
            press: (){
              Navigator.pushNamed(context, TermsConditions.routeName);
            },
            text: "Terms & Condition",
            image: "assets/img/TermsCondition.png",
          ),
          ButtonForSettings(
            press: (){},
            text: "About",
            image: "assets/img/images.png",
          ),
          ButtonForSettings(
            press: (){
                SendData sendData = SendData();
                sendData.logOut(context);
            },
            text: "Log out",
            image: "assets/img/tick.png",
          ),
        ],
      ),

    );
  }
}