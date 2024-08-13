import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoplayer/video_player/presentation/manager/controller/home_cntlr.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:videoplayer/video_player/presentation/themes/app_colors.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/customPrint.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  VideoPlayerPageState createState() => VideoPlayerPageState();
}

class VideoPlayerPageState extends State<VideoPlayerPage> {
  final homeCntlr = Get.find<HomeCnltr>();
  late final player = Player(configuration: const PlayerConfiguration());
  late final controller = VideoController(
    player,
  );

  @override
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    customPrint("worked");
    player.open(Media(
        "${homeCntlr.videoPath.value}"));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Video Player'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 9.0 / 16.0,
              child: Video(
                controller: controller,
                subtitleViewConfiguration: const SubtitleViewConfiguration(),
              ),
            ),
            Text("file name ${homeCntlr.selectedVideoId.value}"),
            SizedBox(
              height: h * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        homeCntlr.playPreviousVideo();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.black),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.black,
                    ),
                  ),
                  Obx(
                    () => homeCntlr.isFileDownload.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                foregroundColor: AppColors.black),
                            onPressed: () {
                              homeCntlr.downloadVideo(
                                  "https://drive.google.com/uc?export=download&id=${homeCntlr.selectedVideoId.value}",
                                  homeCntlr.selectedVideoId.value);
                            },
                            label: const Text("Download"),
                            icon: const Icon(
                              Icons.download,
                              color: AppColors.appGreen,
                            ),
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        homeCntlr.playNextVideo();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.black),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
