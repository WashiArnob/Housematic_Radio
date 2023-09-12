import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housematic_radio/ui/style/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreTab extends StatefulWidget {
  const StoreTab({super.key});

  @override
  State<StoreTab> createState() => _StoreTabState();
}

class _StoreTabState extends State<StoreTab> {
  List<Map> data = [];

  bool value = false;

  fetchStoreData() async {
    FirebaseFirestore.instance
        .collection('store')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        data.add({
          'title': doc['title'],
          'description': doc['description'],
          'product_url': doc['product_url'],
          'thumbnail': doc['thumbnail'],
        });
        setState(() {
          value = true;
        });
      });
    });
  }

  @override
  void initState() {
    fetchStoreData();
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
                    if (await canLaunchUrl(Uri.parse(data[i]['product_url']))) {
                      await launchUrl(
                        Uri.parse(data[i]['product_url']),
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
                          fit: BoxFit.fill),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data[i]['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                data[i]['description'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
