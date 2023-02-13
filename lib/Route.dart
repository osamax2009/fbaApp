
import 'package:fba/Screens/FamilyMembers/FamilyMembers.dart';
import 'package:fba/Screens/FriendsMembers/FriendsMembers.dart';
import 'package:fba/Screens/Home/HomeSceen.dart';
import 'package:fba/Screens/Settings/SetRadius.dart';
import 'package:fba/Screens/Settings/SettingsScreen.dart';
import 'package:fba/Screens/Settings/TermsConditions.dart';
import 'package:flutter/widgets.dart';
import 'Screens/FetchContactScreen/FetchContactScreeen.dart';
import 'Screens/RequestScreen/RequestScreen.dart';
import 'Screens/Video Screen/VideoScreen.dart';

final Map<String,WidgetBuilder>  routes = {

  SettingScreen.routeName  : (context)=> SettingScreen(),
  HomeScreen.routeName: (context)=>HomeScreen(),
  RequestScreen.routeName: (context)=>RequestScreen(),
  VideoScreen.routeName: (context)=>VideoScreen(),
  SetRadius.routeName: (context)=>SetRadius(),
  FetchContact.routeName: (context)=>FetchContact(),
  FamilyMembersScreen.routeName: (context)=>FamilyMembersScreen(),
  FriendsMembersScreen.routeName: (context)=>FriendsMembersScreen(),
  TermsConditions.routeName:(context)=>TermsConditions(),
};