import 'dart:io';
import 'dart:typed_data';

import 'package:admin_citygo/models/driver_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DriversController extends GetxController{

  CollectionReference driversList = FirebaseFirestore.instance.collection("drivers");
  CollectionReference driversNotifCollection = FirebaseFirestore.instance.collection('notiNewDrivers');

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
  Rx<bool> loadingConfirmed= false.obs;


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

  Future delete_driver(DriverModel d,BuildContext context )async{
    try {
      final email = d.email;
      final password = await d.password;

      // Show confirmation dialog


        FirebaseApp app = await Firebase.initializeApp(
            name: 'secondary', options: Firebase.app().options);

        UserCredential userCredential = await FirebaseAuth.instanceFor(app: app).signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        await userCredential.user?.delete();
        await app.delete();

        print("User deleted successfully.") ;
        print(d.email);
        await driversList.doc(d.id).delete();
      QuerySnapshot querySnapshot = await driversNotifCollection.where('email', isEqualTo: email).get();

      // Loop through the documents and delete them
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete();
      }
        print('Driver deleted successfully');
        fetchDrivers();
        init();

    } catch (e) {
      print('Error deleting driver: $e');
    }


  }

  Future<bool> isEmailRegistered(String email) async {
    try {
      List<String> signInMethods = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(email);
      print(signInMethods);

      // If the list is empty, the email is not registered
      return signInMethods.isEmpty;
    } catch (e) {
      print("Error checking email registration: $e");
      return false;
    }
  }


  Future add_driver(DriverModel d)async {
      loadingConfirmed(true);
    try {
       bool test = await isEmailRegistered(d.email);
       if(test == true)
         {
           print("trueeeeeee");
           // User? user = FirebaseAuth.instance.currentUser;
           FirebaseApp app = await Firebase.initializeApp(
               name: 'secondary', options: Firebase.app().options);
           await FirebaseAuth.instanceFor(app: app)
               .createUserWithEmailAndPassword(
               email: d.email, password: d.password);

          await  app.delete();
           // await FirebaseAuth.instance.createUserWithEmailAndPassword(
           //     email: d.email, password: d.password).then((value) {
          await   driversList.add({
               "driverImage": d.driverImage,
               "firstName": d.firstName,
               "lastName": d.lastName,
               "birthDate": d.birthDate,
               "identityNumber": d.identityNumber,
               "identityCardImageFace1": d.identityCardImageFace1,
               "identityCardImageFace2": d.identityCardImageFace2,
               "phoneNumber": d.phoneNumber,
               "licenceType": d.licenceType,
               "licenceImageFace1": d.licenceImageFace1,
               "licenceImageFace2": d.licenceImageFace2,
               "email": d.email,
               "password": d.password,
               "contractType": d.contractType,
               "more1": d.moreImage1,
               "more2": d.moreImage2,
               "more3": d.moreImage3,
             });
            await fetchDrivers();
             init();
           // });

           print("true");
         }
         else{
         print("falsedee");

         driversList.add({
           "driverImage": d.driverImage,
           "firstName": d.firstName,
           "lastName": d.lastName,
           "birthDate": d.birthDate,
           "identityNumber": d.identityNumber,
           "identityCardImageFace1": d.identityCardImageFace1,
           "identityCardImageFace2": d.identityCardImageFace2,
           "phoneNumber": d.phoneNumber,
           "licenceType": d.licenceType,
           "licenceImageFace1": d.licenceImageFace1,
           "licenceImageFace2": d.licenceImageFace2,
           "email": d.email,
           "password": d.password,
           "contractType": d.contractType,
           "more1": d.moreImage1,
           "more2": d.moreImage2,
           "more3": d.moreImage3,
         });
         fetchDrivers();
         init();


       }
           print('false');
    }catch(e){
      print(e.toString());
    }
    loadingConfirmed(false);
  }

  Future update_driver(DriverModel d)async{

   await driversList.doc(d.id).update(
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
   await fetchDrivers();
    init();
  }

  RxBool isLoading = false.obs;
  var driverList = <DriverModel>[].obs;
  var filteredList = <DriverModel>[].obs;
  var driversNameList = <String>[].obs;
  var driverEmailList = <String>[].obs;
  var identityDriverList = <int>[].obs;

  Future<void> fetchDrivers() async {
    try {
      isLoading.value = true;
      QuerySnapshot drivers =
      await FirebaseFirestore.instance.collection('drivers').get();
      driverList.clear();
      driversNameList.clear();
      identityDriverList.clear();
      driverEmailList.clear();
      for (var driver in drivers.docs) {
        driverList.add(
            DriverModel(
                          id: driver.id,
                          driverImage: driver['driverImage'],
                          firstName: driver['firstName'],
                          lastName: driver['lastName'],
                          birthDate: driver['birthDate'],
                          identityNumber: driver['identityNumber'],
                          phoneNumber: driver['phoneNumber'],
                          licenceType: driver['licenceType'],
                          email: driver ['email'],
                          contractType: driver['contractType'],
                          identityCardImageFace1: driver['identityCardImageFace1'],
                          identityCardImageFace2: driver['identityCardImageFace2'],
                          licenceImageFace1: driver['licenceImageFace1'],
                          licenceImageFace2: driver['licenceImageFace2'],
                          password: driver['password'],
                          moreImage1: driver['more1'],
                          moreImage2: driver['more2'],
                          moreImage3: driver['more3'],
                        )
        );
        driversNameList.add(driver['firstName']+" "+driver['lastName']);
        identityDriverList.add(driver['identityNumber']);
        driverEmailList.add(driver['email']);
      }
      filteredList.clear();
      filteredList.addAll(driverList);

      isLoading.value = false;
    } catch (e) {
     print('Error '+ e.toString());
    }
  }
  void updateList(String value){
    filteredList.assignAll(driverList.where((driver) =>
    (driver.firstName.toLowerCase()+" "+driver.lastName.toLowerCase()).startsWith(value.toLowerCase())));
  }
}






