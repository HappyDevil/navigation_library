import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Map<String, IconData> map123 = <String, IconData>{
  '123': Icons.build
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var codePoint = i();
    return Container(
      child: Icon(IconData(codePoint, fontFamily: 'MaterialIcons')),
    );
  }

  int i() => 0xe0ae;
}

