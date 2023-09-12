import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housematic_radio/const/app_colors.dart';
import 'package:housematic_radio/ui/responsive/size_config.dart';
import 'package:housematic_radio/ui/style/styles.dart';
import 'package:housematic_radio/ui/views/home/pages/bottom_discover.dart';
import 'package:housematic_radio/ui/views/home/pages/bottom_home.dart';
import 'package:housematic_radio/ui/views/home/pages/bottom_profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavController extends StatelessWidget {
  BottomNavController({super.key});
  RxInt _initialIndex = 0.obs;

  final _pages = [
    BottomHome(),
    BottomDiscover(),
    BottomProfile(),
  ];

  showAds(context) async {
    var document =
        await FirebaseFirestore.instance.collection('ads').doc('0000').get();
    final data = document.data();

    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        builder: (_) {
          return InkWell(
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(data['source']))) {
                await launchUrl(
                  Uri.parse(data['source']),
                );
                Get.back();
              } else {
                Get.showSnackbar(AppStyles().failedSnackBar("Failed"));
              }
            },
            child: Ink(
              height: SizeConfig.screenHeight! / 1.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(data!['thumbnail']),
                      fit: BoxFit.cover)),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    Timer(Duration(seconds: 2), () => showAds(context));
    return Scaffold(
      bottomNavigationBar: Obx(() => Card(
            margin: EdgeInsets.all(0),
            child: SalomonBottomBar(
              // color: Get.isDarkMode == true ? AppColors.dark : Colors.white,
              // color: brightness == Brightness.dark ? AppColors.dark : Colors.white,
              selectedItemColor: AppColors.green,
              currentIndex: _initialIndex.value,
              margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),

              items: [
                SalomonBottomBarItem(
                  icon: Icon(Icons.home_filled),
                  title: Text("Home"),
                ),
                SalomonBottomBarItem(
                  icon: Icon(Icons.search_rounded),
                  title: Text("Discover"),
                ),
                SalomonBottomBarItem(
                  icon: Icon(Icons.person_outlined),
                  title: Text("Profile"),
                ),
              ],
              onTap: (int value) {
                _initialIndex.value = value;
              },
            ),
          )),
      body: SafeArea(
        child: Obx(
          () => _pages[_initialIndex.value],
        ),
      ),
    );
  }
}
