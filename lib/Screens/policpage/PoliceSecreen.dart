
import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Screens/Home/HomeSceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import '../../../Controllers/User.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

import 'Header.dart';

class PoliceScreen extends StatefulWidget {

  static String routeName = 'PoliceScreen' ;

  PoliceScreen();


  @override
  State<PoliceScreen> createState() =>
      _PoliceScreenScreenState();
}

class _PoliceScreenScreenState extends State<PoliceScreen> {
  SendData sendData = SendData();
  bool _value = false;
  String? _message, body;
  bool isLoading  = false ;
  final String _canSendSMSMessage =
      'install Fba App form this link http//32343sdsd233.com/ssdae/sfd';
  List<String> people = [];
  List<int> apppeople = [];
  bool sendDirect = false;
  List<User> listofUserApp = [];


  returnHome(contextx){

    Navigator.pushNamed(
        context,
        HomeScreen.routeName);
  }


  bool isinVitationenable = false;


  List<Contact>? contacts;

  late List<Widget> swtichButtonsList;

  void appuserswitcher() {
    if (isinVitationenable == true) {
      setState(() {
        isinVitationenable = false;
      });
    } else {
      setState(() {
        isinVitationenable = true;
      });
    }
  }

  Future<List<User>> getAppUsers() async {
    SendData sendData = SendData();
    var mycomoncontacts = [];
    var token = await sendData.getToken();
    contacts!.forEach((element) {
      if (element.phones.isNotEmpty) {
        mycomoncontacts.add((element.phones.first.number).toString());
      }
    });

    var data = {"token": token, "contacts": mycomoncontacts};
    var list = await sendData.getAlltheappContacts(data);

    return list;
  }

  var appUsers = [];
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
          resizeToAvoidBottomInset: false,
          body: Consumer<List<dynamic>>(
              builder: (context, List<dynamic> mylist, child) {
                return
                  Container(
                    decoration: const BoxDecoration(color: primaryColor),
                    width: double.infinity,
                    child: ListView(
                      //  mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Header(),
                        Container(
                          height: SizeConfig.screenHeight -
                              SizeConfig.screenHeight * 0.1,
                          decoration: const BoxDecoration(
                              color: whightbg,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.02,
                                horizontal: SizeConfig.screenHeight * 0.05),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                /// this section is for the listview
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    //  margin: EdgeInsets.symmetric(vertical:SizeConfig.screenHeight * 0.02 ),
                                    height: SizeConfig.screenHeight * 0.6,
                                    child: GridView.builder(
                                      itemCount: mylist[1].length,
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 2,
                                          mainAxisSpacing: 2),
                                      itemBuilder: (cx, i) => Container(
                                        width: SizeConfig.screenWidth * 0.5,
                                        height:
                                        SizeConfig.screenHeight * 0.3,
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(5),
                                              width:
                                              SizeConfig.screenWidth *
                                                  0.5,
                                              height:
                                              SizeConfig.screenHeight *
                                                  0.2,
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  color: lightGrey,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                                  border: Border.all(
                                                      color: yellow)),
                                              child: Column(children: [
                                                mylist[1][i]
                                                    .profileimage !=
                                                    null
                                                    ? CircleAvatar(
                                                  backgroundImage:
                                                  Image.network(mylist[1][i]
                                                      .profileimage!)
                                                      .image,
                                                  maxRadius: 20,
                                                )
                                                    : CircleAvatar(
                                                  backgroundImage:
                                                  Image.asset(
                                                      "assets/img/default-avatar.png")
                                                      .image,
                                                  maxRadius: 20,
                                                ),
                                                Text(
                                                  mylist[1][i].name!
                                                      .substring(0, 5),
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 10),
                                                  textAlign:
                                                  TextAlign.center,
                                                ),
                                                Text(
                                                  mylist[1][i].phone
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 10),
                                                  textAlign:
                                                  TextAlign.center,
                                                ),
                                              ]),
                                            ),
                                            Positioned(
                                              top: -10,
                                              right: -10,
                                              child: Checkbox(
                                                checkColor: Colors.black,
                                                activeColor: Colors.white,
                                                value: apppeople.contains(
                                                    mylist[1][i]
                                                        .phone
                                                ),
                                                onChanged: (value) {

                                                  if (apppeople.contains(
                                                      mylist[1][i]
                                                          .phone)) {

                                                    setState(() {
                                                      apppeople.remove(
                                                          mylist[1][i]
                                                              .phone);
                                                    });
                                                  } else {
                                                    print(apppeople);
                                                    setState(() {
                                                      apppeople.add(
                                                          mylist[1][i]
                                                              .phone!);
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.screenWidth * 0.02),
                                ),
                                Container(
                                  width: SizeConfig.screenWidth * 0.8,
                                  height: SizeConfig.screenHeight * 0.07,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: yellow, shape: StadiumBorder()),
                                    onPressed: () {

                                    },
                                    child:const Text(
                                        'Remove Selected',
                                        style: TextStyle(
                                          color: primaryColor,
                                        )),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
              }
          ) ,
        )
    );

  }
}
