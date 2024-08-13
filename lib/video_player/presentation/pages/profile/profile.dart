import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:videoplayer/video_player/presentation/manager/controller/auth_cntlr.dart';
import 'package:videoplayer/video_player/presentation/manager/controller/home_cntlr.dart';
import 'package:videoplayer/video_player/presentation/themes/app_colors.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final homeCntlr = Get.find<HomeCnltr>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appGreen,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(w * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      child: Text(
                    "Name",
                    style: TextStyle(color: AppColors.black),
                  )),
                  const Expanded(
                      child: Center(
                          child: Text(
                    ":",
                    style: TextStyle(color: AppColors.black),
                  ))),
                  Expanded(
                      child: Text(
                    homeCntlr.userData['name'] ?? 'N/A',
                    style: const TextStyle(color: AppColors.black),
                  )),
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      child: Text(
                    "Email",
                    style: TextStyle(color: AppColors.black),
                  )),
                  const Expanded(
                      child: Center(
                          child: Text(
                    ":",
                    style: TextStyle(color: AppColors.black),
                  ))),
                  Expanded(
                      child: Text(
                    homeCntlr.userData['email'] ?? 'N/A',
                    style: const TextStyle(color: AppColors.black),
                  )),
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                      child: Text(
                    "Phone No",
                    style: TextStyle(color: AppColors.black),
                  )),
                  const Expanded(
                      child: Center(
                          child: Text(
                    ":",
                    style: TextStyle(color: AppColors.black),
                  ))),
                  Expanded(
                      child: Text(
                    homeCntlr.userData['phoneNumber'] ?? 'N/A',
                    style: const TextStyle(color: AppColors.black),
                  )),
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: AppColors.black)),
                height: h * 0.18,
                width: w * 0.5,
                child: CachedNetworkImage(
                  imageUrl: homeCntlr.userData['imageUrl'] ?? '',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
