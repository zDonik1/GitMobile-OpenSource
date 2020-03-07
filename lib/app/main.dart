import 'package:flutter/material.dart';
import 'package:git_mobile/presentation/constants/app_colors.dart';
import 'package:git_mobile/presentation/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.gitHubBlackColor,
      ),
      home: HomePage(),
    );
  }
}
