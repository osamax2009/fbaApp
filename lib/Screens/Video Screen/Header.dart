
import 'package:fba/Screens/Home/HomeSceen.dart';
import 'package:fba/constants.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(onPressed: (){
            _showMyCancelDialog(context);
          }, icon:const Icon(Icons.arrow_back_ios,color: lightGrey  ,)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.01),
            child: const Text("Uploades Videos",
                style: TextStyle(
                    color: lightGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

Future<void> _showMyCancelDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cancel the uploading'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to cancel this uploading?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              MaterialPageRoute goback = MaterialPageRoute(builder: (context)=> HomeScreen());
              Navigator.push(context, goback);
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ],
      );
    },
  );
}


