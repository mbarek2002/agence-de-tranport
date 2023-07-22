import 'dart:io';
import 'dart:typed_data';

import 'package:admin_citygo/models/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DriversController extends GetxController{

  CollectionReference driversList = FirebaseFirestore.instance.collection("drivers");
  ////////////////////////////////////////////////////
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController licenceTypeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  /////////////////////////////////////////////////////////////////////



  void init(){
    selectedIdentityFace1=Rx<File?>(null);
    selectedIdentityFace2=Rx<File?>(null);
    selectedLicenceFace1=Rx<File?>(null);
    selectedLicenceFace2=Rx<File?>(null);
    selectedMore1=Rx<File?>(null);
    selectedMore2=Rx<File?>(null);
    selectedMore3=Rx<File?>(null);
  }

  final picker =ImagePicker();

  ///////////////////identity file picker ///////////////////
  Rx<File?> selectedIdentityFace1 = Rx<File?>(null);

  Future<void> pickIdentityFileFace1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      selectedIdentityFace1.value = File(result.files.single.path!);
    }
  }

  Rx<File?> selectedIdentityFace2 = Rx<File?>(null);

  Future<void> pickIdentityFileFace2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      selectedIdentityFace2.value = File(result.files.single.path!);
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        selectedIdentityFace1.value=File(pickedFile.path);
      } else {
        print('No image selected.');
      }
  }
  ////////////////////////fin identity file picker///////////////////////////////////////////////

  /////////////////more file picker//////////////////
  Rx<File?> selectedMore1 = Rx<File?>(null);

  Future<void> pickMore1File() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      selectedMore1.value = File(result.files.single.path!);
    }
  }

//
  Rx<File?> selectedMore2 = Rx<File?>(null);

  Future<void> pickMore2File() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      selectedMore2.value = File(result.files.single.path!);
    }
  }
  //
  Rx<File?> selectedMore3 = Rx<File?>(null);

  Future<void> pickMore3File() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      selectedMore3.value = File(result.files.single.path!);
    }
  }
  /////////////////fin more file picker //////////////////
  ////////////////////licence file picker //////////////////
  Rx<File?> selectedLicenceFace1 = Rx<File?>(null);

  Future<void> pickLicenceFileFace1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      selectedLicenceFace1.value = File(result.files.single.path!);
    }
  }

  Rx<File?> selectedLicenceFace2 = Rx<File?>(null);

  Future<void> pickLicenceFileFace2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      selectedLicenceFace2.value = File(result.files.single.path!);
    }
  }

//////////////////////////////fin licence file picker s/////////////////////////////////////////

//////////////cud operation///////////////////
  Future delete_driver(String id )async{
    await driversList.doc(id).delete();
  }

  Future add_driver(DriverModel d)async{
    print('/////////////////////////////');
    print('driver controller'+d.password);
    print('/////////////////////////////');

    driversList.add({
      "driverImage":d.driverImage,
      "firstName":d.firstName,
      "lastName":d.lastName,
      "birthDate":d.birthDate,
      "identityNumber":d.identityNumber,
      "identityCardImageFace1":d.identityCardImageFace1,
      "identityCardImageFace2":d.identityCardImageFace2,
      "phoneNumber":d.phoneNumber,
      "licenceType":d.licenceType,
      "licenceImageFace1":d.licenceImageFace1,
      "licenceImageFace2":d.licenceImageFace2,
      "email":d.email,
      "password":d.password,
      "contractType":d.contractType,
      "more1":d.moreImage1,
      "more2":d.moreImage2,
      "more3":d.moreImage3,
    });
    init();
  }

  Future update_driver(DriverModel d)async{
    driversList.doc(d.id).update(
        {
          "driverImage":d.driverImage,
          "firstName":d.firstName,
          "lastName":d.lastName,
          "birthDate":d.birthDate,
          "identityNumber":d.identityNumber,
          "identityCardImageFace1":d.identityCardImageFace1,
          "identityCardImageFace2":d.identityCardImageFace2,
          "phoneNumber":d.phoneNumber,
          "licenceType":d.licenceType,
          "licenceImageFace1":d.licenceImageFace1,
          "licenceImageFace2":d.licenceImageFace2,
          "email":d.email,
          "password":d.password,
          "contractType":d.contractType,
          "more1":d.moreImage1,
          "more2":d.moreImage2,
          "more3":d.moreImage3,
        }
    );
  }

///////////////////fin cud operation/////////////////////

}