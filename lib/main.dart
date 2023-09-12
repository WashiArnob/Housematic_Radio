import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:housematic_radio/const/api_keys.dart';
import 'package:housematic_radio/const/app_colors.dart';
import 'package:housematic_radio/const/app_strings.dart';
import 'package:housematic_radio/ui/route/routes.dart';
import 'package:housematic_radio/ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  ApiKeys().collectAppID();
  ApiKeys().collectApiKey();
  await GetStorage.init();

  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      name: AppStrings.appName,
      options: FirebaseOptions(
          apiKey: ApiKeys.apiKey,
          appId: ApiKeys.appID,
          messagingSenderId: ApiKeys.messagingSenderId,
          projectId: ApiKeys.projectId,
          storageBucket: ApiKeys.storageBucket));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.green,
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.green,
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = GetStorage();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var theme = box.read('theme');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme().lightTheme(context),
      darkTheme: AppTheme().darkTheme(context),
      themeMode: theme == null
          ? ThemeMode.light
          : theme == 'dark'
              ? ThemeMode.dark
              : ThemeMode.light,
      initialRoute: splash,
      getPages: getPages,
    );
  }
}
