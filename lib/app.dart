import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoplayer/video_player/presentation/routes/app_pages.dart';
import 'package:videoplayer/video_player/presentation/routes/app_routes.dart';
import 'package:videoplayer/video_player/presentation/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.loginPage,
      getPages: AppRoutes.routes,
    );
  }
}
