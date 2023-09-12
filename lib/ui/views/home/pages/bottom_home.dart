import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housematic_radio/const/app_colors.dart';
import 'package:housematic_radio/ui/responsive/size_config.dart';
import 'package:housematic_radio/ui/style/styles.dart';
import 'package:housematic_radio/ui/views/home/tabs/news_tab.dart';
import 'package:housematic_radio/ui/views/home/tabs/playlist_tab.dart';
import 'package:housematic_radio/ui/views/home/tabs/radio_tab.dart';
import 'package:housematic_radio/ui/views/home/tabs/store_tab.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomHome extends StatefulWidget {
  BottomHome({super.key});

  @override
  State<BottomHome> createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final webSiteUrl = Uri.parse('https://www.housematicradio.com/');
  final privacyUrl = Uri.parse('https://www.housematicradio.com/privacy/');
  final fbUrl = Uri.parse('https://www.facebook.com/HouseMaticradio');
  final soundCloudUrl = Uri.parse('https://soundcloud.com/housematicradio');
  final instragramUrl =
      Uri.parse('https://www.instagram.com/housematicradiocom/');
  final youtubeUrl = Uri.parse('https://www.youtube.com/@HousematicRadio');
  final mixCloudUrl = Uri.parse('https://www.mixcloud.com/pornostarrecords/');
  launchUrloBrowser(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
      );
    } else {
      Get.showSnackbar(AppStyles().failedSnackBar("Failed"));
    }
  }

  appShare() {
    if (Platform.isAndroid) {
      // add the [https]
      Share.share(
          'https://play.google.com/store/apps/details?id=com.sleepkart.team'); // new line
    } else {
      // add the [https]
      Share.share("https://apps.apple.com/us/app/sleepkart/id1602827809");
      // new line
    }
    // Navigator.of(context).pop();
    // Navigator.of(context).pushNamed('/settings');
  }

  notificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }
  
  @override
  void initState() {
    notificationPermission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: Container(
          width: SizeConfig.screenWidth! / 1.4,
          height: SizeConfig.screenHeight! / 2,
          decoration: BoxDecoration(
              color:
                  brightness == Brightness.dark ? AppColors.dark : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                drawerItems(
                  Icons.star_outlined,
                  "RATE HOUSEMATIC RADIO",
                  () {
                    LaunchReview.launch(
                        androidAppId: "com.app.housematic_radio",
                        iOSAppId: "585027354");
                  },
                ),
                drawerItems(Icons.language_outlined, "VISIT OUR WEBSITE",
                    () => launchUrloBrowser(webSiteUrl)),
                drawerItems(
                  Icons.share_outlined,
                  "SHARE",
                  () => appShare(),
                ),
                drawerItems(
                  Icons.privacy_tip_outlined,
                  "PRIVACY POLICY",
                  () => launchUrloBrowser(privacyUrl),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () => launchUrloBrowser(mixCloudUrl),
                        icon: const Text(
                          'M',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        )),
                    IconButton(
                        onPressed: () => launchUrloBrowser(fbUrl),
                        icon: Image.asset('assets/icons/facebook.png')),
                    IconButton(
                        onPressed: () => launchUrloBrowser(soundCloudUrl),
                        icon: Image.asset('assets/icons/audio.png')),
                    IconButton(
                        onPressed: () => launchUrloBrowser(instragramUrl),
                        icon: Image.asset('assets/icons/instagram.png')),
                    IconButton(
                        onPressed: () => launchUrloBrowser(youtubeUrl),
                        icon: Image.asset('assets/icons/youtube.png')),
                  ],
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Housematic Radio'),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: "Radio",
              ),
              Tab(
                text: "Playlist",
              ),
              Tab(
                text: "Store",
              ),
              Tab(
                text: "News",
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
              icon: const Icon(Icons.keyboard_option_key),
            ),
          ],
        ),
        body: TabBarView(children: [
          RadioTab(),
          PlaylistTab(),
          StoreTab(),
          NewsTab(),
        ]),
      ),
    );
  }
}

Widget drawerItems(icon, title, onClick) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: InkWell(
      onTap: onClick,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
          ),
          const VerticalDivider(),
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    ),
  );
}
