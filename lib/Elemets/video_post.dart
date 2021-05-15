import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  String video_uri;
  final int pageIndex;
  final int currentPageIndex;
  VideoPost({this.video_uri, this.pageIndex, this.currentPageIndex});
  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  VideoPlayerController _playerController;
  bool initialized = false;
  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.asset(widget.video_uri)
      ..initialize().then((value) {
        setState(() {
          _playerController.setLooping(true);
          initialized = true;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized && widget.currentPageIndex == widget.pageIndex) {
      _playerController.seekTo(Duration(milliseconds: 0));
      _playerController.play();
    } else {
      _playerController.pause();
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: VideoPlayer(_playerController),
      ),
    );
  }
}
