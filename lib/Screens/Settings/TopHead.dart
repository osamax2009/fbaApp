
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class TopHead extends StatelessWidget {

  const TopHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
          )
      ),
      width: double.infinity,
      height: SizeConfig.screenHeight * 0.15,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // IconButton(onPressed: (){
          //   Navigator.pop(context);
          // }, icon:const Icon(Icons.arrow_back_ios,color: lightGrey  ,)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.04, vertical:SizeConfig.screenWidth * 0.04 ),
            child: const Text("Settings",
                style: TextStyle(
                    color: lightGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundImage: Image.asset("assets/img/Oval.png").image,
              maxRadius: 30,
            ),
          )
        ],
      ),
    );
  }
}
