import 'package:get/get.dart';
import 'package:videoplayer/video_player/presentation/manager/controller/auth_cntlr.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthCntlr(),
    );
  }
}
