import 'package:flutter/material.dart';

import 'ana_ekran.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnaEkran(),
    );
  }
}
