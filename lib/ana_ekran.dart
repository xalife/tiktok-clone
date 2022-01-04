import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:tiktok/custom_elements/heart_shape.dart';

import 'Elemets/video_post.dart';

class AnaEkran extends StatelessWidget {
  var liste = ["assets/1.mp4", "assets/2.mp4", "assets/3.mp4", "assets/4.mp4"];

  bool isFirstSelected = false;
  bool onPostLiked = false;
  var controller = StreamController<bool>();

  AnaEkran() {
    controller.add(false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: Colors.black,
        ),
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: BottomNavigationBar(
            currentIndex: 2,
            iconSize: 32,
            unselectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
            selectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.home,
                ),
                label: "Ana Sayfa",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.search,
                ),
                label: "Keşfet",
              ),
              BottomNavigationBarItem(
                icon: Image(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/middle_btn.png"),
                  width: 55,
                  height: 35,
                ),
                label: "    ",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.messageSquare,
                ),
                label: "Mesajlar",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  EvaIcons.person,
                ),
                label: "Ben",
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GestureDetector(
              onDoubleTap: () {
                controller.add(true);
                print("double clicked");
                Future.delayed(Duration(milliseconds: 2000)).then((value) => controller.add(false));
              },
              child: Post(liste: liste),
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   isFirstSelected = true;
                      // });
                    },
                    child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      style: isFirstSelected
                          ? TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: "SansPro",
                            )
                          : TextStyle(
                              color: Colors.black,
                              fontFamily: "SansPro",
                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Takip Ediliyor"),
                      ),
                    ),
                  ),
                  Text(
                    "|",
                    style: TextStyle(color: Colors.white60),
                  ),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   isFirstSelected = false;
                      // });
                    },
                    child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      style: (!isFirstSelected)
                          ? TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: "SansPro",
                            )
                          : TextStyle(
                              color: Colors.black,
                              fontFamily: "SansPro",
                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Sizin İçin"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: controller.stream,
              builder: (context, snapshot) {
                print("Data:" + snapshot.data.toString());
                if (snapshot.hasData) {
                  if (snapshot.data) {
                    return HeartShape();
                  } else {
                    return GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    );
                  }
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Post extends StatefulWidget {
  var liste;
  Post({this.liste});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  PreloadPageController _pageController;
  bool isPageStable = false;
  int current = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PreloadPageController();

    _pageController.addListener(scrollListener);
  }

  void scrollListener() {
    if (isPageStable && _pageController.page == _pageController.page.roundToDouble()) {
      setState(() {
        current = _pageController.page.toInt();
        isPageStable = false;
      });
    } else if (!isPageStable && current.toDouble() != _pageController.page) {
      if ((current.toDouble() - _pageController.page).abs() > 0.1) {
        setState(() {
          isPageStable = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PreloadPageView.builder(
      controller: _pageController,
      preloadPagesCount: 3,
      itemCount: widget.liste.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return VideoPost(
          video_uri: widget.liste[index],
          pageIndex: index,
          currentPageIndex: current,
        );
      },
    );
  }
}
