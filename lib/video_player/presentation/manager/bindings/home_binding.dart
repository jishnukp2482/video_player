import 'package:get/get.dart';
import 'package:videoplayer/video_player/presentation/manager/controller/home_cntlr.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeCnltr());
  }
}
