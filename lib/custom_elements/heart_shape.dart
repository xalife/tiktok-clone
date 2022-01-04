import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HeartShape extends StatefulWidget {
  @override
  _HeartShapeState createState() => _HeartShapeState();
}

class _HeartShapeState extends State<HeartShape> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Transform.scale(
          scale: 0.7,
          child: RiveAnimation.asset(
            "assets/heart_icon.riv",
          ),
        ),
      ),
    );
  }
}

class Mavi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
