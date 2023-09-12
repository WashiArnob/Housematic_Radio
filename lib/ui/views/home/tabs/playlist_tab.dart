import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housematic_radio/ui/route/routes.dart';
import 'package:housematic_radio/ui/views/home/features/player_screen.dart';

import '../../../../const/app_colors.dart';

class PlaylistTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("playlist")
          .doc('0000')
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          // return Text('Error = ${snapshot.error}');
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.green,
            ),
          );
        }

        if (snapshot.hasData) {
          var docs = snapshot.data!.data()!['categories'];

          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: GridView.builder(
                itemCount: docs.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (_, i) {
                  // final data = docs[i].data();
                  return InkWell(
                    onTap: () {
                      Get.toNamed(
                        playlistItems,
                        arguments: docs[i]['category_name'],
                      );
                    },
                    child: Ink(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            docs[i]['category_thumbnail'],
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.maxFinite,
                          color: Colors.amber.withOpacity(0.8),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              docs[i]['category_name'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.green,
          ),
        );
      },
    );
  }
}

class PlayListItems extends StatelessWidget {
  String category;
  PlayListItems({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("playlist")
            .doc('0000')
            .collection("all")
            .where(
              "category",
              isEqualTo: category,
            )
            .snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: CircularProgressIndicator(),
            );

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;

            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 20),
              child: GridView.builder(
                  itemCount: docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (_, i) {
                    final item = docs[i].data();
                    return InkWell(
                      onTap: () {
                        Map detailsData = {
                          'title': item['title'],
                          'description': item['description'],
                          'source': item['source'],
                          'thumbnail': item['thumbnail'],
                        };

                        Get.toNamed(playerScreen, arguments: detailsData);
                      },
                      child: Ink(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage((item["thumbnail"])),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.maxFinite,
                            height: 30,
                            color: Colors.amber.withOpacity(0.8),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                item['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.amber,
            ),
          );
        },
      ),
   
   
   
    );
  }
}
