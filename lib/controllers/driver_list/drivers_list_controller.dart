import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriversListController extends GetxController{

  CollectionReference driversList = FirebaseFirestore.instance.collection("drivers");

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController licenceTypeController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  Future delete_driver(String id )async{
    await driversList.doc(id).delete();
  }

}