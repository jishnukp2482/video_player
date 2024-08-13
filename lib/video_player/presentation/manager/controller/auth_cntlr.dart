import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:videoplayer/video_player/presentation/routes/LocalStorageNames.dart';
import 'package:videoplayer/video_player/presentation/routes/app_pages.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/customPrint.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/custom_snackbar.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/custome_alert_dialogue.dart';

class AuthCntlr extends GetxController {
  final mobileNoCntlr = TextEditingController();
  final oTPcntlr = TextEditingController();
  final box = GetStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  final verificationId = ''.obs;
  final isOtpSent = false.obs;

  storePhNo(String phNO) {
    print("phoneNo=$phNO");
    box.write(LocalStorageNames.phoneNO, phNO);
  }

  void sentOtp(String phoneNO) async {
    storePhNo(phoneNO);
    try {
      isOtpSent.value = true;
      await auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNO",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credentails) async {
          await auth.signInWithCredential(credentails);
        },
        verificationFailed: (FirebaseAuthException e) {
          customAlertDialogue(
            title: "Failed",
            content: e.message!,
            txtbutton1Action: () {
              Get.back();
            },
            txtbuttonName1: "Try agin",
          );
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;

          bottomMsg("Success",
              "OTP Sent Please enter the OTP sent to your mobile", true);
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
      isOtpSent.value = false;
    } catch (e) {
      customPrint("otp send failed==$e");
      customAlertDialogue(
        title: "Failed",
        content: e.toString(),
        txtbutton1Action: () {
          Get.back();
        },
        txtbuttonName1: "Try agin",
      );
      isOtpSent.value = false;
    }
  }

  final isVerifyOtpisLoading = false.obs;
  void verifyOTP(String otp) async {
    try {
      isVerifyOtpisLoading.value = true;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );

      await auth.signInWithCredential(credential);

      bottomMsg("Success", "You have successfully logged in!", true);
      isVerifyOtpisLoading.value = false;
      checkIfPhoneNumberExists(mobileNoCntlr.text);
    } catch (e) {
      isVerifyOtpisLoading.value = false;

      customAlertDialogue(
        title: "Failed",
        content: "Invalid OTP. Please try again.",
        txtbutton1Action: () {
          Get.back();
        },
        txtbuttonName1: "Try again",
      );
    }
  }

  void checkIfPhoneNumberExists(String phoneNumber) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .get();

    if (userDoc.exists) {
      Get.toNamed(AppPages.dashboardPage);
    } else {
      Get.toNamed(AppPages.registerPage);
    }
  }

  final isImagePick = false.obs;
  Future<void> pickImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      isImagePick.value = true;
      imageCntlr.value = File(pickedFile.path);
      isImagePick.value = false;
    }
  }

  final RxString selectedDate = ''.obs;

  void pickDateOfBirth(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yy').format(pickedDate);
      selectedDate.value = formattedDate;
    }
  }

  ///register
  final nameCntlr = TextEditingController();
  final emailCntlr = TextEditingController();
  final Rx<File?> imageCntlr = Rx<File?>(null);
  final isCreateAccountLoading = false.obs;
  Future<void> createAccount(
      String phoneNumber, String name, String email) async {
    try {
      isCreateAccountLoading.value = true;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${mobileNoCntlr.text}.jpg');
      await storageRef.putFile(imageCntlr.value!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(phoneNumber)
          .set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'imageUrl': imageUrl,
      });
      isCreateAccountLoading.value = false;
      storePhNo(phoneNumber);
      bottomMsg("Success", "You have successfully Created Your Account", true);
      Get.toNamed(AppPages.dashboardPage);
    } catch (e) {
      isCreateAccountLoading.value = false;
      customPrint("create account failed==$e");
      customAlertDialogue(
        title: "Failed",
        content: "Account Creation Failed.",
        txtbutton1Action: () {
          Get.back();
        },
        txtbuttonName1: "Try again",
      );
    }
  }
}
