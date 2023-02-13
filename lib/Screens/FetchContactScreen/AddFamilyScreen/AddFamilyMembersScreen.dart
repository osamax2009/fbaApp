
import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Screens/Home/HomeSceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../../Controllers/User.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'Header.dart';

class AddFamilyMembersScreen extends StatefulWidget {
  AddFamilyMembersScreen(this.contacts);
  List<Contact>? contacts;

  @override
  State<AddFamilyMembersScreen> createState() =>
      _AddFamilyMembersScreenState(contacts);
}

class _AddFamilyMembersScreenState extends State<AddFamilyMembersScreen> {
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

  Future<void> _sendSMS(List<String> recipients) async {
    try {
      String _result = await sendSMS(
        message: _canSendSMSMessage,
        recipients: recipients,
        sendDirect: sendDirect,
      );
      setState(() => _message = _result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }
Future<void>  sendRequesttofollow(apppeople,BuildContext contextx) async {
    SendData sendData = SendData();
 late  String token ;
    await sendData.getToken().then((value) =>
      token = value
    );
  Map<String,dynamic>  data = {
      'token' :  token,
    'appusers':apppeople,
    };
  var state ;
    await sendData.addmeasfamily(data).then(
            (current) => state = current );
    if (state){
         returnHome(contextx);
    }else {
      setState(() {
        isLoading = false;
      });
    }





}

  bool isinVitationenable = false;

  _AddFamilyMembersScreenState(this.contacts);

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
    print(mycomoncontacts);



    var data = {"token": token, "contacts": mycomoncontacts};
    var list ;
    await sendData.getAlltheappContacts(data).then(
            (value) {
              setState(() {
              });
              return list = value;
            }

    );

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
        body: isLoading ? Center(child: CircularProgressIndicator(),) :FutureBuilder<List<User>>(
            future: getAppUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
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
                              Container(
                                width: SizeConfig.screenWidth * 0.8,
                                height: SizeConfig.screenHeight * 0.07,
                                child: Stack(
                                    children: isinVitationenable
                                        ? [
                                            Positioned(
// top: MediaQuery.of(context).size.height * 0.45,
                                              right:
                                                  0, // the position from the right
                                              child: Container(
                                                width: SizeConfig.screenWidth *
                                                    0.5,
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.07,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 70.0, top: 0),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      appuserswitcher();
                                                    },
                                                    child: Text(
                                                      "Send Invites",
                                                      style: TextStyle(
                                                          color: whightbg),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: primaryColor),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
//SizeConfig.screenWidth - SizeConfig.screenWidth * 0.7,
                                              child: Container(
// alignment: Alignment.
                                                width: SizeConfig.screenWidth *
                                                    0.5,
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.07,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 80, top: 0),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      appuserswitcher();
                                                    },
                                                    child: Text(
                                                      "App Users",
                                                      style: TextStyle(
                                                          color: primaryColor),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: yellow),
                                              ),
                                            ),
                                          ]
                                        : [
                                            Positioned(
                                              left: 0,
                                              child: Container(
                                                width: SizeConfig.screenWidth *
                                                    0.5,
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.07,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 80, top: 0),
                                                  child: TextButton(
                                                    child: Text(
                                                      "App Users",
                                                      style: TextStyle(
                                                          color: whightbg),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        appuserswitcher();
                                                      });
                                                    },
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: primaryColor),
                                              ),
                                            ),
                                            Positioned(
// top: MediaQuery.of(context).size.height * 0.45,
                                              right:
                                                  0, // the position from the right
                                              child: Container(
                                                width: SizeConfig.screenWidth *
                                                    0.5,
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.07,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 40, top: 0),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      appuserswitcher();
                                                    },
                                                    child: const Text(
                                                      "Send Invites",
                                                      style: TextStyle(
                                                          color: primaryColor),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: yellow),
                                              ),
                                            ),
                                          ]),
                              ),




                              /// this section is for the listview


                              isinVitationenable
                                  ? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        //  margin: EdgeInsets.symmetric(vertical:SizeConfig.screenHeight * 0.02 ),
                                        height: SizeConfig.screenHeight * 0.6,
                                        child: GridView.builder(
                                          itemCount: snapshot.data!.length,
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
                                                    snapshot.data![i]
                                                                .profileimage !=
                                                            null
                                                        ? CircleAvatar(
                                                            backgroundImage:
                                                                Image.network(snapshot
                                                                        .data![
                                                                            i]
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
                                                        snapshot.data![i].name!.length < 5 ? "name too short":  snapshot.data![i].name!
                                                          .substring(0, 5),
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 10),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      snapshot.data![i].phone
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
                                                        snapshot.data![i]
                                                            .phone
                                                           ),
                                                    onChanged: (value) {

                                                      if (apppeople.contains(
                                                          snapshot.data![i]
                                                              .phone)) {

                                                        setState(() {
                                                          apppeople.remove(
                                                              snapshot.data![i]
                                                                 .phone);
                                                        });
                                                      } else {
                                                        print(apppeople);
                                                        setState(() {
                                                          apppeople.add(
                                                              snapshot.data![i]
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
                                    )
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.screenHeight * 0.02),
                                      height: SizeConfig.screenHeight * 0.6,
                                      child: GridView.builder(
                                        itemCount: contacts!.length,
                                        itemBuilder: (cx, i) => contacts![i].phones.isEmpty? Visibility(visible: false, child: Container())  : Container(
                                          width: SizeConfig.screenWidth * 0.5,
                                          height: SizeConfig.screenHeight * 0.4,
                                          child: Stack(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                width: SizeConfig.screenWidth *
                                                    0.5,
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.4,
                                                padding: EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: lightGrey,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: darkGrey)),
                                                child: Column(children: [
                                                  contacts![i].photo != null
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              Image.memory(
                                                                      contacts![
                                                                              i]
                                                                          .photo!)
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
                                                    contacts![i]
                                                        .displayName
                                                        ,
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 10),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    contacts![i]
                                                        .phones
                                                        .first
                                                        .number,
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 10),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ]),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: -10,
                                                child: Checkbox(
                                                  checkColor: Colors.black,
                                                  activeColor: Colors.white,
                                                  value: people.contains(
                                                      contacts![i]
                                                          .phones
                                                          .first
                                                          .number),
                                                  onChanged: (value) {
                                                    if (people.contains(
                                                        contacts![i]
                                                            .phones
                                                            .first
                                                            .number)) {
                                                      setState(() {
                                                        people.remove(
                                                            contacts![i]
                                                                .phones
                                                                .first
                                                                .number);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        people.add(contacts![i]
                                                            .phones
                                                            .first
                                                            .number);
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 3 / 2,
                                                crossAxisSpacing: 2,
                                                mainAxisSpacing: 2),
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
                                    if (isinVitationenable) {
                                     setState(() {
                                       isLoading = true;
                                     });
                                     sendRequesttofollow(apppeople,context);

                                    } else {
                                      _sendSMS(people)
                                          .then((success) =>
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()))
                                      );
                                    }
                                  },
                                  child: Text(
                                      isinVitationenable
                                          ?"Send Requests to family members"
                                          : "Send Inventions",

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
