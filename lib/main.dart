import 'package:flutter/material.dart';
import 'package:progressbar_circular/pages/progressbar_circular.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ProgressBarCircularPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
