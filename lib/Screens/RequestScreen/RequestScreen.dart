import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Models/AppRequest.dart';
import 'package:fba/Screens/RequestScreen/TopHeadOfRequestScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../CustomBottomNavBar.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../../size_config.dart';
import '../Home/TopHead.dart';


class RequestScreen extends StatefulWidget {
  static String routeName  = 'request';
   RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  SendData sendData = SendData();


  sendRequestUpdate(context) async {
    setState(() {
      isLoading = true;
    });
    bool state = false  ;
  await  sendData.ConfirmFriendShip(
        requestStateList
    ).then((value) =>
        state= value
    );
    if (state){
      setState(() {
        isLoading = false;
      });
      sendData.showAlert("data saved successfully", context);
      Navigator.pop(context);

    }else {
      setState(() {
        isLoading = false;
      });
      sendData.showAlert("nothing happened !!", context);


    }
  }

 var  requestStateList = [];

 var checkedList = [];
 bool isLoading = false ;

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
      child:  Scaffold(
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.request),
        resizeToAvoidBottomInset: false,
        body:isLoading ? Center(child: CircularProgressIndicator(),): FutureBuilder<List<AppRequest>>(
            future: sendData.getallrequest(),
            builder: (context,AsyncSnapshot<List<AppRequest>> snapshot) {
              if (snapshot.hasData) {
                return Stack(children: [
                  Container(
                    decoration: const BoxDecoration(color: primaryColor),
                    width: double.infinity,
                  ),
                  TopHeadOfRequestScreen(
                      saveFunction:()=>sendRequestUpdate(context)
                  ),
              Positioned(
                top: SizeConfig.screenHeight - SizeConfig.screenHeight* 0.9,
                child: Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                decoration: const BoxDecoration(
                color: whightbg,
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20))),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (cx,i)=>  Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 25.0,vertical: 10),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),

                        child: Container(
                          //padding: EdgeInsets.all(10),
                          height: SizeConfig.screenHeight * 0.26,
                          decoration: BoxDecoration(
                            color: checkedList.contains(snapshot.data![i].requestid)? Colors.grey: whightbg,
                              border: Border.all(
                                color: Colors.black
                              ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(

                            children: [
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: SizeConfig.screenHeight * 0.07,
                                    backgroundImage: NetworkImage(snapshot.data![i].image!),

                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data![i].name!,
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: getProportionateScreenHeight(25)
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text("want to add you as family member",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: getProportionateScreenHeight(12)
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.screenHeight * 0.05,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              Container(
                                height: SizeConfig.screenHeight * 0.08,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: primaryColor
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                Container(
                                width: SizeConfig.screenWidth *0.25,


                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary:  pressed,
                                        shape: StadiumBorder()
                                    ),
                                    onPressed: (){





                                        requestStateList.add(
                                            {
                                              'id': snapshot.data![i].requestid,
                                              'state': 'accept'
                                            }

                                        );
                                        setState(() {
                                          checkedList.add(snapshot.data![i].requestid);
                                        });







                                    }, child: const Text("✔ Confirm",style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold

                                  )),),),
                                    Container(
                                      width: SizeConfig.screenWidth *0.25,


                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary:  pressed,
                                            shape: StadiumBorder()
                                        ),
                                        onPressed: (){
                                          requestStateList.add(
                                            {
                                             'id': snapshot.data![i].requestid,
                                              'state': 'delete'
                                            }

                                          );
                                          setState(() {
                                            checkedList.add(snapshot.data![i].requestid);
                                          });
                                        }, child: const Text("✖ delete",style: TextStyle(
                                        color: primaryColor,
                                          fontWeight: FontWeight.bold
                                      )),),),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )

                  ),
                ),
              ),


                ]);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const  Center(
                      child:  CircularProgressIndicator(),
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
                      child: Text("you Don't have any request"),
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
