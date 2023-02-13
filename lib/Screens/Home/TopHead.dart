
import 'package:fba/Screens/RegisterScreen/RegisterScreen.dart';
import 'package:flutter/material.dart';

import '../../Controllers/local_notice_service.dart';
import '../../constants.dart';
import '../../size_config.dart';

class TopHead extends StatelessWidget {
  const TopHead({
   required this.image,
    Key? key,
  }) : super(key: key);

  final String image;

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
            child: TextButton(
              onPressed: ()=>LocalNoticeService().addNotification(
              'Work Complete',
              "Let's take some rest",
              5,
              sound: 'workend.mp3',
              channel: 'work-end',
            ),
              child: const Text("Home",
                  style: TextStyle(
                      color: lightGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: Image.network(image).image,
                maxRadius: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
