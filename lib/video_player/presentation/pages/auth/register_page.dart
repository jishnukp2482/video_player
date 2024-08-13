import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:videoplayer/video_player/presentation/themes/app_colors.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/custom_text_Filed.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/custome_alert_dialogue.dart';

import '../../manager/controller/auth_cntlr.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final authCntlr = Get.find<AuthCntlr>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(w * 0.02),
        children: [
          SizedBox(
            height: h * 0.3,
          ),
          CustomTextField(
            hintText: "Name",
            label: const Text("Name"),
            controller: authCntlr.nameCntlr,
          ),
          SizedBox(
            height: h * 0.025,
          ),
          CustomTextField(
            hintText: "Email",
            label: const Text("Email"),
            controller: authCntlr.emailCntlr,
          ),
          SizedBox(
            height: h * 0.025,
          ),
          Obx(
            () => CustomTextField(
              hintText: authCntlr.selectedDate.value.isEmpty
                  ? "DOB"
                  : authCntlr.selectedDate.value,
              label: Text(
                authCntlr.selectedDate.value.isEmpty
                    ? "DOB"
                    : authCntlr.selectedDate.value,
              ),
              onTap: () {
                authCntlr.pickDateOfBirth(context);
              },
              // enable: true,
              readOnly: true,
              inputType: TextInputType.none,
            ),
          ),
          SizedBox(
            height: h * 0.025,
          ),
          GestureDetector(
            onTap: () {
              authCntlr.pickImage();
            },
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.black)),
              height: h * 0.18,
              width: w * 0.5,
              child: Obx(() => authCntlr.imageCntlr.value == null
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.browse_gallery_outlined),
                        Text("Please select your Image")
                      ],
                    )
                  : Image.file(authCntlr.imageCntlr.value!, fit: BoxFit.cover)),
            ),
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
                        if (authCntlr.nameCntlr.text.isEmpty ||
                            authCntlr.emailCntlr.text.isEmpty ||
                            authCntlr.imageCntlr.value == null) {
                          customAlertDialogue(
                            title: "Failed",
                            content: "Please Enter All Fields",
                            txtbutton1Action: () {
                              Get.back();
                            },
                            txtbuttonName1: "Try Again",
                          );
                        } else {
                          authCntlr.createAccount(
                              authCntlr.mobileNoCntlr.text,
                              authCntlr.nameCntlr.text,
                              authCntlr.emailCntlr.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appGreen,
                          foregroundColor: AppColors.white),
                      child: const Text("Create"),
                    ),
            ),
          ),
        ],
      ),
    ));
  }
}
