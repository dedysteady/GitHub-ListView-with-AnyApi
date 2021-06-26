import 'package:flutter/material.dart';
import 'package:github_finder/pages/index.dart';
import 'package:github_finder/theme/colors.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: primary
    ),
    home: IndexPage(),
  ));
}