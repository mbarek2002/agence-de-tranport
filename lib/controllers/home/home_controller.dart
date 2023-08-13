import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController{
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  final box = GetStorage();


  void listenForNewNotifications() {
    databaseReference.child("userProfile").onChildAdded.listen((data) {
      print('change');

    });
  }

  int badgeCount = 0;

  void updateBadgeCount() {
      badgeCount += 1;
  }


}