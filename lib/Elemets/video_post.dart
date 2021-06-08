import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: VideoPlayer(_playerController),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: constraints.maxHeight * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 48,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage("assets/avatar.jpg"),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(0.0, 1.5),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          EvaIcons.plus,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Icon(
                                  EvaIcons.heart,
                                  size: 48,
                                  color: Colors.white,
                                ),
                                Text(
                                  "25.4K",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  EvaIcons.messageCircleOutline,
                                  size: 48,
                                  color: Colors.white,
                                ),
                                Text(
                                  "876",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Transform(
                                  transform: Matrix4.rotationY(pi),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    EvaIcons.undo,
                                    size: 48,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "123",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: constraints.maxHeight * 0.3,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "@ Kayra seni seviyorm",
                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "mükemmel woodwork çalışması 2021 çok iyi geçsin vs vs .. #woodwork #handcraft",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.music_note_sharp,
                                        color: Colors.white70,
                                      ),
                                      Text(
                                        "Louis Armstrong - What a ...",
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.23,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
