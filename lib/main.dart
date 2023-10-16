import 'package:admin_citygo/controllers/home/home_controller.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:admin_citygo/view/splash_screen/splash_screen.dart';
import 'package:admin_citygo/view/welcome_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(debug: true,ignoreSsl: true);
  await GetStorage.init();
  runApp(const MyApp());
}
HomeController homeController = Get.put(HomeController());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("////////////////////////////////////////////////////////////");
    print("////////////////////////////////////////////////////////////");
    print(homeController.box.read("email"));
    print("////////////////////////////////////////////////////////////");
    print("////////////////////////////////////////////////////////////");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      transitionDuration: Duration(milliseconds: 500),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      homeController.box.read("email")==null ||
          FirebaseAuth.instance.currentUser?.email ==null
        // ? SplashSreeen()
        ? WelcomeScreen()
      : HomeScreen(),


    );
  }
}
