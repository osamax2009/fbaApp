import 'package:fba/Screens/RegisterScreen/RegisterScreen.dart';
import 'package:fba/size_config.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF161d6f);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const yellow = Color(0xFFFFC150);
const lightGrey = Color(0xFFF3F4F8);
const darkGrey = Color(0xFFC1C1C9);
const pressed = Color(0xffFFD900);
const whightbg = Color(0xffFEFEFE);
const defaultPadding = 16.0;
final otpInputDecoration = InputDecoration(
  filled: true,
  fillColor: lightGrey,
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);


OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide:const BorderSide(
      color: darkGrey
    ),
  );
}

Center loadingInterface(BuildContext context) {
  return Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const CircularProgressIndicator(),
      TextButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>const RegisterScreen()  ) );}, child: Text("Go Back"))
    ],
  ),);
}
