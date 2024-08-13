import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/video_player/presentation/manager/bindings/auth_binding.dart';
import 'package:videoplayer/video_player/presentation/manager/bindings/home_binding.dart';
import 'package:videoplayer/video_player/presentation/pages/dashboard/dashboard.dart';
import 'package:videoplayer/video_player/presentation/pages/auth/login.dart';
import 'package:videoplayer/video_player/presentation/pages/auth/register_page.dart';
import 'package:videoplayer/video_player/presentation/pages/dashboard/video_player.dart';
import 'package:videoplayer/video_player/presentation/pages/profile/profile.dart';
import 'package:videoplayer/video_player/presentation/pages/splash.dart';

import 'app_pages.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(name: AppPages.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppPages.loginPage, page: () => LoginPage(),binding: AuthBinding()),
    GetPage(name: AppPages.registerPage, page: () => Register(),binding: AuthBinding()),
    GetPage(name: AppPages.dashboardPage, page: () => DashBoard(),binding: HomeBinding()),
    GetPage(name: AppPages.profilePage, page: () => Profile(),binding: HomeBinding()),
    GetPage(name: AppPages.videoplayPage, page: () => VideoPlayerPage(),binding: HomeBinding()),
  ];
}
