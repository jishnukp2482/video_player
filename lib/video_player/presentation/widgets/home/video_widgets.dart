import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:videoplayer/video_player/presentation/manager/controller/home_cntlr.dart';

class VideoMenu extends StatelessWidget {
  VideoMenu({super.key});
  final homeCntlr = Get.find<HomeCnltr>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCntlr.isFilesLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: homeCntlr.videoFiles.length,
              itemBuilder: (context, index) {
                return VideoItem(
                    fileName: homeCntlr.videoFiles[index]['name'],
                    fileID: homeCntlr.videoFiles[index]['id']);
              },
            ),
    );
  }
}

class VideoItem extends StatelessWidget {
  VideoItem({
    super.key,
    required this.fileName,
    required this.fileID,
  });
  final String fileName;
  final String fileID;
  final homeCntlr = Get.find<HomeCnltr>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.video_file),
        title: Text(fileName),
        onTap: () {
          homeCntlr.videoPlay(fileID, fileName, true);
        },
      ),
    );
  }
}
