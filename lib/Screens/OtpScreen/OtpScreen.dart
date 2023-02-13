import 'dart:async';
import 'dart:math';

import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Models/OtpModel.dart';
import 'package:fba/Screens/RegisterScreen/RegisterScreen.dart';
import 'package:fba/Screens/SignUpScreen/SignUpScreen.dart';
import 'package:fba/Wrapper.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextStyle GoBackStyle = TextStyle(fontSize: 10);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';

  int? otp;
  int count = 0;

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  final TextEditingController _controllerone = TextEditingController();
  final TextEditingController _controllerTwo = TextEditingController();
  final TextEditingController _controllerthree = TextEditingController();
  final TextEditingController _controllerfour = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }
  var phonenumber ;
  bool isnocode = false ;
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    final otpmodel  = ModalRoute.of(context)!.settings.arguments as OtpModel;
    phonenumber = otpmodel.phone;

    print(phonenumber);

    return Scaffold(
        resizeToAvoidBottomInset: false ,
        body: Container(
      decoration: const BoxDecoration(color: primaryColor),
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.1),
              child: Text("One Time Password",
                  style: TextStyle(
                      color: lightGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(SizeConfig.screenHeight * 0.05),
          child: const Image(
            image: AssetImage("assets/img/Logo.png"),
          ),
        ),
        isLoading? CircularProgressIndicator(): Container(
          height: SizeConfig.screenHeight * 0.55,
          decoration: const BoxDecoration(
              color: whightbg,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
          child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.screenHeight * 0.02,
                    horizontal: SizeConfig.screenHeight * 0.05),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("${phonenumber} is not your number ",style: GoBackStyle,),
                        TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Go Back",style: GoBackStyle,))
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(60),
                          child: TextFormField(
                            obscureText: true,
                            controller: _controllerone,
                            autofocus: true,
                            style: TextStyle(fontSize: 24),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: otpInputDecoration,
                            onChanged: (value) {
                              nextField(value, pin2FocusNode);
                            },
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(60),
                          child: TextFormField(
                            obscureText: true,
                            controller: _controllerTwo,
                            focusNode: pin2FocusNode,
                            style: TextStyle(fontSize: 24),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: otpInputDecoration,
                            onChanged: (value) =>
                                nextField(value, pin3FocusNode),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(60),
                          child: TextFormField(
                            obscureText: true,
                            controller: _controllerthree,
                            focusNode: pin3FocusNode,
                            style: TextStyle(fontSize: 24),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: otpInputDecoration,
                            onChanged: (value) =>
                                nextField(value, pin4FocusNode),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(60),
                          child: TextFormField(
                            obscureText: true,
                            controller: _controllerfour,
                            focusNode: pin4FocusNode,
                            style: TextStyle(fontSize: 24),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: otpInputDecoration,
                            onChanged: (value) {
                              if (value.length == 1) {
                                pin4FocusNode!.unfocus();
                                // Then you need to check is the code is correct or not
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight* 0.03),
                    ),
                    Row(
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.5,
                          height: SizeConfig.screenHeight * 0.07,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: yellow, shape: StadiumBorder()),
                            onPressed: () {
                              SendData sendData = SendData();
                              print(_controllerone.text+_controllerTwo.text+_controllerthree.text+_controllerfour.text);
                              if (otpmodel.code == (_controllerone.text+_controllerTwo.text+_controllerthree.text+_controllerfour.text) || otp.toString() == (_controllerone.text+_controllerTwo.text+_controllerthree.text+_controllerfour.text) ){

                                sendData.showAlert('process Successful ', context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  RegisterScreen(),
                                      settings: RouteSettings(
                                        arguments: otpmodel.phone
                                      )
                                    )
                                );
                              }else{

                                sendData.showAlert('process Error   ', context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  SignUpScreen(),

                                    )
                                );
                              }

                            },
                            child: const Text("Done",
                                style: TextStyle(
                                  color: primaryColor,
                                )),
                          ),
                        ),
                      isnocode? TextButton(onPressed: (){

                          setState(() {
                            isLoading = true;
                          });
                          var rng = new Random();
                          var code = rng.nextInt(9000) + 1000;
                          otp = code ;
                          SendData sendData = SendData();
                          sendData.sendOtp(code.toString(),phonenumber ).then((value) {
                            if (value == 'success'){
                              setState(() {
                                isLoading = false ;
                              });

                            }else {
                              sendData.showAlert("check your network", context);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });

                          setState(() => myDuration = Duration(minutes: 1));
                          startTimer();
                          setState(() {
                            isnocode = false ;
                          });





                      }, child: Text("send code")):  Padding(
                          padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(15)),
                          child: Text(
                            '$minutes:$seconds',
                            style:const TextStyle(
                                color: darkGrey,
                                fontSize: 16),
                          ),
                        ),

                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
                      child: const Text(
                        "You can get another code \n after one minute.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 16),
                      ),

                    ),
                  ],
                ),
              )),
        )
      ]),
    ));
  }
  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 1);


  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();


  }
  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        setState(() {
          isnocode = true;
        });

      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  bool isLoading = false ;
}




