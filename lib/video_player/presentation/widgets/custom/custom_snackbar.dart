import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:videoplayer/video_player/presentation/themes/app_colors.dart';

void bottomMsg(String title, String msg, bool field) {
  Get.snackbar(
    '',
    '',
    messageText: Text(
      msg,
      style: TextStyle(
          color: field == true ? AppColors.black : AppColors.white,
          fontSize: 16),
      textAlign: TextAlign.center,
    ),
    titleText: Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          color: field == true ? AppColors.black : AppColors.white,
          fontSize: 18),
      textAlign: TextAlign.center,
    ),
    backgroundColor: field == false
        ? AppColors.red
        : AppColors.white, // Apply background color based on the field value
    progressIndicatorBackgroundColor: AppColors.green,
    colorText: field == false ? AppColors.black : AppColors.red,
    animationDuration: const Duration(milliseconds: 1000),
    snackPosition: SnackPosition.TOP,
    dismissDirection: null,
    icon: field == false
        ? const Icon(
            Icons.error_outline,
            color: AppColors.white,
          )
        : const Icon(Icons.done),
    backgroundGradient: null,
    barBlur: field == false ? 2 : 0, // Apply blur only if field is false
    forwardAnimationCurve: Curves.easeInOut,
    instantInit: true,
    userInputForm: null,
    snackStyle: SnackStyle.FLOATING,
    snackbarStatus: null,
    showProgressIndicator: false,
    shouldIconPulse: true,
    reverseAnimationCurve: Curves.easeIn,
    overlayColor: AppColors.transparent,
    progressIndicatorController: null,
    progressIndicatorValueColor: null,
    leftBarIndicatorColor: null,
    overlayBlur:
        field == false ? 3 : 0, // Apply overlay blur only if field is false
    duration: const Duration(seconds: 3),
  );
}
