import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
        videoPlayerController.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        setState(() {
              videoPlayerController.value.isPlaying
                  ? videoPlayerController.pause()
                  : videoPlayerController.play();
            });
      },
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(color: Colors.black),
        child: VideoPlayer(videoPlayerController),
      ),
    );
  }
}
