
import 'package:admin_citygo/models/notification_new_driver_model.dart';
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

  var isLoading =false;
  var newNotiDriverList = <NotificationNewDriver>[];
  // Future<void> fetchNotifiactionNewDriver()async{
  //   QuerySnapshot notiDrivers =await FirebaseFirestore.instance.collection('notiNewDrivers').get();
  //   newNotiDriverList.clear();
  //   for(var driver in notiDrivers.docs){
  //     try{
  //       Timestamp firebaseTimestamp = driver['submissionDate'];
  //       String formattedTime = formatFirebaseTimestamp(firebaseTimestamp);
  //       print(formattedTime);
  //
  //     newNotiDriverList.add(
  //     NotificationNewDriver(
  //     id: driver.id,
  //     firstName: driver['firstName'],
  //     lastName: driver['lastName'],
  //     birthDate: driver['birthDate'],
  //     identityNumber: driver['identityNumber'],
  //     phoneNumber: driver['phoneNumber'],
  //     licenceType: driver['licenceType'],
  //     email: driver ['email'],
  //     // email: formattedTime,
  //     // contractType: driver['contractType'],
  //     submissionDate: formattedTime,
  //     valid: driver['valid'])
  //     );
  //     isLoading = false;
  //     }catch(e){
  //       Get.snackbar('Error', '${e.toString()}');
  //     }
  //   }
  //   print("length"+newNotiDriverList.length.toString());
  //
  // }

  //delete notification New Driver
  Future delete(String notificationNewDriver) async{
    await notiDrivers.doc(notificationNewDriver).delete();
  }
  // add a new driver
// Future add_driver(){
//     print('');
// }

}