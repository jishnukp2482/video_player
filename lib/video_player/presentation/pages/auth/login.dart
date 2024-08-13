import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:videoplayer/video_player/presentation/manager/controller/auth_cntlr.dart';
import 'package:videoplayer/video_player/presentation/themes/app_colors.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/custom_text_Filed.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/custome_alert_dialogue.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final authCntlr = Get.find<AuthCntlr>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: ListView(
        padding: EdgeInsets.all(w * 0.025),
        children: [
          SizedBox(
            height: h * 0.3,
          ),
          CustomTextField(
            hintText: "Mobile No",
            label: const Text("Mobile No"),
            inputType: TextInputType.number,
            controller: authCntlr.mobileNoCntlr,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    authCntlr.sentOtp(authCntlr.mobileNoCntlr.text);
                  },
                  child: const Text("Get OTP"))),
          CustomTextField(
            hintText: "OTP",
            label: const Text("OTP"),
            controller: authCntlr.oTPcntlr,
          ),
          SizedBox(
            height: h * 0.025,
          ),
          SizedBox(
            height: 45,
            width: w,
            child: Obx(
              () => authCntlr.isVerifyOtpisLoading.value
                  ? const SizedBox(
                      height: 40,
                      width: 20,
                      child: Center(child: CircularProgressIndicator()))
                  : ElevatedButton(
                      onPressed: () {
                        if (authCntlr.mobileNoCntlr.text.isEmpty &&
                            authCntlr.oTPcntlr.text.isEmpty) {
                          customAlertDialogue(
                            title: "Failed",
                            content: "Please Enter MobileNO and OTP",
                            txtbutton1Action: () {
                              Get.back();
                            },
                            txtbuttonName1: "Try Again",
                          );
                        } else if (authCntlr.oTPcntlr.text.isEmpty) {
                          customAlertDialogue(
                            title: "Failed",
                            content: "Please Enter OTP",
                            txtbutton1Action: () {
                              Get.back();
                            },
                            txtbuttonName1: "Try Again",
                          );
                        } else if (authCntlr.oTPcntlr.text.isEmpty) {
                          customAlertDialogue(
                            title: "Failed",
                            content: "Please Enter MObileNO",
                            txtbutton1Action: () {
                              Get.back();
                            },
                            txtbuttonName1: "Try Again",
                          );
                        } else {
                          authCntlr.verifyOTP(authCntlr.oTPcntlr.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appGreen,
                          foregroundColor: AppColors.white),
                      child: const Text("Login"),
                    ),
            ),
          ),
        ],
      ),
    ));
  }
}
