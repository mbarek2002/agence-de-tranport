import 'package:admin_citygo/models/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ConsultNotiNewDriversController extends GetxController{

  CollectionReference drivers = FirebaseFirestore.instance.collection("drivers");
  
  Future add_driver(DriverModel d)async{
    drivers.add({
      "driverImage":d.driverImage,
      "firstName":d.firstName,
      "lastName":d.lastName,
      "birthDate":d.birthDate,
      "identityNumber":d.identityNumber,
      "identityCardImage":d.identityCardImage,
      "phoneNumber":d.phoneNumber,
      "licenceType":d.licenceType,
      "licenceImage":d.licenceImage,
      "email":d.email
    });
  }


}