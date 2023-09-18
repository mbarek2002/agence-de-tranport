import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationNewDriverController extends GetxController{

  CollectionReference notiDrivers = FirebaseFirestore.instance.collection("notiNewDrivers");
  String formatFirebaseTimestamp(Timestamp firebaseTimestamp) {
    DateTime dateTime = firebaseTimestamp.toDate();

    DateFormat formatter = DateFormat('EEE'+'. At'+' HH:mm');

    String formattedTime = formatter.format(dateTime);

    return formattedTime;
  }
  // delete notification New Driver
  // Future delete(DocumentSnapshot notificationNewDriver) async{
  //   print(notificationNewDriver["email"]);
  //   await notiDrivers.doc(notificationNewDriver.id).delete();
  // }




  // Future<void> delete(DocumentSnapshot notificationNewDriver, BuildContext context) async {
  //
  //     try {
  //       // Show a password input dialog
  //       final email = notificationNewDriver["email"];
  //
  //       final password = await  notificationNewDriver["password"];
  //       print(email);
  //       print(password);
  //       FirebaseApp app = await Firebase.initializeApp(
  //           name: 'secondary', options: Firebase.app().options);
  //
  //
  //       UserCredential userCredential =  await FirebaseAuth.instanceFor(app: app).signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //
  //       await userCredential.user?.delete();
  //      await app.delete();
  //       print("User deleted successfully.");
  //         print(notificationNewDriver["email"]);
  //         await notiDrivers.doc(notificationNewDriver.id).delete();
  //         print('Driver deleted successfully');
  //
  //     } catch (e) {
  //       print('Error deleting driver: $e');
  //     }
  //   }



  Future<void> delete(DocumentSnapshot notificationNewDriver, BuildContext context) async {
    // try {
      print("*************************");
      print("*************************");
      final email = notificationNewDriver["email"];
      final password = await notificationNewDriver["password"];

      print(email);
      print(password);

      // Show confirmation dialog
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Deletion'),
            content: Text('Are you sure you want to delete this user?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // User confirmed
                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // User cancelled
                },
                child: Text('No'),
              ),
            ],
          );
        },
      );

      if (confirmDelete == true) {
        // FirebaseApp app = await Firebase.initializeApp(
        //     name: 'secondary', options: Firebase.app().options);
        //
        // UserCredential userCredential = await FirebaseAuth.instanceFor(app: app).signInWithEmailAndPassword(
        //   email: email,
        //   password: password,
        // );
        //
        // if(userCredential.user != null) {
        //   print("lgin innnnnnnnnnnnnnnn");
        //   print(userCredential.user);
        //   await userCredential.user?.delete();
        // await app.delete();
        // }{
        //   print("note logined");
        // }
        //
        // print("User deleted successfully.");
        print(notificationNewDriver["email"]);
        await notiDrivers.doc(notificationNewDriver.id).delete();
        print('Driver deleted successfully');
      }
    // } catch (e) {
    //   print('Error deleting driver: $e');
    // }
  }

  }





