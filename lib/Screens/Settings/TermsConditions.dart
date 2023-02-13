import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Screens/SignUpScreen/SignUpScreen.dart';
import 'package:fba/Wrapper.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TermsConditions  extends StatelessWidget {
static  String routeName = 'TermsConditions';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: primaryColor),
        width: double.infinity,
        child: Column(
           mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin:  EdgeInsets.only(top:  getProportionateScreenHeight(50), bottom: getProportionateScreenHeight(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon:const Icon(Icons.arrow_back_ios,color: lightGrey  ,)),
                  Text("Terms & Conditions",
                      style: TextStyle(
                          color: lightGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              ),
            ),



            BigWhigetBox()

          ],
        ),
      )
    );
  }
}

class BigWhigetBox extends StatelessWidget {
  const BigWhigetBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: SizeConfig.screenHeight * 0.83,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only( topLeft:  Radius.circular(40),topRight:  Radius.circular(40)),
        color: whightbg
      ),
      child: Column(

        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(20), horizontal: getProportionateScreenHeight(13)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Privacy Policy" ,
                style: TextStyle(
                  fontSize: 18
                ),


                  ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Text("It is a long established fact that a reader will be distracted y the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed tousing 'Content here, content here, making it looklike readable English. Many desktop publishingpackages and web page editors now use LoremIpsum as their default model text, and a searchfor lorem ipsum' will uncover many web sites still  in their infancy. Various versions have evolved over the years, sometimes by accident,sometimes on purpose (iniected humour andthe like)",
                  style: TextStyle(
                     color: darkGrey
                  ),
                  ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Text("It is a long established fact that a reader will be distracted y the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed tousing 'Content here, content here, making it looklike readable English. Many desktop publishingpackages and web page editors now use LoremIpsum as their default model text, and a searchfor lorem ipsum' will uncover many web sites still  in their infancy. Various versions have evolved over the years, sometimes by accident,sometimes on purpose (iniected humour andthe like)",
                  style: TextStyle(
                      color: darkGrey
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth *0.5,
                      height: SizeConfig.screenHeight *0.07,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:  yellow,
                            shape: StadiumBorder()
                        ),
                        onPressed: (){
                         Navigator.pop(context);
                        }, child: const Text("Okay",style: TextStyle(
                        color: primaryColor,

                      )),),
                    ),
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
