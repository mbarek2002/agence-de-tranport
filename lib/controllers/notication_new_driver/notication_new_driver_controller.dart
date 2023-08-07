import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationNewDriverController extends GetxController{

  CollectionReference notiDrivers = FirebaseFirestore.instance.collection("notiNewDrivers");
  String formatFirebaseTimestamp(Timestamp firebaseTimestamp) {
    DateTime dateTime = firebaseTimestamp.toDate();

    DateFormat formatter = DateFormat('EEE'+'. At'+' HH:mm');

    String formattedTime = formatter.format(dateTime);

    return formattedTime;
  }
  // delete notification New Driver
  Future delete(String notificationNewDriver) async{
    await notiDrivers.doc(notificationNewDriver).delete();
  }

}