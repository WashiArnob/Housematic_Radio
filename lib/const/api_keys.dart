import 'package:flutter/foundation.dart';

class ApiKeys {
  static late String appID;
  static late String apiKey ;
  static String messagingSenderId = "705534787695";
  static String projectId = "housematic-radio";
  static String storageBucket = "housematic-radio.appspot.com";

  collectAppID() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      appID = "1:705534787695:android:83b3d3537cadacb05f4d9a";
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      appID = "1:705534787695:ios:338f4f99b93073175f4d9a";
    }
  }

  collectApiKey() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      apiKey = "AIzaSyCagfQcZHuwpm67ni7r72Pjd9_QsKtoy4M";
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      apiKey = "AIzaSyBV0WCRJqkH047mZQmWk-4Vz3oa6vYACko";
    }
  }


}
