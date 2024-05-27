import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset("assets/videos/video_teste.mp4");
    await _controller.initialize();
    setState(() {
      _isVideoInitialized = true;
    });

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        backgroundColor: Colors.white,
        playedColor: Theme.of(context).primaryColor
      )
    );  
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: 380,
        height: 200,
        child: _isVideoInitialized
            ? AspectRatio(
                aspectRatio: 21 / 9, // Defina a proporção desejada
                child: Chewie(
                  controller: _chewieController,
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
