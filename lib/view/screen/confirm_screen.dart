import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:zippo/controller/upload_video_controller.dart';
import 'package:zippo/view/screen/widgets/text_input_field.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;

  final String videoPath;
  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            child: VideoPlayer(controller),
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextInputField(
                      controller: songController,
                      keyboardType: TextInputType.text,
                      labelText: 'Song Name',
                      hintText: 'Write Song name',
                      icon: Icons.music_note),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextInputField(
                      controller: captionController,
                      labelText: 'Caption',
                      keyboardType: TextInputType.text,
                      hintText: 'Write Song Caption',
                      icon: Icons.closed_caption),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => uploadVideoController.uploadVideo(
                        songController.text,
                        captionController.text,
                        widget.videoPath),
                    child: Text(
                      'Share!',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
