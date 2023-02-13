import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Screens/SignUpScreen/SignUpScreen.dart';
import 'package:fba/Wrapper.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false ;
  var phone ;
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false ,
        body: isLoading ? const Center(
            child: CircularProgressIndicator()
        ): Container(
          decoration: const BoxDecoration(color: primaryColor),
          width: double.infinity,
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Sign In",
                      style: TextStyle(
                          color: lightGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                      textAlign: TextAlign.center,
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

                     IntlPhoneField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightGrey,
                      hintStyle:const TextStyle(
                        color: primaryColor,
                      ) ,
                      hintText: "Phone Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: lightGrey
                        ),
                      ),
                    ),
                    onChanged: (phonex) {
                      phone = phonex.completeNumber;
                      print(phonex.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                  ),

                      TextField(
                        controller: password,
                              obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              hintStyle:const TextStyle(
                                color: primaryColor,
                              ) ,
                              contentPadding: EdgeInsets.symmetric(horizontal:SizeConfig.screenHeight * 0.02 ),
                              filled: true,
                              fillColor: lightGrey,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
                                  borderSide:const BorderSide(
                                      color: darkGrey
                                  ),
                            ),

                      ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical:SizeConfig.screenWidth * 0.01 ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Spacer(),
                            Text("Forget Password",style: TextStyle(
                              color: darkGrey,
                            )),
                          ],
                        ),
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
                            SendData sendData = SendData();
                            print(password.text);
                            if (phone.length >= 10 && password.text.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                                var data = {
                                  "phone":phone ,
                                  "password":password.text
                                };

                                sendData.login(data).then((value) {
                                  if(value !="failed"){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Wrapper()));
                                    }else{
                                    sendData.showAlert("something wrong with your data", context);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                   }
                                );
                            }else {
                              sendData.showAlert("something wrong with your data", context);

                            }
                          }, child: const Text("Sign In",style: TextStyle(
                          color: primaryColor,

                        )),),
                      ),
                      Padding(padding:  EdgeInsets.symmetric(vertical:SizeConfig.screenWidth * 0.02 ),),
                      Container(
                        width: SizeConfig.screenWidth *0.5,
                        height: SizeConfig.screenHeight *0.07,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary:  pressed,
                              shape: StadiumBorder()
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                          }, child: const Text("Sign Up",style: TextStyle(
                          color: primaryColor,

                        )),),
                      )


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
