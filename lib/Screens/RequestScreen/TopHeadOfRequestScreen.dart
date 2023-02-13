
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class TopHeadOfRequestScreen extends StatelessWidget {

  const TopHeadOfRequestScreen({
    Key? key,required this.saveFunction
  }) : super(key: key);

  final Function() saveFunction ;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon:const Icon(Icons.arrow_back_ios,color: lightGrey  ,)),
        ),
        Text("Request",
            style: TextStyle(
                color: lightGrey,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        Spacer(),
        Container(
          margin: EdgeInsets.only(right: getProportionateScreenHeight(20) ,top:getProportionateScreenHeight(10)),
          width: SizeConfig.screenWidth * 0.2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: yellow
            ),
            child: Text("Save"),
            onPressed: saveFunction

          ),
        ),

      ],
    );
  }
}
