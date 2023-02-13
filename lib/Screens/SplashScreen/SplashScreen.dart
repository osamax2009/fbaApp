import 'package:fba/constants.dart';
import 'package:fba/size_config.dart';
import 'package:flutter/material.dart';

import '../SignInScreen/SignInScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
      print('One second has passed.'); // Prints after 1 second.
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: const BoxDecoration(color: primaryColor),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            //padding: EdgeInsets.all(SizeConfig.screenHeight * 0.1),
            child: Image(
              image: AssetImage("assets/img/Logo.png" ),
            ),
            height:getProportionateScreenHeight(650),
          ),
         // Spacer(),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
