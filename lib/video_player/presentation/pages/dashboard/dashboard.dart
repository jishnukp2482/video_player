import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:videoplayer/video_player/presentation/manager/controller/home_cntlr.dart';
import 'package:videoplayer/video_player/presentation/themes/app_colors.dart';
import 'package:videoplayer/video_player/presentation/widgets/custom/customPrint.dart';
import 'package:videoplayer/video_player/presentation/widgets/home/video_widgets.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final homeCntlr = Get.find<HomeCnltr>();
  @override
  void initState() {
    homeCntlr.fetchFiles();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              backgroundColor: AppColors.appGreen,
              centerTitle: true,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer(); // Opens the drawer
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: AppColors.white,
                    ),
                  );
                },
              ),
              title: const Text(
                "Home",
                style: TextStyle(color: AppColors.white),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VideoMenu(),
              ],
            )));
  }
}

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});
  final homeCntlr = Get.find<HomeCnltr>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.appGreen,
            ),
            child: Text(
              'Video Player',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ...homeCntlr.appdrawerItemsList.map(
            (e) {
              return ListTile(
                  leading: Icon(e.iconData),
                  title: Text(e.titile),
                  onTap: () {
                    customPrint("clicked listtile");
                    e.ontap();
                  });
            },
          ),
        ],
      ),
    );
  }
}
