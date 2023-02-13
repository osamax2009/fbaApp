import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '/Controllers/SendData.dart';
import '/constants.dart';
import '/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../Wrapper.dart';
import '../Video Screen/Header.dart';
import 'CupForm.dart';
import 'videoprivew.dart';

class CupUploadVideoScreen extends StatefulWidget {
  final String filePath;

  const CupUploadVideoScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  _CupUploadVideoScreenState createState() => _CupUploadVideoScreenState();
}

class _CupUploadVideoScreenState extends State<CupUploadVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  bool videostate = false ;

  final _key = GlobalKey();

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await  _videoPlayerController.pause() ;
  }
  var height;
  bool _isloading = false ;
  @override
  Widget build(BuildContext context) {

    height = SizeConfig.screenHeight ;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Preview'),
      //   leading:const Text(""),
      //   elevation: 0,
      //   backgroundColor: Colors.black26,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.check),
      //       onPressed: () {
      //        setState(() {
      //             _videoPlayerController.pause();
      //          returnbottomsheet(context);
      //
      //        });
      //       },
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.cancel),
      //       onPressed: () {
      //         setState(() {
      //           _videoPlayerController.pause();
      //           dispose();
      //
      //
      //         });
      //       },
      //     )
      //   ],
      // ),
      // extendBodyBehindAppBar: true,
      body: _isloading ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text("video uploading...pls wait",
                style: TextStyle(
                    color: primaryColor
                ),
              )
            ],
          )


      ): FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {

            return

              Container(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.01),
                decoration: const BoxDecoration(color: primaryColor),
                width: double.infinity,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Header(),
                    Container(
                        margin: EdgeInsets.all(15),


                        height: SizeConfig.screenHeight * 0.25,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: VideoPlayer(_videoPlayerController)
                            ),
                            Positioned(
                                top: SizeConfig.screenHeight * 0.16 / 2,
                                right: SizeConfig.screenWidth *0.4,
                                child:GestureDetector(
                                    onTap: (){
                                      final route = MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (_) => VideoPage(filePath: widget.filePath),
                                      );
                                      Navigator.push(context, route);
                                    },
                                    child:
                                    Icon(Icons.play_circle_fill,
                                      size: SizeConfig.screenHeight * 0.1,
                                      color: whightbg,
                                    )
                                )
                            ),

                          ],
                        )
                    ),
                    CupForm(
                      press: (){
                        returnbottomsheet(context);
                      },
                    ),
                  ],
                ),
              );


            //VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }



  returnbottomsheet(contextxx){

    _controller.text = DateTime.now().toIso8601String();
    _controller2.text = "this video will upload by you for emergency cases.......";
    showModalBottomSheet<void>(
        context: contextxx,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(15),
            height: height * 0.4,
            color: whightbg,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Video Title"),
                    ],
                  ),
                  TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Video Title',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Video Description"),
                    ],
                  ),
                  TextFormField(
                    controller: _controller2,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'description',
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
                       // Navigator.pop(contextxx);
                        sendRequestUpdate(context);



                      }, child: const Text("Upload Video",style: TextStyle(
                      color: primaryColor,

                    )),),
                  )

                ],
              ),
            ),
          );
        }
    );
  }


  sendRequestUpdate(context) async {
    var data ={
      'title': _controller.text,
      'description':_controller2.text,
      'video':widget.filePath
    };
    SendData sendData = SendData();
    setState(() {
      _isloading = true;
    });
    bool state = false  ;
    await  sendData.UploadVideo(
        data
    ).then((value) =>
    state= value
    );
    if (state){
      setState(() {
        _isloading = false;
      });
      dispose();
      // sendData.showAlert("data saved successfully", context);
      Navigator.push(context,
          MaterialPageRoute(builder:(context)=> Wrapper())
      );

    }else {
      setState(() {
        _isloading = false;
      });
      //  sendData.showAlert("nothing happened !!", contextx);


    }
  }


}



