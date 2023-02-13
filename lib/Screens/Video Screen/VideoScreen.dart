import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Screens/Home/HomeSceen.dart';
import 'package:fba/Screens/Video%20Screen/videoplayer.dart';
import 'package:fba/utils/SomeFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../Controllers/User.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_sms/flutter_sms.dart';

import '../../CustomBottomNavBar.dart';
import '../../Models/Video.dart';
import '../../enums.dart';
import 'Header.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:intl/intl.dart';

class VideoScreen extends StatefulWidget {
  static String routeName = 'videoscreen';

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  String? _thumbnailFile;

  Uint8List? _thumbnailData;

  @override
  void initState() {
    super.initState();
  }

  Future<File> copyAssetFile(String assetFileName) async {
    Directory tempDir = await getTemporaryDirectory();
    final byteData = await rootBundle.load(assetFileName);

    File videoThumbnailFile = File("${tempDir.path}/$assetFileName")
      ..createSync(recursive: true)
      ..writeAsBytesSync(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return videoThumbnailFile;
  }

  Future generateThumbnail(videoUrl) async {
    String? _thumbnailUrl;
    _thumbnailUrl = await VideoThumbnail.thumbnailFile(
        video: "https://faadminpanel.herokuapp.com/$videoUrl",
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.WEBP);
    setState(() {});
    return _thumbnailUrl;
  }

  SendData sendData = SendData();

  bool isLoading = false;
  List<String> people = [];
  List<int> apppeople = [];
  bool sendDirect = false;

  returnHome(contextx) {
    Navigator.pushNamed(context, HomeScreen.routeName);
  }

  bool isinVitationenable = false;

  List<Contact>? contacts;

  late List<Widget> swtichButtonsList;

  void appuserswitcher() {
    if (isinVitationenable == true) {
      setState(() {
        isinVitationenable = false;
      });
    } else {
      setState(() {
        isinVitationenable = true;
      });
    }
  }

  var appUsers = [];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Consumer<List<dynamic>>(
      builder: (context, List<dynamic> mylist, child) {
        List<Video> downloadedVideos = mylist[3];
        print("the ${downloadedVideos.length}");

        return SafeArea(
          child: Scaffold(
            bottomNavigationBar:
                CustomBottomNavBar(selectedMenu: MenuState.videos),
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: const BoxDecoration(color: primaryColor),
              width: double.infinity,
              child: ListView(
                //  mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Header(),
                  Container(
                    height:
                        SizeConfig.screenHeight - SizeConfig.screenHeight * 0.1,
                    decoration: const BoxDecoration(
                        color: whightbg,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.screenHeight * 0.02,
                          horizontal: SizeConfig.screenHeight * 0.05),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.8,
                            height: SizeConfig.screenHeight * 0.07,
                            child: Stack(
                                children: isinVitationenable
                                    ? [
                                        Positioned(
// top: MediaQuery.of(context).size.height * 0.45,
                                          right:
                                              0, // the position from the right
                                          child: Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            height:
                                                SizeConfig.screenHeight * 0.07,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 70.0, top: 0),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: const Text(
                                                  "downloaded",
                                                  style: TextStyle(
                                                      color: whightbg),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: primaryColor),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
//SizeConfig.screenWidth - SizeConfig.screenWidth * 0.7,
                                          child: Container(
// alignment: Alignment.
                                            width: SizeConfig.screenWidth * 0.5,
                                            height:
                                                SizeConfig.screenHeight * 0.07,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 80, top: 0),
                                              child: TextButton(
                                                onPressed: () {
                                                  appuserswitcher();
                                                },
                                                child: const Text(
                                                  "uploaded",
                                                  style: TextStyle(
                                                      color: primaryColor),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: yellow),
                                          ),
                                        ),
                                      ]
                                    : [
                                        Positioned(
                                          left: 0,
                                          child: Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            height:
                                                SizeConfig.screenHeight * 0.07,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 80, top: 0),
                                              child: TextButton(
                                                child: const Text(
                                                  "uploaded",
                                                  style: TextStyle(
                                                      color: whightbg),
                                                  textAlign: TextAlign.start,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    appuserswitcher();
                                                  });
                                                },
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: primaryColor),
                                          ),
                                        ),
                                        Positioned(
// top: MediaQuery.of(context).size.height * 0.45,
                                          right:
                                              0, // the position from the right
                                          child: Container(
                                            width: SizeConfig.screenWidth * 0.5,
                                            height:
                                                SizeConfig.screenHeight * 0.07,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 40, top: 0),
                                              child: TextButton(
                                                onPressed: () {
                                                  appuserswitcher();
                                                },
                                                child: const Text(
                                                  "downloaded",
                                                  style: TextStyle(
                                                      color: primaryColor),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: yellow),
                                          ),
                                        ),
                                      ]),
                          ),

                          /// this section is for the listview
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.3,
                                top: SizeConfig.screenHeight * 0.01,
                                bottom: SizeConfig.screenHeight * 0.01),
                            child: const Text(
                              "Click here to Upload New video",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          isinVitationenable
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: SizedBox(
                                    //  margin: EdgeInsets.symmetric(vertical:SizeConfig.screenHeight * 0.02 ),
                                    height: SizeConfig.screenHeight * 0.6,
                                    child: GridView.builder(
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10,
                                          crossAxisCount: 2,
                                          childAspectRatio: 3/2,
                                          crossAxisSpacing: 10
                                        ),
                                        itemCount: downloadedVideos.length,
                                        itemBuilder: (cx, i) =>
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoApp(videoUrl: downloadedVideos[i].video!,)
                                                  )
                                                );
                                              },
                                              child: Column(
                                                children: [
                                              Image.asset(
                                              "assets/img/VideosThumb.png",
                                              fit: BoxFit.fill),
                                                  Text(
                                                     getTheDate(downloadedVideos[i].createdAt!)
                                                  ),
                                                ],
                                              ),
                                            )

                                    ),
                                  ),
                                )
                              : Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: SizedBox(
                              //  margin: EdgeInsets.symmetric(vertical:SizeConfig.screenHeight * 0.02 ),
                              height: SizeConfig.screenHeight * 0.6,
                              child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2,
                                      childAspectRatio: 3/2,
                                      crossAxisSpacing: 10
                                  ),
                                  itemCount: downloadedVideos.length,
                                  itemBuilder: (cx, i) =>
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoApp(videoUrl: downloadedVideos[i].video!,)
                                          )
                                          );
                                        },
                                        child: Container(
                                          height: SizeConfig.screenHeight * 0.13,
                                          width: SizeConfig.screenWidth * 0.3,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: SizeConfig.screenHeight * 0.1,
                                                width: SizeConfig.screenWidth * 0.3,
                                                child: Image.asset(
                                                    "assets/img/VideosThumb.png",
                                                    fit: BoxFit.fill),
                                              ),
                                              Text(
                                                  getTheDate(downloadedVideos[i].createdAt!)
                                              ),
                                            ],
                                          ),
                                        ),
                                      )

                              ),
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//
// FutureBuilder<dynamic>(
// future: generateThumbnail(
// downloadedVideos[i]
// .video), // a previously-obtained Future<String> or null
// builder: (BuildContext context,
//     AsyncSnapshot<dynamic>
// snapshot) {
// if (snapshot.hasData) {
// return GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// VideoApp()));
// },
// child: Container(
// width: double.infinity,
// height: SizeConfig
//     .screenHeight *
// 0.2,
// decoration: BoxDecoration(
// border: Border.all(
// color:
// Colors.black),
// borderRadius:
// BorderRadius
//     .circular(10),
// ),
// child: Row(
// children: [
// Container(
// child: Image.file(
// File(snapshot
//     .data),
// fit: BoxFit.fill,
// ),
// width: SizeConfig
//     .screenWidth *
// 0.4,
// color:
// Colors.yellow,
// margin:
// EdgeInsets.all(
// 10),
// ),
// Expanded(
// child: Container(
// margin: EdgeInsets
//     .all(10),
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment
//     .center,
// children: [
// Text(
// (downloadedVideos[
// i]
//     .description!),
// style: TextStyle(
// fontSize:
// 12),
// maxLines: 3,
// ),
// Text(
// "Uploaded ${downloadedVideos[i].createdAt!} ",
// style: TextStyle(
// fontSize:
// 12,
// color:
// darkGrey),
// ),
// ],
// ),
// ),
// )
// ],
// ),
// ),
// );
// } else if (snapshot.hasError) {
// return const Icon(
// Icons.error_outline,
// color: Colors.red,
// size: 60,
// );
// } else {
// return Image.asset(
// "assets/img/VideosThumb.png",
// fit: BoxFit.fill);
// }
// },
// )
