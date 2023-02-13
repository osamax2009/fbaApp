import 'package:fba/Controllers/SendData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../../Controllers/User.dart';
import '../../CustomBottomNavBar.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../../size_config.dart';
import 'PoliceIntraction.dart';
import 'TopHead.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home';
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _hasCallSupport = false;

  List<String> recipients =[] ;

  List<User> familyList=[];

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
      child: Consumer<List<dynamic>>(
          builder: (context, List<dynamic> mylist, child) {

            User currentuser = mylist[0];
            familyList = mylist[1];
            if (recipients.isEmpty) {
              familyList.forEach(
                      (item) {
                    print(item.phone!);
                    item.phone?? recipients.add(item.phone.toString());
                  }
              );
            }

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              bottomNavigationBar:
                  CustomBottomNavBar(selectedMenu: MenuState.home),
              resizeToAvoidBottomInset: false,
              body: Stack(children: [
                Container(
                  decoration: const BoxDecoration(color: whightbg),
                  width: double.infinity,
                ),
                TopHead(image:currentuser.profileimage!),
                Positioned(
                  top: SizeConfig.screenHeight * 0.13,
                  left: SizeConfig.screenWidth * 0.1,
                  right: SizeConfig.screenWidth * 0.1,
                  child: PolicIntractionButton(),
                ),
                Positioned(
                  top: SizeConfig.screenHeight * 0.4,
                  left: SizeConfig.screenWidth * 0.1,
                  child: const Text(
                    "Our Features",
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                  ),
                ),
                Positioned(
                  top: SizeConfig.screenHeight * 0.45,
                  left: SizeConfig.screenWidth * 0.1,
                  right: SizeConfig.screenWidth * 0.1,
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.1,
                    height: SizeConfig.screenHeight * 0.4,
                    child: GridView(
                      children: [
                        InkWell(
                          onTap: (){
                            _sendSMStoFriens();
                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.08,
                            height: SizeConfig.screenHeight * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 2, color: darkGrey),
                            ),
                            child: Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Image(
                                    image: AssetImage("assets/img/interaction.png"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "SOS",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Text(
                                  "Frinds",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            _sendSMStoFamily();
                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.08,
                            height: SizeConfig.screenHeight * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 2, color: darkGrey),
                            ),
                            child: Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Image(
                                    image: AssetImage("assets/img/family.png"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "SOS",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Text(
                                  "Family",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.08,
                            height: SizeConfig.screenHeight * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 2, color: darkGrey),
                            ),
                            child: Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Image(
                                    image: AssetImage("assets/img/antivirus.png"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "SOS",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Text(
                                  "Check our Services",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            FlutterPhoneDirectCaller.callNumber("111");

                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.08,
                            height: SizeConfig.screenHeight * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 2, color: darkGrey),
                            ),
                            child: Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Image(
                                    image: AssetImage("assets/img/phone.png"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "SOS",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Text(
                                  "Check our Services",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                    ),
                  ),
                ),
              ])),
        );
      }),
    );
  }

  final String _canSendSMSMessage =
      'pls help me , pls';

  bool sendDirect = true;

  Future<void> _sendSMStoFamily() async {




    try {
      String _result = await sendSMS(
        message: _canSendSMSMessage,
        recipients: ["1234567890", "5556787676","1234567834"],
        sendDirect: false,
      );
      print(_result);
    } catch (error) {
     print(error.toString());
    }
  }

  Future<void> _sendSMStoFriens() async {




    try {
      String _result = await sendSMS(
        message: _canSendSMSMessage,
        recipients: ["1234567890", "5556787676","1234567834"],
        sendDirect: false,
      );
      print(_result);
    } catch (error) {
      print(error.toString());
    }
  }


}
