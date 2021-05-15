import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'Elemets/video_post.dart';

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  var liste = ["assets/1.mp4", "assets/2.mp4", "assets/3.mp4", "assets/4.mp4"];
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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: PreloadPageView.builder(
          controller: _pageController,
          preloadPagesCount: 3,
          itemCount: liste.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return VideoPost(
              video_uri: liste[index],
              pageIndex: index,
              currentPageIndex: current,
            );
          },
        ),
      ),
    );
  }
}
