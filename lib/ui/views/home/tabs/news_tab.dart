import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housematic_radio/ui/style/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  List<Map> data = [];

  bool value = false;

  fetchNewsData() async {
    FirebaseFirestore.instance
        .collection('news')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        data.add({
          'thumbnail': doc['thumbnail'],
          'news_url': doc['news_url'],
        });
        setState(() {
          value = true;
        });
      });
    });
  }

  @override
  void initState() {
    fetchNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value,
      replacement: Center(
        child: CircularProgressIndicator(),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () async {
                    if (await canLaunchUrl(Uri.parse(data[i]['news_url']))) {
                      await launchUrl(
                        Uri.parse(data[i]['news_url']),
                      );
                    } else {
                      Get.showSnackbar(AppStyles().failedSnackBar("Failed"));
                    }
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    width: double.maxFinite,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(data[i]['thumbnail']),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
