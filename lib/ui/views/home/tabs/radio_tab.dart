import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housematic_radio/ui/route/routes.dart';

class RadioTab extends StatefulWidget {
  RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  List<Map> data = [];
  bool value = false;
  fetchData() async {
    FirebaseFirestore.instance
        .collection('radio')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        data.add({
          'title': doc['title'],
          'description': doc['description'],
          'source': doc['source'],
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
    fetchData();
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
            reverse: true,
            itemBuilder: (_, i) {
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Image.network(
                    data[i]['thumbnail'],
                    width: 100,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(data[i]['title']),
                  trailing: IconButton(
                    onPressed: () =>
                        Get.toNamed(playerScreen, arguments: data[i]),
                    icon: Icon(Icons.play_arrow),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
