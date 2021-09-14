import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:frankfurterproject/app/modules/home/home_page.dart';
import 'package:frankfurterproject/core/theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Slidy',
      theme: theme,
      initialRoute: Modular.initialRoute,
      home: HomePage(),
    ).modular();
  }
}
