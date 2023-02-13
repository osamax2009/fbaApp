import 'dart:developer';
import 'dart:math';

import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Models/OtpModel.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../OtpScreen/OtpScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  String  phone_c ="none";
  bool isLoading = false ;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // resizeToAvoidBottomInset: false ,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.05),
          decoration: const BoxDecoration(color: primaryColor),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric( horizontal: SizeConfig.screenWidth * 0.1),
                    child: Text("Sign Up",
                        style: TextStyle(
                            color: lightGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(SizeConfig.screenHeight * 0.05),
                child: const Image(
                  image: AssetImage("assets/img/Logo.png"),
                ),
              ),
              Container(
                height: SizeConfig.screenHeight * 0.55,
                decoration: const BoxDecoration(
                    color: whightbg,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
                child: Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.02, horizontal: SizeConfig.screenHeight * 0.05),
                    child: Column(children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:SizeConfig.screenHeight * 0.01 ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Phone Number",style: TextStyle(
                              color: darkGrey,
                            )),
                          ],
                        ),
                      ),
                      (isLoading  )? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ) : IntlPhoneField(

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: lightGrey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color:  darkGrey
                            ),
                          ),
                        ),
                        onChanged: (phone) {
                          phone_c = phone.completeNumber;
                          print(phone.completeNumber);
                        },
                        onCountryChanged: (country) {
                          print('Country changed to: ' + country.name);
                        },
                      ),

                      Container(
                        width: SizeConfig.screenWidth *0.5,
                        height: SizeConfig.screenHeight *0.07,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary:  pressed,
                              shape: StadiumBorder()
                          ),
                          onPressed: (){
                            setState(() {
                              isLoading = true;
                            });
                            var rng = new Random();
                            var code = rng.nextInt(9000) + 1000;
                            SendData sendData = SendData();
                            sendData.sendOtp(code.toString(), phone_c ).then((value) {
                              print("the otp am in screen .......$value");
                              if (value == 'success'){
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const OtpScreen(), settings: RouteSettings(
                                  arguments: OtpModel(
                                    phone: phone_c,
                                    code: code.toString()
                                  ),
                                ),));

                              }else if (value == 'failed')  {
                                // sendData.showAlert("check your network", context);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Network Error Try Again later !!"),
                                      backgroundColor: Color(0xffffd77973ff),
                                )
                                  );
                                setState(() {
                                  isLoading = false;
                                });
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(content: Text(value),
                                      backgroundColor: pressed,
                                    )
                                );
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            });
                          }, child: const Text("Send OTP",style: TextStyle(
                          color: primaryColor,

                        )),),
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
  }
}
