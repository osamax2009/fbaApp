import 'dart:typed_data';

import 'package:fba/Screens/FetchContactScreen/AddFamilyScreen/AddFamilyMembersScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../size_config.dart';

class FetchContact extends StatefulWidget {
  static String routeName  = ' addfamily';

  FetchContact({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<FetchContact> createState() => _FetchContactState();
}

class _FetchContactState extends State<FetchContact> {
  List<Contact>? contacts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();

  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      print(contacts![0]);
      print(contacts![1]);
      // print(contacts![2]);
      setState(() {});
    }
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
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(color: primaryColor),
          width: double.infinity,
          child: ListView(
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.04),
                      child: Text("Fetch Contacts",
                          style: TextStyle(
                              color: lightGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    // width: SizeConfig.screenWidth * 0.5,

                      height: SizeConfig.screenHeight * 0.3,
                      child: const Image(
                        image: AssetImage(
                            'assets/img/familyFetchContact.jpg'),
                        fit: BoxFit.fill,
                      )
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.screenHeight * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text("Fetch Contacts",
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: getProportionateScreenHeight(30)
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.screenHeight * 0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("allow app To get Contacts",
                        style: TextStyle(
                          color: darkGrey,
                        )),
                  ],
                ),
              ),

              Container(
                height: SizeConfig.screenHeight - SizeConfig.screenHeight * 0.1,
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: yellow, shape: StadiumBorder()),
                          onPressed: () {
                              print("hi hi iraq ");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFamilyMembersScreen(contacts)));

                          },
                          child: const Text("Save",
                              style: TextStyle(
                                color: primaryColor,
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.screenWidth * 0.02),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );






      // Scaffold(
      //   appBar: AppBar(
      //     title: const Text(
      //       "***  App Name  ***",
      //       style: TextStyle(color: Colors.blue),
      //     ),
      //     centerTitle: true,
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //   ),
      //   body: (contacts) == null
      //       ? Center(child: CircularProgressIndicator())
      //       : ListView.builder(
      //     itemCount: contacts!.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       Uint8List? image = contacts![index].photo;
      //       String num = (contacts![index].phones.isNotEmpty)
      //           ? (contacts![index].phones.first.number)
      //           : "--";
      //       return ListTile(
      //           leading: (contacts![index].photo == null)
      //               ? const CircleAvatar(child: Icon(Icons.person))
      //               : CircleAvatar(backgroundImage: MemoryImage(image!)),
      //           title: Text(
      //               "${contacts![index].name.first} ${contacts![index].name.last}"),
      //           subtitle: Text(num),
      //           onTap: () {
      //             if (contacts![index].phones.isNotEmpty) {
      //               launch('tel: ${num}');
      //             }
      //           });
      //     },
      //   ));
  }
}
