import 'package:flutter/material.dart';
import 'package:gallery_task/const/colors.dart';
import 'package:gallery_task/view/home_screen.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: Appcolor.whiteColor,
        appBarTheme: const AppBarTheme(
          color: Appcolor.whiteColor,
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
