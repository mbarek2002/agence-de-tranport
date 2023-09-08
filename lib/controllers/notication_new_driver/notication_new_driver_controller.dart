import 'package:cloud_firestore/cloud_firestore.dart';
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




  Future<void> delete(DocumentSnapshot notificationNewDriver, BuildContext context) async {
    final email = notificationNewDriver["email"];
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Show a password input dialog
        final password = await showPasswordDialog(context);

        if (password != null) {
          // Reauthenticate the user with the provided password
          final AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: password,
          );

          await user.reauthenticateWithCredential(credential);

          // Delete the driver document from Firestore
          await notiDrivers.doc(notificationNewDriver.id).delete();

          // Delete the user from Firebase Authentication
          await user.delete();

          print('Driver deleted successfully');
        }
      } catch (e) {
        print('Error deleting driver: $e');
      }
    }
  }

// Function to show a password input dialog
  Future<String?> showPasswordDialog(BuildContext context) async {
    TextEditingController passwordController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Your Password'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, null), // Cancel button
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, passwordController.text), // Confirm button
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }



}