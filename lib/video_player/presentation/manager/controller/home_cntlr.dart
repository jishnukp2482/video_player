import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/video_player/domain/entities/appdrawerModal.dart';
import 'package:videoplayer/video_player/presentation/routes/LocalStorageNames.dart';
import 'package:videoplayer/video_player/presentation/routes/app_pages.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/customPrint.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/custom_Toast.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/custom_snackbar.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/custome_alert_dialogue.dart';
import 'package:dio/dio.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:path/path.dart' as paTh;

class HomeCnltr extends GetxController {
  final box = GetStorage();
  var userData = {}.obs;
  List appdrawerItemsList = <APPDrawerModal>[];

  HomeCnltr() {
    appdrawerItemsList = [
      APPDrawerModal(Icons.person_pin_circle_outlined, "Profile", () {
        customPrint("profile cliked");
        String ph = box.read(LocalStorageNames.phoneNO).toString();
        customPrint("ph=$ph");
        getUserData(ph);
      }),
      APPDrawerModal(Icons.settings, "Settings", () {
        fetchFiles();
      }),
      APPDrawerModal(Icons.logout, "LogOut", () {
        Get.offAllNamed(AppPages.loginPage);
      })
    ];
  }

  Future<Map<String, dynamic>?> getUserData(String phoneNumber) async {
    try {
      final docRef =
          FirebaseFirestore.instance.collection('users').doc(phoneNumber);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        customPrint("snapSht have data");
        userData.clear();
        userData.value = docSnapshot.data()!;
        customPrint("img==${userData['imageUrl']}");
        Get.toNamed(AppPages.profilePage);
      } else {
        bottomMsg(
            "Failed", "No user found with phone number: $phoneNumber", false);
        customPrint('No user found with phone number: $phoneNumber');
        return null;
      }
    } catch (e) {
      customPrint('Failed to get user data: $e');
      customAlertDialogue(
        title: "Failed",
        content: "$e",
        txtbutton1Action: () {
          Get.back();
        },
        txtbuttonName1: "Try again",
      );
      return null;
    }
    return null;
  }

  final RxList<dynamic> videoFiles = <dynamic>[].obs;

  final apiKey = "AIzaSyC0_jnvSx1SOGjA5gNz6Rzmd0dfhcZ5EHI";
  final folderId = '18sP9ATUfyam3n-M71oWwjOgNFAMdUX4W';

  final isFilesLoading = false.obs;
  Future<void> fetchFiles() async {
    isFilesLoading.value = true;
    final url =
        'https://www.googleapis.com/drive/v3/files?q=\'$folderId\'+in+parents&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final files = data['files'] as List<dynamic>;

      // Filter out only video files
      final videoFilesList = files.where((file) {
        final mimeType = file['mimeType'];
        return mimeType.startsWith('video/');
      }).toList();

      videoFiles.value = videoFilesList;
      isFilesLoading.value = false;
    } else {
      isFilesLoading.value = false;
      customPrint('Failed to load files');
      customAlertDialogue(
        title: "Failed",
        content: "Data Not Found",
        txtbutton1Action: () {
          Get.back();
        },
        txtbuttonName1: "Try  Again Refresh",
      );
    }
  }

  final selectedVideoId = "".obs;
  final selectedVideoFileName = "".obs;
  final videoPath = "https://drive.google.com/uc?export=download&id=".obs;
  videoPlay(String id, String fileName, bool isFromWidget) async {
    // const path = "/storage/emulated/0/Download/";
    // String filePath = paTh.join(path, "video_$fileName");
    // if (await File(filePath).exists()) {
    //   customPrint("filepath===$filePath");
    //   videoPath.value = filePath;
    //   selectedVideoId.value = id;
    //   selectedVideoFileName.value = fileName;
    //   bottomMsg(
    //       "Playing Offline",
    //       "This video is already downloaded and its playing offline Mode",
    //       true);
    // } else {
    customPrint("id ==$id");
    videoPath.value =
        "https://drive.google.com/uc?export=download&id=${selectedVideoId.value}";
    // bottomMsg("Playing Offline", "This video Playing online", true);
    selectedVideoId.value = id;
    selectedVideoFileName.value = fileName;
    //}
    if (isFromWidget == true) {
      Get.toNamed(AppPages.videoplayPage);
    }
  }

  final isFileDownload = false.obs;
  Future<void> downloadVideo(String url, String fileName) async {
    try {
      isFileDownload.value = true;
      final directory = await getExternalStorageDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      FileDownloader.downloadFile(
          url: url,
          name: "video_$fileName",
          // subPath: downloadPath,
          onDownloadCompleted: (String path) {
            showCustomToast("FILE DOWNLOADED TO PATH: $path'");
            customPrint("path=$path");
            isFileDownload.value = false;
          },
          onDownloadError: (String error) {
            showCustomToast('DOWNLOAD ERROR: $error');
          });
    } catch (e) {
      showCustomToast('Error downloading video: $e');
      isFileDownload.value = false;
    }
  }

  void playNextVideo() {
    alertPrint(selectedVideoId.value);
    for (var i in videoFiles) {
      warningPrint("id ==${i['id']}");
    }
    int currentIndex =
        videoFiles.indexWhere((file) => file['id'] == selectedVideoId.value);
    warningPrint("current index==$currentIndex");
    if (currentIndex < videoFiles.length - 1) {
      var nextFile = videoFiles[currentIndex + 1];
      alertPrint("next id=${nextFile['id']}");
      alertPrint("next fileNmae=${nextFile['name']}");
      if (nextFile['id'] != null && nextFile['name'] != null) {
        selectedVideoId.value = nextFile['id'];
        selectedVideoFileName.value = nextFile['name'];
        videoPlay(selectedVideoId.value, selectedVideoFileName.value,false);
      } else {
        customPrint("The next video does not have a valid id or fileName.");
      }
    } else if (currentIndex == -1) {
      customPrint("The selected video ID was not found in the list.");
    } else {
      showCustomToast("No more videos available");
      customPrint("No more videos available.");
    }
  }

  void playPreviousVideo() {
    alertPrint(selectedVideoId.value);
    for (var i in videoFiles) {
      warningPrint("id ==${i['id']}");
    }
    int currentIndex =
        videoFiles.indexWhere((file) => file['id'] == selectedVideoId.value);
    warningPrint("current index==$currentIndex");
    if (currentIndex > 0) {
      var previousFile = videoFiles[currentIndex - 1];
      alertPrint("previous id=${previousFile['id']}");
      alertPrint("previous fileNmae=${previousFile['name']}");
      if (previousFile['id'] != null && previousFile['name'] != null) {
        selectedVideoId.value = previousFile['id'];
        selectedVideoFileName.value = previousFile['name'];
        videoPlay(selectedVideoId.value, selectedVideoFileName.value,false);
      } else {
        customPrint("The previous video does not have a valid id or fileName.");
      }
    } else if (currentIndex == -1) {
      customPrint("The selected video ID was not found in the list.");
    } else {
      showCustomToast("This is the first video");
      customPrint("This is the first video.");
    }
  }
}
