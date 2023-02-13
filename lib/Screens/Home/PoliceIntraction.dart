
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants.dart';
import '../../size_config.dart';
import '../LiveShare/CallPage.dart';

class PolicIntractionButton extends StatelessWidget {
   PolicIntractionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       onJoin(context, "testing");
      },
      child: Container(
        decoration:  BoxDecoration(
            color: yellow,
            borderRadius: BorderRadius.circular(30)
        ),
        width: SizeConfig.screenWidth * 0.8,
        height: SizeConfig.screenHeight * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // IconButton(onPressed: (){
            //   Navigator.pop(context);
            // }, icon:const Icon(Icons.arrow_back_ios,color: lightGrey  ,)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.04),
              child: const Text("Police \n Interaction Alert",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)
              ,),
            ),
           const  Padding(
              padding: EdgeInsets.all(10),
              child: Image(
                  image:
                  AssetImage("assets/img/police.png")
              ),
            )
          ],
        ),
      ),
    );
  }

  ClientRole _role = ClientRole.Broadcaster;
  Future<void> onJoin(context , _channel) async {
    // update input validation


      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channel,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

