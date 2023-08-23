import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/course.dart';
import 'package:admin_citygo/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_excel/excel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class CoursesController extends GetxController{

  TextEditingController pickUpLocationConroller = TextEditingController();
  TextEditingController dropOffLocationConroller = TextEditingController();
  TextEditingController pickUpDateConroller= TextEditingController();
  TextEditingController passagersConroller= TextEditingController();
  TextEditingController luggageConroller= TextEditingController();
  TextEditingController regNumberController= TextEditingController();
  TextEditingController seatingCapacityController= TextEditingController();
  TextEditingController luggageBigSizeController= TextEditingController();
  TextEditingController luggageMediumSizeController= TextEditingController();
  TextEditingController collieController= TextEditingController();

  CollectionReference courses = FirebaseFirestore.instance.collection("courses");

  LoginController loginController =Get.put(LoginController());

  RxInt formNum = 1.obs;

  RxString selectedItem = 'Driver name'.obs;

  RxInt selectedItemId=RxInt(0);

  final formKey = GlobalKey<FormState>();

  RxBool validLicenceType=false.obs;

  RxString image=''.obs;
  RxString imageCar1=''.obs;
  RxString imageCar2=''.obs;
  RxString imageCar3=''.obs;
  RxString imageCar4=''.obs;


  RxBool isChecked = true.obs;
  RxBool isLoading = false.obs;

  RxBool isReturn = false.obs;
  RxBool checkBox1 = false.obs;
  RxBool checkBox2 = false.obs;

  RxInt usedLuggageBigSize=0.obs;
  RxInt usedLuggageMediumSize=0.obs;
  RxInt usedCollie=0.obs;

  var carImage1URL="".obs;
  var carImage2URL="".obs;
  var carImage3URL="".obs;
  var carImage4URL="".obs;

//////////////////////////check list//////////////////////////////

  RxBool checkList = false.obs;
  RxBool checkList1 = false.obs;
  RxBool checkList2 = false.obs;
  RxBool checkList3 = false.obs;
  RxBool checkList4 = false.obs;
  RxBool checkList5 = false.obs;
  RxBool checkList6 = false.obs;
  RxBool checkList7 = false.obs;
  RxBool checkList8 = false.obs;
  RxBool checkList9 = false.obs;
  RxBool checkList10 = false.obs;
  RxBool checkList11 = false.obs;
  RxBool checkList12 = false.obs;
  RxBool checkList13 = false.obs;
  RxBool checkList14 = false.obs;
  RxBool checkList15 = false.obs;
  RxBool checkList16 = false.obs;

  var checkListTable = <checklistData>[].obs;


////////////////////////////end check list///////////////////////////////////
  void init(){
    image.value='';
    selectedItem.value = 'Driver name';
    validLicenceType.value=false;
    passengerCarDetails=RxList<rowdata>([]);
    passengerDetails=RxList<rowdata>([]);

    isReturn.value = false;
    checkBox1.value = false;
    checkBox2.value = false;

     usedLuggageBigSize.value=0;
     usedLuggageMediumSize.value=0;
     usedCollie.value=0;

     image.value="";
     imageCar1.value="";
     imageCar2.value="";
     imageCar3.value="";
     imageCar4.value="";

     carImage1URL.value="";
     carImage2URL.value="";
     carImage3URL.value="";
     carImage4URL.value="";

     checkList.value = false;
     checkList1.value = false;
     checkList2.value = false;
     checkList3.value = false;
     checkList4.value = false;
     checkList5.value = false;
     checkList6.value = false;
     checkList7.value = false;
     checkList8.value = false;
     checkList9.value = false;
     checkList10.value = false;
     checkList11.value = false;
     checkList12.value = false;
     checkList13.value = false;
     checkList14.value = false;
     checkList15.value = false;
     checkList16.value = false;

  }

  Future<void> pickOrderFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      image.value = result.files.single.path!;
    }
  }
  /////////////////////////////////
  var coursesAll = <Course>[].obs;
  var coursesListAdmin = <Course>[].obs;
  var coursesListDriver = <Course>[].obs;

/////////////admin////////////////
  var coursesList = <Course>[].obs;
  var coursesListToday = <Course>[].obs;
  var coursesListTomorrow = <Course>[].obs;
  /////////////driver////////////////
  var coursesListDrivers = <Course>[].obs;
  var coursesListTodayDrivers = <Course>[].obs;
  var coursesListTomorrowDrivers = <Course>[].obs;
  ///////////////////history//////////////////////////
  var coursesListTodayHistory = <Course>[].obs;
  var coursesListYesterDayHistory = <Course>[].obs;
  var coursesListOlderHistory = <Course>[].obs;

///////////////////function upload  car images && order mission file/////////////////////////
  var orderImageURL="".obs;
  Future<void> uploadOrderImage()async {
    final driverUploadTask = FirebaseStorage
        .instance
        .ref('order/' +
        DateTime.now().difference(
            DateTime(2022, 1, 1)).inSeconds.toString() +
        '${image.value?.split('/').last}')
        .putFile(File(image.value));
    final driverSnapshot =
    await driverUploadTask.whenComplete(() => null);
    orderImageURL.value =
    await driverSnapshot.ref
        .getDownloadURL();
  }

  Future<void> uploadCarImages() async {
    try {
//       final car1UploadTask = FirebaseStorage.instance.ref('carImages/' +
//           DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
//           '${imageCar1.value?.split('/').last}').putFile(File(imageCar1.value));
//       final car1Snapshot = await car1UploadTask.whenComplete(() => null);
//       carImage1URL.value =
//       await car1Snapshot.ref.getDownloadURL();
// /////////////////////////////////
//       final car2UploadTask = FirebaseStorage.instance.ref('carImages/' +
//           DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
//           '${imageCar2.value?.split('/').last}').putFile(File(imageCar2.value));
//       final car2Snapshot = await car2UploadTask.whenComplete(() => null);
//       carImage2URL.value =
//       await car2Snapshot.ref.getDownloadURL();
// /////////////////////////////
//       final car3UploadTask = FirebaseStorage.instance.ref('carImages/' +
//           DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
//           '${imageCar3.value?.split('/').last}').putFile(File(imageCar3.value));
//       final car3Snapshot = await car3UploadTask.whenComplete(() => null);
//       carImage3URL.value =
//       await car3Snapshot.ref.getDownloadURL();
// ///////////////////////////////
//       final car4UploadTask = FirebaseStorage.instance.ref('carImages/' +
//           DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
//           '${imageCar4.value?.split('/').last}').putFile(File(imageCar4.value));
//       final car4Snapshot = await car4UploadTask.whenComplete(() => null);
//       carImage4URL.value =
//       await car4Snapshot.ref.getDownloadURL();
// /////////////////////////////
    /////////
      final car1UploadTask = FirebaseStorage.instance.ref('carImages/' +
          DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
          '${imageCar1.value?.split('/').last}').putFile(File(imageCar1.value));
      final car1Snapshot = await car1UploadTask.whenComplete(() => null);
      carImage1URL.value =
      await car1Snapshot.ref.getDownloadURL();
      print("car1"+carImage1URL.value);
      /////////////////////////////
      final car2UploadTask = FirebaseStorage.instance.ref('carImages/' +
          DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
          '${imageCar2.value?.split('/').last}').putFile(File(imageCar2.value));
      final car2Snapshot = await car2UploadTask.whenComplete(() => null);
      carImage2URL.value =
      await car2Snapshot.ref.getDownloadURL();
      print("car2"+carImage2URL.value);
///////////////////////////////////
      final car3UploadTask = FirebaseStorage.instance.ref('carImages/' +
          DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
          '${imageCar3.value?.split('/').last}').putFile(File(imageCar3.value));
      final car3Snapshot = await car3UploadTask.whenComplete(() => null);
      carImage3URL.value =
      await car3Snapshot.ref.getDownloadURL();
      print("car3"+carImage3URL.value);
      ///////////////////////////////////////
      final car4UploadTask = FirebaseStorage.instance.ref('carImages/' +
          DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
          '${imageCar4.value?.split('/').last}').putFile(File(imageCar4.value));
      final car4Snapshot = await car4UploadTask.whenComplete(() => null);
      carImage4URL.value =
      await car4Snapshot.ref.getDownloadURL();
      print("car4"+carImage4URL.value);
    }
    catch(e)
    {
      print(e.toString());
    }
  }
  Future<void> uploadCar1Image() async {
    try {
      final car1UploadTask = FirebaseStorage.instance.ref('carImages/' +
          DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
          '${imageCar1.value?.split('/').last}').putFile(File(imageCar1.value));
      final car1Snapshot = await car1UploadTask.whenComplete(() => null);
      carImage1URL.value =
      await car1Snapshot.ref.getDownloadURL();
      print("car1"+carImage1URL.value);
    }
    catch(e)
    {
      print(e.toString());
    }
  }
  Future<void> uploadCar2Image() async {
    try {
      final car2UploadTask = FirebaseStorage.instance.ref('carImages/' +
          DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
          '${imageCar2.value?.split('/').last}').putFile(File(imageCar2.value));
      final car2Snapshot = await car2UploadTask.whenComplete(() => null);
      carImage2URL.value =
      await car2Snapshot.ref.getDownloadURL();
      print("car2"+carImage2URL.value);

    }
    catch(e)
    {
      print(e.toString());
    }
  }
  Future<void> uploadCar3Image() async {
    try {
      final car3UploadTask = FirebaseStorage.instance.ref('carImages/' +
          DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
          '${imageCar3.value?.split('/').last}').putFile(File(imageCar3.value));
      final car3Snapshot = await car3UploadTask.whenComplete(() => null);
      carImage3URL.value =
      await car3Snapshot.ref.getDownloadURL();
      print("car3"+carImage3URL.value);

    }
    catch(e)
    {
      print(e.toString());
    }
  }
  Future<void> uploadCar4Image() async {
    try {
      final car4UploadTask = FirebaseStorage.instance.ref('carImages/' +
          DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
          '${imageCar4.value?.split('/').last}').putFile(File(imageCar4.value));
      final car4Snapshot = await car4UploadTask.whenComplete(() => null);
      carImage4URL.value =
      await car4Snapshot.ref.getDownloadURL();
      print("car4"+carImage4URL.value);

    }
    catch(e)
    {
      print(e.toString());
    }
  }

/////////////////crud opertion///////////////////////

  Future<void> fetchCourses() async {
    try {
      isLoading.value=true;
      String? orderUrl;
      QuerySnapshot courses =
      await FirebaseFirestore.instance.collection('courses').orderBy('pickUpDate', descending: true).get();
      coursesListAdmin.clear();
      coursesListDriver.clear();
      coursesAll.clear();

      for (var course in courses.docs) {
        Timestamp? dropOffDate;
        List<rowdata>? passengersDetailsFetch;
        List<checklistData>? carDetailsFetch;
        //
        // int? collie;
        // int? luggageBigSize;
        // int? luggageMediumSize;
        // int? usedCollieFetch;
        // int? usedLuggageBigSizeFetch;
        // int? usedLuggageMediumSizeFetch;
        print(course.id);
        String? carImg1Url;
        String? carImg2Url;
        String? carImg3Url;
        String? carImg4Url;

        var courseData = course.data() as Map<String, dynamic>;

        // try {
          if (courseData.containsKey('passengersDetails')) {
            List<dynamic>? passengersDetailsData = courseData['passengersDetails'];
            passengersDetailsFetch = passengersDetailsData?.map(
                  (passengerData) =>
                  rowdata(
                    firstname: passengerData['firstname'],
                    lastName: passengerData['lastName'],
                    identityNum: passengerData['identityNum'],
                    state: passengerData['state'] ?? false
                  ),
            ).toList();
          }
          if (courseData.containsKey('checkCarDetails')) {
            List<dynamic>?  carDetailsData = courseData['checkCarDetails'];
            carDetailsFetch = carDetailsData?.map(
                  (carData) =>
                      checklistData(
                    name: carData['name'],
                    state: carData['state'],
                  ),
            ).toList();
          }
          if(courseData.containsKey('dropOffDate')){
             dropOffDate = course['dropOffDate'];
          }
          if(courseData.containsKey('orderUrl')){
             orderUrl = course['orderUrl'];
          }
          else{
            orderUrl="";
          }

          if(courseData.containsKey('carImage1URL')){
            carImg1Url = course['carImage1URL'];
          }
          if(courseData.containsKey('carImage2URL')){
            carImg2Url = course['carImage2URL'];
          }
          if(courseData.containsKey('carImage3URL')){
            carImg3Url = course['carImage3URL'];
          }
          if(courseData.containsKey('carImage4URL')){
            carImg4Url = course['carImage4URL'];
          }

          // if(courseData.containsKey('collie')){
          //   collie = course['collie'];
          // }
          // if(courseData.containsKey('luggageBigSize')){
          //   luggageBigSize = course['luggageBigSize'];
          // }
          // if(courseData.containsKey('luggageMediumSize')){
          //   luggageMediumSize = course['luggageMediumSize'];
          // }
          //
          // if(courseData.containsKey('usedCollie')){
          //   usedCollieFetch = course['usedCollie'];
          // }
          // if(courseData.containsKey('usedLuggageBigSize')){
          //   usedLuggageBigSizeFetch = course['usedLuggageBigSize'];
          // }
          // if(courseData.containsKey('usedLuggageMediumSize')){
          //   usedLuggageMediumSizeFetch = course['usedLuggageMediumSize'];
          // }

          Timestamp date = course['pickUpDate'];
          if(courseData.containsKey('idAdmin')) {
            if (course['idAdmin'] == loginController.idAdmin.value) {
              coursesListAdmin.add(
                  Course(
                    check: course['check'],
                    adminId: course['idAdmin'],
                    id: course.id,
                    finished:course['finished'],
                    pickUpLocation: course['pickUpLocation'],
                    dropOffLocation: course['dropOffLocation'],
                    pickUpDate: date.toDate(),
                    passengersNum: course['passengersNum'],
                    seatingCapacity: course['seatingCapacity'],
                    regNumber: course['regNumber'],
                    driverName: course['driverName'],
                    seen: course['seen'],
                    identityNum: course['identityNum'],
                    passengersDetails: passengersDetailsFetch,
                    carListDetails: carDetailsFetch,
                    orderUrl: orderUrl,
                    dropOffDate: dropOffDate?.toDate(),
                    carImage1URL: carImg1Url,
                    carImage2URL: carImg2Url,
                    carImage3URL: carImg3Url,
                    carImage4URL: carImg4Url,
                    collie: course['collie'] ?? 0,
                    usedCollie: course['usedCollie'] ?? 0,
                    luggageBigSize: course['luggageBigSize'] ?? 0,
                    usedLuggageBigSize: course['usedLuggageBigSize'] ?? 0,
                    luggageMediumSize: course['luggageMediumSize'] ?? 0,
                    usedLuggageMediumSize: course['usedLuggageMediumSize'] ?? 0
                  )
              );
              coursesAll.add(
                  Course(
                      check: course['check'],
                      adminId: course['idAdmin'],
                      id: course.id,
                      finished:course['finished'],
                      pickUpLocation: course['pickUpLocation'],
                      dropOffLocation: course['dropOffLocation'],
                      pickUpDate: date.toDate(),
                      passengersNum: course['passengersNum'],
                      seatingCapacity: course['seatingCapacity'],
                      regNumber: course['regNumber'],
                      driverName: course['driverName'],
                      seen: course['seen'],
                      identityNum: course['identityNum'],
                      passengersDetails: passengersDetailsFetch,
                      carListDetails: carDetailsFetch,
                      orderUrl: orderUrl,
                      dropOffDate: dropOffDate?.toDate(),
                      carImage1URL: carImg1Url,
                      carImage2URL: carImg2Url,
                      carImage3URL: carImg3Url,
                      carImage4URL: carImg4Url,
                      collie: course['collie'] ?? 0,
                      usedCollie: course['usedCollie'] ?? 0,
                      luggageBigSize: course['luggageBigSize'] ?? 0,
                      usedLuggageBigSize: course['usedLuggageBigSize'] ?? 0,
                      luggageMediumSize: course['luggageMediumSize'] ?? 0,
                      usedLuggageMediumSize: course['usedLuggageMediumSize'] ?? 0
                  )
              );
            }
          }
          else if(!courseData.containsKey('idAdmin')) {
            print('/////////////////////////////////////');
            print(!courseData.containsKey('idAdmin'));
            print(course.id);
            coursesListDriver.add(
                Course(
                  check: course['check'],
                  id: course.id,
                  finished:course['finished'],
                  pickUpLocation: course['pickUpLocation'],
                  dropOffLocation: course['dropOffLocation'],
                  pickUpDate: date.toDate(),
                  passengersNum: course['passengersNum'],
                  seatingCapacity: course['seatingCapacity'],
                  regNumber: course['regNumber'],
                  driverName: course['driverName'],
                  identityNum: course['identityNum'],
                  passengersDetails: passengersDetailsFetch,
                  orderUrl: orderUrl,
                  dropOffDate: dropOffDate?.toDate(),
                  carImage1URL: carImg1Url,
                  carImage2URL: carImg2Url,
                  carImage3URL: carImg3Url,
                  carImage4URL: carImg4Url,
                  collie: course['collie'] ?? 0,
                  usedCollie: course['usedCollie'] ?? 0,
                  luggageBigSize: course['luggageBigSize'] ?? 0,
                  usedLuggageBigSize: course['usedLuggageBigSize'] ?? 0,
                  luggageMediumSize: course['luggageMediumSize'] ?? 0,
                  usedLuggageMediumSize: course['usedLuggageMediumSize'] ?? 0

                )
            );
            coursesAll.add(
                Course(
                    check: course['check'],
                    id: course.id,
                    finished:course['finished'],
                    pickUpLocation: course['pickUpLocation'],
                    dropOffLocation: course['dropOffLocation'],
                    pickUpDate: date.toDate(),
                    passengersNum: course['passengersNum'],
                    seatingCapacity: course['seatingCapacity'],
                    regNumber: course['regNumber'],
                    driverName: course['driverName'],
                    identityNum: course['identityNum'],
                    passengersDetails: passengersDetailsFetch,
                    orderUrl: orderUrl,
                    dropOffDate: dropOffDate?.toDate(),
                    carImage1URL: carImg1Url,
                    carImage2URL: carImg2Url,
                    carImage3URL: carImg3Url,
                    carImage4URL: carImg4Url,
                    collie: course['collie'] ?? 0,
                    usedCollie: course['usedCollie'] ?? 0,
                    luggageBigSize: course['luggageBigSize'] ?? 0,
                    usedLuggageBigSize: course['usedLuggageBigSize'] ?? 0,
                    luggageMediumSize: course['luggageMediumSize'] ?? 0,
                    usedLuggageMediumSize: course['usedLuggageMediumSize'] ?? 0

                )
            );
          }

        // }catch(e){
        //   print(e.toString());
        // }
      }


    filterCoursesTodayAdmin();
    filterCoursesTomorrowAdmin();
    filterCoursesOthersAdmin();

    ////////////////////////
    filterCoursesTodayDriver();
    filterCoursesTomorrowDriver();
    filterCoursesOthersDriver();

      //////////////////////////////////////
      filterCoursesTodayHistory();
      filterCoursesYesterdayHistory();
      filterCoursesOlderHistory();

      isLoading.value=false;

    } catch (e) {
      print('Error '+ e.toString());
    }
  }

  Future add_course(Course course)async{

    // courses.add({
    //   "type":d.type,
    //   "pickUpLocation":d.pickUpLocation,
    //   "dropOffLocation":d.dropOffLocation,
    //   "pickUpDate":Timestamp.fromDate(d.pickUpDate),
    //   if(d.dropOffDate!=null)"dropOffDate":Timestamp.fromDate(d.dropOffDate!),
    //   "driverName":d.driverName,
    //   "identityNum":d.identityNum,
    //   if(d.orderUrl!=null)"orderUrl":d.orderUrl,
    //   if(d.passengersNum!=null)"passengersNum":d.passengersNum,
    //   if(d.passengersDetails!=null)"passengersDetails": d.passengersDetails?.map((passenger) => passenger.toJson()).toList(),
    // });
    print(course.luggageBigSize);
    print(course.luggageMediumSize);
    print(course.collie);
    print(course.usedLuggageBigSize);
    print(course.usedLuggageBigSize);
    print(course.usedCollie);


    if (course.check == "passengers" && checkBox1.value == true) {
      courses.add({
        "seen": false,
        "finished":false,
        "pickUpLocation": course.pickUpLocation,
        "dropOffLocation": course.dropOffLocation,
        "pickUpDate": course.pickUpDate,
        if (course.dropOffDate!=null)
          "dropOffDate": course.dropOffDate,
        "driverName": course.driverName,
        "identityNum": course.identityNum,
        "passengersNum": course.passengersNum,
        "passengersDetails":
        passengerDetails.value
            ?.map((passenger) =>
            passenger.toJson())
            .toList(),
        "regNumber": course.regNumber,
        "seatingCapacity": course.seatingCapacity,
        "check": course.check,
        "idAdmin": loginController.idAdmin.value,
        "luggageBigSize":course.luggageBigSize,
        "luggageMediumSize":course.luggageMediumSize,
        "collie":course.collie,
        "usedLuggageBigSize":course.usedLuggageBigSize,
        "usedLuggageMediumSize":course.usedLuggageMediumSize,
        "usedCollie":course.usedCollie,
      }).then((value) {
        init();
        fetchCourses();
        Get.back();
      });
    }
    else if (course.check == "car" && checkBox2.value == true) {
      final orderImageURL;
      final driverUploadTask = FirebaseStorage.instance.ref('order/' +
          DateTime.now().difference(DateTime(2022, 1, 1)).inSeconds.toString() +
          '${image.value?.split('/').last}')
          .putFile(File(image.value));
      final driverSnapshot = await driverUploadTask.whenComplete(() => null);
      orderImageURL = await driverSnapshot.ref.getDownloadURL();
      if(checkList.value==false)
      {courses.add({
        "seen": false,
        "finished":false,
        "pickUpLocation": course.pickUpLocation,
        "dropOffLocation": course.dropOffLocation,
        "pickUpDate": course.pickUpDate,
        if (course.dropOffDate!=null)
          "dropOffDate": course.dropOffDate,
        "driverName": course.driverName,
        "identityNum": course.identityNum,
        "passengersNum": course.passengersNum,
        "orderUrl": orderImageURL,
        "passengersDetails":
        passengerCarDetails.value
            ?.map((passenger) =>
            passenger.toJson())
            .toList(),
        "regNumber": course.regNumber,
        "seatingCapacity": course.seatingCapacity,
        "check": course.check,
        "idAdmin": loginController.idAdmin.value,
        "luggageBigSize":course.luggageBigSize,
        "luggageMediumSize":course.luggageMediumSize,
        "collie":course.collie,
        "usedLuggageBigSize":course.usedLuggageBigSize,
        "usedLuggageMediumSize":course.usedLuggageMediumSize,
        "usedCollie":course.usedCollie,
      })
        // ({
        //   "seen": false,
        //   "finished":false,
        //   "pickUpLocation": coursesController
        //       .pickUpLocationConroller.text,
        //   "dropOffLocation": coursesController
        //       .dropOffLocationConroller.text,
        //   "pickUpDate": dateTimePickUp,
        //   "driverName": coursesController
        //       .selectedItem.value,
        //   "identityNum": coursesController
        //       .selectedItemId.value,
        //   "orderUrl": orderImageURL,
        //   "passengersNum": int.tryParse(
        //       coursesController
        //           .passagersConroller
        //           .text) ??
        //       0,
        //   "passengersDetails": coursesController
        //       .passengerCarDetails.value
        //       ?.map((passenger) =>
        //       passenger.toJson())
        //       .toList(),
        //   "regNumber": coursesController
        //       .regNumberController.text,
        //   "seatingCapacity": int.tryParse(
        //       coursesController
        //           .seatingCapacityController
        //           .text) ??
        //       0,
        //   "check": "car",
        //   "idAdmin":
        //   loginController.idAdmin.value
        // })
          .then((value) {
          init();
          fetchCourses();
          Get.back();
        });}
      else{
        await uploadCarImages();
            // .whenComplete(() {
          print("imagess url");
        print(carImage1URL.value);
            print(carImage2URL.value);
        print(carImage3URL.value);
        print(carImage4URL.value);
        courses.add({
          "seen": false,
          "finished":false,
          "pickUpLocation": course.pickUpLocation,
          "dropOffLocation": course.dropOffLocation,
          "pickUpDate": course.pickUpDate,
          if (course.dropOffDate!=null)
            "dropOffDate": course.dropOffDate,
          "passengersNum": course.passengersNum,
          "seatingCapacity": course.seatingCapacity,
          "driverName": course.driverName,
          "identityNum": course.identityNum,
          "regNumber": course.regNumber,
          "orderUrl": orderImageURL,
          "passengersDetails":
          passengerCarDetails.value
              ?.map((passenger) =>
              passenger.toJson())
              .toList(),
          "check": course.check,
          "idAdmin": loginController.idAdmin.value,
          "luggageBigSize":course.luggageBigSize,
          "luggageMediumSize":course.luggageMediumSize,
          "collie":course.collie,
          "usedLuggageBigSize":course.usedLuggageBigSize,
          "usedLuggageMediumSize":course.usedLuggageMediumSize,
          "usedCollie":course.usedCollie,
          "checkCarDetails":
          checkListTable.value
              ?.map((checklistData) =>
              checklistData.toJson())
              .toList(),
          "carImage1URL":carImage1URL.value,
          "carImage2URL":carImage2URL.value,
          "carImage3URL":carImage3URL.value,
          "carImage4URL":carImage4URL.value,
        });
        //   ({
        //   "seen": false,
        //   "finished":false,
        //   "pickUpLocation": coursesController
        //       .pickUpLocationConroller.text,
        //   "dropOffLocation": coursesController
        //       .dropOffLocationConroller.text,
        //   "pickUpDate": dateTimePickUp,
        //   "driverName": coursesController
        //       .selectedItem.value,
        //   "identityNum": coursesController
        //       .selectedItemId.value,
        //   "orderUrl": orderImageURL,
        //   "passengersNum": int.tryParse(
        //       coursesController
        //           .passagersConroller
        //           .text) ?? 0,
        //   "passengersDetails": coursesController
        //       .passengerCarDetails.value
        //       ?.map((passenger) =>
        //       passenger.toJson())
        //       .toList(),
        //   "checkCarDetails": coursesController
        //       .checkListTable.value
        //       ?.map((checklistData) =>
        //       checklistData.toJson())
        //       .toList(),
        //   "regNumber": coursesController
        //       .regNumberController.text,
        //   "seatingCapacity": int.tryParse(
        //       coursesController
        //           .seatingCapacityController
        //           .text) ??
        //       0,
        //   "check": "car",
        //   "idAdmin":
        //   loginController.idAdmin.value,
        //   "carImage1URL":coursesController.carImage1URL.value,
        //   "carImage2URL":coursesController.carImage2URL.value,
        //   "carImage3URL":coursesController.carImage3URL.value,
        //   "carImage4URL":coursesController.carImage4URL.value,
        //   "luggageBigSize":int.tryParse(coursesController.luggageBigSizeController.text) ?? 0,
        //   "usedLuggageBigSize":coursesController.usedLuggageBigSize.value,
        //   "luggageMediumSize":int.tryParse(coursesController.luggageMediumSizeController.text) ?? 0,
        //   "usedLuggageMediumSize":coursesController.usedLuggageMediumSize.value,
        //   "collie":int.tryParse(coursesController.collieController.text) ?? 0,
        //   "usedCollie":coursesController.usedCollie.value,
        // })
        // });
        //     .then((value){
        //
        // }
        // );

      }

    }

  }

  Future update_course(Course course)async{

    if (checkBox1.value == true) {
    //   print("passengers");
    //
    //   print(course.seen);
    //       print(pickUpLocationConroller.text);
    //           print(dropOffLocationConroller.text);
    //               print(course.pickUpDate);
    // if (isReturn.value == true)
    //               print(course.dropOffDate);
    //               print(int.parse(passagersConroller.text));
    //                   print(int.parse(seatingCapacityController.text));
    //                       print(selectedItem.value);
    //                           print(selectedItemId.value);
    //                               print( regNumberController.text);
    //                               print('passengers details');
    // if(passengerDetails.value.length>0)
    //   print(passengerDetails.value.length);
    // else
    //   print(course.passengersDetails?.length);
    // // ?passengerDetails.value
    // //     ?.map((passenger) =>
    // // passenger.toJson()).toList()
    // //     :course.passengersDetails
    // //     ?.map((passenger) =>
    // // passenger.toJson()).toList(),
    // if(course.adminId!=null)print(course.adminId);
    // print(course.luggageBigSize);
    // print(course.luggageMediumSize);
    // print(course.collie);
    // print(course.usedLuggageBigSize);
    // print(course.usedLuggageMediumSize);
    // print(course.usedCollie);
        courses.doc(course.id).update(
            {
              "seen": course.seen,
              "pickUpLocation":pickUpLocationConroller.text,
              "dropOffLocation": dropOffLocationConroller.text,
              "pickUpDate": course.pickUpDate,
              if (isReturn.value == true)
                "dropOffDate": course.dropOffDate,
              "passengersNum": int.tryParse(passagersConroller.text) ?? 0,
              "seatingCapacity": int.tryParse(seatingCapacityController.text) ?? 0,
              "driverName":selectedItem.value,
              "identityNum":selectedItemId.value,
              "regNumber": regNumberController.text,
              "passengersDetails":passengerDetails.value.length>0
                  ?passengerDetails.value
                  ?.map((passenger) =>
                  passenger.toJson()).toList()
                  :course.passengersDetails
                  ?.map((passenger) =>
                  passenger.toJson()).toList(),
              "check": "passengers",
              if(course.adminId!=null)"idAdmin": course.adminId,
              "luggageBigSize":course.luggageBigSize,
              "luggageMediumSize":course.luggageMediumSize,
              "collie":course.collie,
              "usedLuggageBigSize":course.usedLuggageBigSize,
              "usedLuggageMediumSize":course.usedLuggageMediumSize,
              "usedCollie":course.usedCollie,
            }
        ).then((value) {
          init();
          fetchCourses();
          Get.back();
        });
    }
    else
    if (checkBox2.value == true) {
      print(course.orderUrl);
      if (image.value != "") {
        try{
          await uploadOrderImage();
          FirebaseStorage.instance.refFromURL(course.orderUrl!).delete();
        }catch(e){
          print(e.toString());
        }
      }
      if(imageCar1.value != ""){
        try{
          await uploadCar1Image();
          FirebaseStorage.instance.refFromURL(course.carImage1URL!).delete();
        }catch(e){
          print(e.toString());
        }
      }
      if(imageCar2.value != ""){
        try{
          await uploadCar2Image();
          FirebaseStorage.instance.refFromURL(course.carImage2URL!).delete();
        }catch(e){
          print(e.toString());
        }
      }
      if(imageCar3.value != "") {
        try{
          await uploadCar3Image();
          FirebaseStorage.instance.refFromURL(course.carImage3URL!).delete();
        }catch(e){
          print(e.toString());
        }
      }
      if(imageCar4.value != "") {
        try{
          await uploadCar4Image();
              // .then(
              //     (value) {
              //   print(course.seen);
              //   print(pickUpLocationConroller.text);
              //   print(dropOffLocationConroller.text);
              //   print(course.pickUpDate);
              //   if (isReturn.value == true)
              //     print(course.dropOffDate);
              //   print(int.parse(passagersConroller.text));
              //   print(int.tryParse(seatingCapacityController.text));
              //   print(selectedItem.value);
              //   print(selectedItemId.value);
              //   print(regNumberController.text);
              //   if (image.value == "")
              //     print(course.orderUrl);
              //   else
              //     print(orderImageURL.value);
              //   if (passengerCarDetails.value.length > 0)
              //     print(passengerCarDetails);
              //   else
              //     print(course.passengersDetails?.length);
              //   // passengerCarDetails.value
              //   //     ?.map((passenger) =>
              //   // passenger.toJson()).toList()
              //   //     :course.passengersDetails
              //   //     ?.map((passenger) =>
              //   // passenger.toJson()).toList(),
              //   print("car");
              //   if (course.adminId != null) print(course.adminId);
              //   print(course.luggageBigSize);
              //   print(course.luggageMediumSize);
              //   print(course.collie);
              //   print(course.usedLuggageBigSize);
              //   print(course.usedLuggageMediumSize);
              //   print(course.usedCollie);
              //
              //   if (carImage1URL.value == "")
              //     print(course.carImage1URL);
              //   else
              //     print(carImage1URL.value);
              //
              //   if (carImage2URL.value == "")
              //     print(course.carImage2URL);
              //   else
              //     print(carImage2URL.value);
              //
              //   if (carImage3URL.value == "")
              //     print(course.carImage3URL);
              //   else
              //     print(carImage3URL.value);
              //
              //   if (carImage4URL.value == "")
              //     print(course.carImage4URL);
              //   else
              //     print(carImage4URL.value);
              // });
          FirebaseStorage.instance.refFromURL(course.carImage4URL!).delete();
        }catch(e){
          print(e.toString());
        }
      }

          courses.doc(course.id).update(
              {
                "seen": course.seen,
                "pickUpLocation":pickUpLocationConroller.text,
                "dropOffLocation": dropOffLocationConroller.text,
                "pickUpDate": course.pickUpDate,
                if (isReturn.value == true)
                  "dropOffDate": course.dropOffDate,
                "passengersNum": int.tryParse(passagersConroller.text) ?? 0,
                "seatingCapacity": int.tryParse(seatingCapacityController.text) ?? 0,
                "driverName":selectedItem.value,
                "identityNum":selectedItemId.value,
                "regNumber": regNumberController.text,
                "orderUrl" : image.value ==""
                ? course.orderUrl
                :orderImageURL.value,
                "passengersDetails": passengerCarDetails.value.length>0
                ?passengerCarDetails.value
                    ?.map((passenger) =>
                    passenger.toJson()).toList()
                :course.passengersDetails
                    ?.map((passenger) =>
                    passenger.toJson()).toList(),
                "check": "car",
                if(course.adminId!=null)"idAdmin": course.adminId,
                "luggageBigSize":course.luggageBigSize,
                "luggageMediumSize":course.luggageMediumSize,
                "collie":course.collie,
                "usedLuggageBigSize":course.usedLuggageBigSize,
                "usedLuggageMediumSize":course.usedLuggageMediumSize,
                "usedCollie":course.usedCollie,
                "checkCarDetails":
                checkListTable.value
                    ?.map((checklistData) =>
                    checklistData.toJson())
                    .toList(),
                "carImage1URL":
                carImage1URL.value==""
                ?course.carImage1URL
                :carImage1URL.value,
                "carImage2URL":carImage2URL.value==""
                    ?course.carImage2URL
                    :carImage2URL.value,
                "carImage3URL":carImage3URL.value==""
                    ?course.carImage3URL
                    :carImage3URL.value,
                "carImage4URL":carImage4URL.value==""
                    ?course.carImage4URL
                    :carImage4URL.value,
              }
          ).then((value) {
            init();
            fetchCourses();
            Get.back();
          });
    }
  }

  Future delete_course(Course course)async{

    if(course.orderUrl!=null)
      FirebaseStorage.instance.refFromURL(course.orderUrl!).delete();

    if(course.carImage1URL!=null)
      FirebaseStorage.instance.refFromURL(course.carImage1URL!).delete();

    if(course.carImage2URL!=null)
      FirebaseStorage.instance.refFromURL(course.carImage2URL!).delete();

    if(course.carImage3URL!=null)
      FirebaseStorage.instance.refFromURL(course.carImage3URL!).delete();

    if(course.carImage4URL!=null)
      FirebaseStorage.instance.refFromURL(course.carImage4URL!).delete();


    await courses.doc(course.id).delete();
  }
  ///////////////admin/////////////////////////
  void filterCoursesTodayAdmin() {
    coursesListToday.assignAll(coursesListAdmin.where((course) =>
    course.pickUpDate.year == DateTime.now().year
    && course.pickUpDate.month == DateTime.now().month
    && course.pickUpDate.day == DateTime.now().day
        &&course.finished==false
    ));
  }
  void filterCoursesTomorrowAdmin() {
    coursesListTomorrow.assignAll(coursesListAdmin.where((course) =>
    course.pickUpDate.year == DateTime.now().add(Duration(days: 1)).year
    && course.pickUpDate.month == DateTime.now().add(Duration(days: 1)).month
    && course.pickUpDate.day == DateTime.now().add(Duration(days: 1)).day
    ));
  }
  void filterCoursesOthersAdmin() {
    coursesList.assignAll(coursesListAdmin.where((course) =>
    course.pickUpDate.year >= DateTime.now().add(Duration(days: 1)).year
        && course.pickUpDate.month >= DateTime.now().add(Duration(days: 1)).month
        && course.pickUpDate.day > DateTime.now().add(Duration(days: 1)).day
    ));
  }
///////////////////driver///////////////////////////
  void filterCoursesTodayDriver() {
    coursesListTodayDrivers.assignAll(coursesListDriver.where((course) =>
    course.pickUpDate.year == DateTime.now().year
        && course.pickUpDate.month == DateTime.now().month
        && course.pickUpDate.day == DateTime.now().day
    ));
  }
  void filterCoursesTomorrowDriver() {
    coursesListTomorrowDrivers.assignAll(coursesListDriver.where((course) =>
    course.pickUpDate.year == DateTime.now().add(Duration(days: 1)).year
        && course.pickUpDate.month == DateTime.now().add(Duration(days: 1)).month
        && course.pickUpDate.day == DateTime.now().add(Duration(days: 1)).day
    ));
  }
  void filterCoursesOthersDriver() {
    coursesListDrivers.assignAll(coursesListDriver.where((course) =>
    course.pickUpDate.year >= DateTime.now().add(Duration(days: 1)).year
        && course.pickUpDate.month >= DateTime.now().add(Duration(days: 1)).month
        && course.pickUpDate.day > DateTime.now().add(Duration(days: 1)).day
    ));
  }
/////////////////history/////////////////////////////
  void filterCoursesTodayHistory() {
    coursesListTodayHistory.assignAll(coursesAll.where((course) =>
    course.pickUpDate.year == DateTime.now().year
        && course.pickUpDate.month == DateTime.now().month
        && course.pickUpDate.day == DateTime.now().day
    ));

  }
  void filterCoursesYesterdayHistory() {
    coursesListYesterDayHistory.assignAll(coursesAll.where((course) =>
    course.pickUpDate.year == DateTime.now().add(Duration(days: -1)).year
        && course.pickUpDate.month == DateTime.now().add(Duration(days: -1)).month
        && course.pickUpDate.day == DateTime.now().add(Duration(days: -1)).day
    ));

  }
  void filterCoursesOlderHistory() {
    coursesListOlderHistory.assignAll(coursesAll.where((course) =>
    course.pickUpDate.year <= DateTime.now().add(Duration(days: -1)).year
        && course.pickUpDate.month <= DateTime.now().add(Duration(days: -1)).month
        && course.pickUpDate.day < DateTime.now().add(Duration(days: -1)).day
    ));

  }
//////////////////////////////////////////////
  void filter(String prefix){
    /////////////////admin//////////////////////////
    coursesListToday.assignAll(coursesListAdmin.where((course) =>
    course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
        && course.pickUpDate.year == DateTime.now().year
        && course.pickUpDate.month == DateTime.now().month
        && course.pickUpDate.day == DateTime.now().day
    ));
    coursesListTomorrow.assignAll(coursesListAdmin.where((course) =>
    course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
        && course.pickUpDate.year == DateTime.now().add(Duration(days: 1)).year
        && course.pickUpDate.month == DateTime.now().add(Duration(days: 1)).month
        && course.pickUpDate.day == DateTime.now().add(Duration(days: 1)).day
    ));

    coursesList.assignAll(coursesListAdmin.where((course) =>
    course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
        && !coursesListToday.contains(course)
        && !coursesListTomorrow.contains(course)
    ));

    /////////////////driver//////////////////////////

    coursesListTodayDrivers.assignAll(coursesListDriver.where((course) =>
    course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
        && course.pickUpDate.year == DateTime.now().year
        && course.pickUpDate.month == DateTime.now().month
        && course.pickUpDate.day == DateTime.now().day
    ));
    coursesListTomorrowDrivers.assignAll(coursesListDriver.where((course) =>
    course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
        && course.pickUpDate.year == DateTime.now().add(Duration(days: 1)).year
        && course.pickUpDate.month == DateTime.now().add(Duration(days: 1)).month
        && course.pickUpDate.day == DateTime.now().add(Duration(days: 1)).day
    ));

    coursesListDrivers.assignAll(coursesListDriver.where((course) =>
    course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
        && !coursesListToday.contains(course)
        && !coursesListTomorrow.contains(course)
    ));
    /////////////////history////////////////////////////
    coursesListTodayHistory.assignAll(coursesAll.where((course) =>
    course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
        &&course.pickUpDate.year == DateTime.now().year
        && course.pickUpDate.month == DateTime.now().month
        && course.pickUpDate.day == DateTime.now().day
    ));
    coursesListYesterDayHistory.assignAll(coursesAll.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
        &&course.pickUpDate.year == DateTime.now().add(Duration(days: -1)).year
        && course.pickUpDate.month == DateTime.now().add(Duration(days: -1)).month
        && course.pickUpDate.day == DateTime.now().add(Duration(days: -1)).day
    ));
    coursesListOlderHistory.assignAll(coursesAll.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase())
        &&course.pickUpDate.year <= DateTime.now().add(Duration(days: -1)).year
        && course.pickUpDate.month <= DateTime.now().add(Duration(days: -1)).month
        && course.pickUpDate.day < DateTime.now().add(Duration(days: -1)).day
    ));

  }
///////////////////////////pick excel for car/////////////////////////////////////////
  RxList<rowdata> passengerCarDetails =RxList<rowdata>([]);

  String? file;
  Future importFromExcel() async {

    passengerCarDetails =RxList<rowdata>([]);

    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    file = pickedFile?.files.single.path;
    var bytes = File(file!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    var isFirstRow = true;
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (isFirstRow) {
          isFirstRow = false;
          continue;
        }

        passengerCarDetails.add(
              rowdata(
                firstname: row[0]?.value ?? "",
                lastName: row[1]?.value ?? "",
                identityNum: row[2]?.value.toString() ?? "",
                // state:row[3]?.value ??false
                state:false
              )
          );
      }
    }
    passengerCarDetails.length;
  }
////////////////////////////////////////////////////////////////////
///////////////////////////pick excel for bus/////////////////////////////////////////
  RxList<rowdata> passengerDetails =RxList<rowdata>([]);

  String? filePassenger;
  Future importFromExcelForPassenger() async {

    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    file = pickedFile?.files.single.path;
    var bytes = File(file!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    var isFirstRow = true;
    passengerDetails =RxList<rowdata>([]);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (isFirstRow) {
          isFirstRow = false;
          continue;
        }
        passengerDetails.add(
            rowdata(
              firstname: row[0]?.value ?? "",
              lastName: row[1]?.value ?? "",
              identityNum: row[2]?.value.toString() ?? "",
              // state:row[3]?.value ?? false
               state:false
            )
        );
      }
    }
    passengerDetails.length;
  }


}

class rowdata {
  final String firstname;
  final String lastName;
  final String identityNum;
  final bool state;

  rowdata(
      {required this.firstname, required this.lastName, required this.identityNum,required this.state});

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastName': lastName,
      'identityNum': identityNum,
      "state":state
    };
  }
}

class checklistData{
  final String name;
  final bool state;

  checklistData({required this.name, required this.state});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'state': state,
    };
  }
}