
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ButtonForSettings extends StatelessWidget {
  const ButtonForSettings({
    Key? key,
   required this.press,
   required this.text,
   required this.image,
  }) : super(key: key);

  final String image ;
  final String  text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          press,
      child: Container(

        width: double.infinity,
        height: SizeConfig.screenHeight * 0.07,

        padding: EdgeInsets.all(14),
        
        decoration: BoxDecoration(
            color:
            lightGrey,
            border: Border.all(
              width: 1,
              color:  darkGrey,
            ),
            borderRadius: BorderRadius.circular(20)
        ),
        margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25),vertical: getProportionateScreenHeight(10) ),
        child:
        Row(
          children: [
            SizedBox(

                child: Image.asset(image),
                height: getProportionateScreenHeight(20)
            ),
            SizedBox(
              width: 10,
            ),
            Text(text,
              style: const   TextStyle(
                  color: Color(0xFF76767F),
                  fontSize: 13,
                  fontWeight: FontWeight.bold),

            ),
          ],
        ),
      ),
    );
  }
}