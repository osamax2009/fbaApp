import 'dart:io';

import 'package:fba/Controllers/SendData.dart';
import 'package:fba/constants.dart';
import 'package:fba/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../Wrapper.dart';
import '../Video Screen/Header.dart';
import 'CupUploadVideoScreen.dart';

class VideoPage extends StatefulWidget {
  final String filePath;

  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();

    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play() ;
  }
  var height;
bool _isloading = false ;
  @override
  Widget build(BuildContext context) {

     height = SizeConfig.screenHeight ;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        leading:const Text(""),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              _videoPlayerController.pause();

              final route = MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => CupUploadVideoScreen(filePath: widget.filePath),
              );
              Navigator.push(context, route);
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body:  FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }





}

