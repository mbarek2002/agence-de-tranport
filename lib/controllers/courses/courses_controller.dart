import 'dart:io';
import 'package:admin_citygo/models/checkListData.dart';
import 'package:admin_citygo/models/rowData.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_excel/excel.dart';
import 'package:get/get.dart';

class CoursesController extends GetxController {
  TextEditingController pickUpLocationConroller = TextEditingController();
  TextEditingController dropOffLocationConroller = TextEditingController();
  TextEditingController pickUpDateConroller = TextEditingController();
  TextEditingController passagersConroller = TextEditingController();
  TextEditingController luggageConroller = TextEditingController();
  TextEditingController regNumberController = TextEditingController();
  TextEditingController seatingCapacityController = TextEditingController();
  TextEditingController luggageBigSizeController = TextEditingController();
  TextEditingController luggageMediumSizeController = TextEditingController();
  TextEditingController collieController = TextEditingController();
  ///////////////////
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController collieNumberController = TextEditingController();
  TextEditingController passengersNumberController = TextEditingController();
  bool newPassState = false;
  ///////////////////


  CollectionReference courses =
      FirebaseFirestore.instance.collection("courses");

  LoginController loginController = Get.put(LoginController());

  RxInt formNum = 1.obs;

  RxString selectedItem = 'Driver name'.obs;

  RxInt selectedItemId = RxInt(0);

  final formKey = GlobalKey<FormState>();

  RxBool validLicenceType = false.obs;

  RxString image = ''.obs;
  RxString imageCar1 = ''.obs;
  RxString imageCar2 = ''.obs;
  RxString imageCar3 = ''.obs;
  RxString imageCar4 = ''.obs;

  RxBool? state ;

  Rx<Course> course1 = Course(
          pickUpLocation: "",
          dropOffLocation: "",
          pickUpDate: DateTime.now(),
          passengersNum: 0,
          seatingCapacity: 0,
          regNumber: "0",
          driverName: "",
          check: "",
          identityNum: 0)
      .obs;

  RxBool isChecked = true.obs;
  RxBool isLoading = false.obs;

  RxBool isReturn = false.obs;
  RxBool checkBox1 = false.obs;
  RxBool checkBox2 = false.obs;

  RxInt usedLuggageBigSize = 0.obs;
  RxInt usedLuggageMediumSize = 0.obs;
  RxInt usedCollie = 0.obs;

  var carImage1URL = "".obs;
  var carImage2URL = "".obs;
  var carImage3URL = "".obs;
  var carImage4URL = "".obs;

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
    image.value = '';
    selectedItem.value = 'Driver name';
    validLicenceType.value = false;
    passengerCarDetails = RxList<rowdata>([]);
    passengerDetails = RxList<rowdata>([]);
    checkListTable = RxList<checklistData>([]);

    isReturn.value = false;
    checkBox1.value = false;
    checkBox2.value = false;

    usedLuggageBigSize.value = 0;
    usedLuggageMediumSize.value = 0;
    usedCollie.value = 0;

    image.value = "";
    imageCar1.value = "";
    imageCar2.value = "";
    imageCar3.value = "";
    imageCar4.value = "";

    carImage1URL.value = "";
    carImage2URL.value = "";
    carImage3URL.value = "";
    carImage4URL.value = "";

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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'png', 'jpg']);

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
  var orderImageURL = "".obs;

  Future<void> uploadOrderImage() async {
    final driverUploadTask = FirebaseStorage.instance
        .ref('order/' +
            DateTime.now()
                .difference(DateTime(2022, 1, 1))
                .inSeconds
                .toString() +
            '${image.value?.split('/').last}')
        .putFile(File(image.value));
    final driverSnapshot = await driverUploadTask.whenComplete(() => null);
    orderImageURL.value = await driverSnapshot.ref.getDownloadURL();
  }

  Future<void> uploadCarImages() async {
    try {
      /////////
      final car1UploadTask = FirebaseStorage.instance
          .ref('carImages/' +
              DateTime.now()
                  .difference(DateTime(2022, 1, 1))
                  .inSeconds
                  .toString() +
              '${imageCar1.value?.split('/').last}')
          .putFile(File(imageCar1.value));
      final car1Snapshot = await car1UploadTask.whenComplete(() => null);
      carImage1URL.value = await car1Snapshot.ref.getDownloadURL();
      print("car1" + carImage1URL.value);
      /////////////////////////////
      final car2UploadTask = FirebaseStorage.instance
          .ref('carImages/' +
              DateTime.now()
                  .difference(DateTime(2022, 1, 1))
                  .inSeconds
                  .toString() +
              '${imageCar2.value?.split('/').last}')
          .putFile(File(imageCar2.value));
      final car2Snapshot = await car2UploadTask.whenComplete(() => null);
      carImage2URL.value = await car2Snapshot.ref.getDownloadURL();
      print("car2" + carImage2URL.value);
///////////////////////////////////
      final car3UploadTask = FirebaseStorage.instance
          .ref('carImages/' +
              DateTime.now()
                  .difference(DateTime(2022, 1, 1))
                  .inSeconds
                  .toString() +
              '${imageCar3.value?.split('/').last}')
          .putFile(File(imageCar3.value));
      final car3Snapshot = await car3UploadTask.whenComplete(() => null);
      carImage3URL.value = await car3Snapshot.ref.getDownloadURL();
      print("car3" + carImage3URL.value);
      ///////////////////////////////////////
      final car4UploadTask = FirebaseStorage.instance
          .ref('carImages/' +
              DateTime.now()
                  .difference(DateTime(2022, 1, 1))
                  .inSeconds
                  .toString() +
              '${imageCar4.value?.split('/').last}')
          .putFile(File(imageCar4.value));
      final car4Snapshot = await car4UploadTask.whenComplete(() => null);
      carImage4URL.value = await car4Snapshot.ref.getDownloadURL();
      print("car4" + carImage4URL.value);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> uploadCar1Image() async {
    try {
      final car1UploadTask = FirebaseStorage.instance
          .ref('carImages/' +
              DateTime.now()
                  .difference(DateTime(2022, 1, 1))
                  .inSeconds
                  .toString() +
              '${imageCar1.value?.split('/').last}')
          .putFile(File(imageCar1.value));
      final car1Snapshot = await car1UploadTask.whenComplete(() => null);
      carImage1URL.value = await car1Snapshot.ref.getDownloadURL();
      print("car1" + carImage1URL.value);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> uploadCar2Image() async {
    try {
      final car2UploadTask = FirebaseStorage.instance
          .ref('carImages/' +
              DateTime.now()
                  .difference(DateTime(2022, 1, 1))
                  .inSeconds
                  .toString() +
              '${imageCar2.value?.split('/').last}')
          .putFile(File(imageCar2.value));
      final car2Snapshot = await car2UploadTask.whenComplete(() => null);
      carImage2URL.value = await car2Snapshot.ref.getDownloadURL();
      print("car2" + carImage2URL.value);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> uploadCar3Image() async {
    try {
      final car3UploadTask = FirebaseStorage.instance
          .ref('carImages/' +
              DateTime.now()
                  .difference(DateTime(2022, 1, 1))
                  .inSeconds
                  .toString() +
              '${imageCar3.value?.split('/').last}')
          .putFile(File(imageCar3.value));
      final car3Snapshot = await car3UploadTask.whenComplete(() => null);
      carImage3URL.value = await car3Snapshot.ref.getDownloadURL();
      print("car3" + carImage3URL.value);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> uploadCar4Image() async {
    try {
      final car4UploadTask = FirebaseStorage.instance
          .ref('carImages/' +
              DateTime.now()
                  .difference(DateTime(2022, 1, 1))
                  .inSeconds
                  .toString() +
              '${imageCar4.value?.split('/').last}')
          .putFile(File(imageCar4.value));
      final car4Snapshot = await car4UploadTask.whenComplete(() => null);
      carImage4URL.value = await car4Snapshot.ref.getDownloadURL();
      print("car4" + carImage4URL.value);
    } catch (e) {
      print(e.toString());
    }
  }

/////////////////crud opertion///////////////////////

  Future<void> fetchCourses() async {
    // try {
    isLoading.value = true;
    String? orderUrl;
    QuerySnapshot courses = await FirebaseFirestore.instance
        .collection('courses')
        .orderBy('pickUpDate', descending: true)
        .get();
    coursesListAdmin.clear();
    coursesListDriver.clear();
    coursesAll.clear();

    for (var course in courses.docs) {
      print(course.id);

      Timestamp? dropOffDate;
      List<rowdata>? passengersDetailsFetch;
      List<checklistData>? carDetailsFetch = <checklistData>[];
      String? carImg1Url;
      String? carImg2Url;
      String? carImg3Url;
      String? carImg4Url;

      var courseData = course.data() as Map<String, dynamic>;

      // try {
      if (courseData.containsKey('passengersDetails')) {
        List<dynamic>? passengersDetailsData = courseData['passengersDetails'];
        passengersDetailsFetch = passengersDetailsData
            ?.map(
              (passengerData) => rowdata(
                  firstname: passengerData['firstname'],
                  lastName: passengerData['lastName'],
                  phoneNum: passengerData['phoneNum'],
                  state: passengerData['state'] ?? false,
                  collieNumber: passengerData['collieNumber'] ??1,
                passengersNumber: passengerData['passengersNumber']??1
              ),
            )
            .toList();
      }
      if (courseData.containsKey('checkCarDetails')) {
        List<dynamic>? carDetailsData = courseData['checkCarDetails'];
        carDetailsFetch = carDetailsData
            ?.map(
              (carData) => checklistData(
                name: carData['name'],
                state: carData['state'],
              ),
            )
            .toList();
      }
      if (courseData.containsKey('dropOffDate')) {
        dropOffDate = course['dropOffDate'];
      }
      if (courseData.containsKey('orderUrl')) {
        orderUrl = course['orderUrl'];
      } else {
        orderUrl = "";
      }

      if (courseData.containsKey('carImage1URL')) {
        carImg1Url = course['carImage1URL'];
      }
      if (courseData.containsKey('carImage2URL')) {
        carImg2Url = course['carImage2URL'];
      }
      if (courseData.containsKey('carImage3URL')) {
        carImg3Url = course['carImage3URL'];
      }
      if (courseData.containsKey('carImage4URL')) {
        carImg4Url = course['carImage4URL'];
      }

      Timestamp date = course['pickUpDate'];


      print(date.toDate().day.toString()+"/"+date.toDate().month.toString()+"/"+date.toDate().year.toString()+"/");
      // print(
          // date.toDate().day.toString()+"/"+date.toDate().month.toString()+"/"+date.toDate().year.toString()+"/");


      print(date.toDate().year >= DateTime.now().add(Duration(days: 1)).year);
      print(date.toDate().month >= DateTime.now().add(Duration(days: 1)).month );
      print(date.toDate().day > DateTime.now().add(Duration(days: 1)).day);

      if (courseData.containsKey('idAdmin')) {
        if (course['idAdmin'] == loginController.idAdmin.value) {
          coursesListAdmin.add(Course(
            check: course['check'],
            adminId: course['idAdmin'],
            id: course.id,
            finished: course['finished'],
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
            // luggageBigSize: course['luggageBigSize'] ?? 0,
            // usedLuggageBigSize: course['usedLuggageBigSize'] ?? 0,
            // luggageMediumSize: course['luggageMediumSize'] ?? 0,
            // usedLuggageMediumSize: course['usedLuggageMediumSize'] ?? 0
          ));
          coursesAll.add(Course(
            check: course['check'],
            adminId: course['idAdmin'],
            id: course.id,
            finished: course['finished'],
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
            // luggageBigSize: course['luggageBigSize'] ?? 0,
            // usedLuggageBigSize: course['usedLuggageBigSize'] ?? 0,
            // luggageMediumSize: course['luggageMediumSize'] ?? 0,
            // usedLuggageMediumSize: course['usedLuggageMediumSize'] ?? 0
          ));
        }
      }
      else if (!courseData.containsKey('idAdmin')) {
        coursesListDriver.add(Course(
          check: course['check'],
          id: course.id,
          finished: course['finished'],
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
          // luggageBigSize: course['luggageBigSize'] ?? 0,
          // usedLuggageBigSize: course['usedLuggageBigSize'] ?? 0,
          // luggageMediumSize: course['luggageMediumSize'] ?? 0,
          // usedLuggageMediumSize: course['usedLuggageMediumSize'] ?? 0
        ));
        coursesAll.add(Course(
          check: course['check'],
          id: course.id,
          finished: course['finished'],
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
          // luggageBigSize: course['luggageBigSize'] ?? 0,
          // usedLuggageBigSize: course['usedLuggageBigSize'] ?? 0,
          // luggageMediumSize: course['luggageMediumSize'] ?? 0,
          // usedLuggageMediumSize: course['usedLuggageMediumSize'] ?? 0
        ));
      }
      //
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

    isLoading.value = false;

    // } catch (e) {
    //   print('Error '+ e.toString());
    // }
  }

  Future add_course(Course course) async {
    if (course.check == "passengers" && checkBox1.value == true) {
      courses.add({
        "seen": false,
        "finished": false,
        "pickUpLocation": course.pickUpLocation,
        "dropOffLocation": course.dropOffLocation,
        "pickUpDate": course.pickUpDate,
        if (course.dropOffDate != null) "dropOffDate": course.dropOffDate,
        "driverName": course.driverName,
        "identityNum": course.identityNum,
        "passengersNum": course.passengersNum,
        "passengersDetails": passengerDetails.value
            ?.map((passenger) => passenger.toJson())
            .toList(),
        "regNumber": course.regNumber,
        "seatingCapacity": course.seatingCapacity,
        "check": course.check,
        "idAdmin": loginController.idAdmin.value,
        // "luggageBigSize":course.luggageBigSize,
        // "luggageMediumSize":course.luggageMediumSize,
        "collie": course.collie,
        // "usedLuggageBigSize":course.usedLuggageBigSize,
        // "usedLuggageMediumSize":course.usedLuggageMediumSize,
        "usedCollie": course.usedCollie,
      }).then((value) {
        init();
        fetchCourses();
        Get.back();
      });
    } else if (course.check == "car" && checkBox2.value == true) {
      final orderImageURL;
      final driverUploadTask = FirebaseStorage.instance
          .ref('order/' +
              DateTime.now()
                  .difference(DateTime(2022, 1, 1))
                  .inSeconds
                  .toString() +
              '${image.value?.split('/').last}')
          .putFile(File(image.value));
      final driverSnapshot = await driverUploadTask.whenComplete(() => null);
      orderImageURL = await driverSnapshot.ref.getDownloadURL();
      if (checkList.value == false) {
        courses.add({
          "seen": false,
          "finished": false,
          "pickUpLocation": course.pickUpLocation,
          "dropOffLocation": course.dropOffLocation,
          "pickUpDate": course.pickUpDate,
          if (course.dropOffDate != null) "dropOffDate": course.dropOffDate,
          "driverName": course.driverName,
          "identityNum": course.identityNum,
          "passengersNum": course.passengersNum,
          "orderUrl": orderImageURL,
          "passengersDetails": passengerCarDetails.value
              ?.map((passenger) => passenger.toJson())
              .toList(),
          "regNumber": course.regNumber,
          "seatingCapacity": course.seatingCapacity,
          "check": course.check,
          "idAdmin": loginController.idAdmin.value,
          // "luggageBigSize":course.luggageBigSize,
          // "luggageMediumSize":course.luggageMediumSize,
          "collie": course.collie,
          // "usedLuggageBigSize":course.usedLuggageBigSize,
          // "usedLuggageMediumSize":course.usedLuggageMediumSize,
          "usedCollie": course.usedCollie,
        }).then((value) {
          init();
          fetchCourses();
          Get.back();
        });
      } else {
        await uploadCarImages();
        // .whenComplete(() {
        print("imagess url");
        print(carImage1URL.value);
        print(carImage2URL.value);
        print(carImage3URL.value);
        print(carImage4URL.value);
        courses.add({
          "seen": false,
          "finished": false,
          "pickUpLocation": course.pickUpLocation,
          "dropOffLocation": course.dropOffLocation,
          "pickUpDate": course.pickUpDate,
          if (course.dropOffDate != null) "dropOffDate": course.dropOffDate,
          "passengersNum": course.passengersNum,
          "seatingCapacity": course.seatingCapacity,
          "driverName": course.driverName,
          "identityNum": course.identityNum,
          "regNumber": course.regNumber,
          "orderUrl": orderImageURL,
          "passengersDetails": passengerCarDetails.value
              ?.map((passenger) => passenger.toJson())
              .toList(),
          "check": course.check,
          "idAdmin": loginController.idAdmin.value,
          // "luggageBigSize":course.luggageBigSize,
          // "luggageMediumSize":course.luggageMediumSize,
          "collie": course.collie,
          // "usedLuggageBigSize":course.usedLuggageBigSize,
          // "usedLuggageMediumSize":course.usedLuggageMediumSize,
          "usedCollie": course.usedCollie,
          "checkCarDetails": checkListTable.value
              ?.map((checklistData) => checklistData.toJson())
              .toList(),
          "carImage1URL": carImage1URL.value,
          "carImage2URL": carImage2URL.value,
          "carImage3URL": carImage3URL.value,
          "carImage4URL": carImage4URL.value,
        });
      }
    } else {
      print(course.check);
      courses.add({
        "seen": false,
        "finished": false,
        "pickUpLocation": course.pickUpLocation,
        "dropOffLocation": course.dropOffLocation,
        "pickUpDate": course.pickUpDate,
        if (course.dropOffDate != null) "dropOffDate": course.dropOffDate,
        "driverName": course.driverName,
        "identityNum": course.identityNum,
        "passengersNum": course.passengersNum,
        "regNumber": course.regNumber,
        "seatingCapacity": course.seatingCapacity,
        "check": course.check,
        "idAdmin": loginController.idAdmin.value,
        "collie": course.collie,
        "usedCollie": course.usedCollie,
      }).then((value) {
        init();
        fetchCourses();
        Get.back();
      });
    }
  }

  Future update_course(Course course) async {
    if (checkBox1.value == true) {
      if(course.orderUrl !=null && course.orderUrl!.isNotEmpty){
        FirebaseStorage.instance.refFromURL(course.orderUrl!).delete();
      }
      if(course.carImage1URL !=null && course.carImage1URL!.isNotEmpty){
        FirebaseStorage.instance.refFromURL(course.carImage1URL!).delete();
      }
      if(course.carImage2URL !=null && course.carImage2URL!.isNotEmpty){
        FirebaseStorage.instance.refFromURL(course.carImage2URL!).delete();
      }
      if(course.carImage3URL !=null && course.carImage3URL!.isNotEmpty){
        FirebaseStorage.instance.refFromURL(course.carImage3URL!).delete();
      }
      if(course.carImage4URL !=null && course.carImage4URL!.isNotEmpty ){
        FirebaseStorage.instance.refFromURL(course.carImage4URL!).delete();
      }

      courses.doc(course.id).set({
        "seen": course.seen,
        "finished": course.finished,
        "pickUpLocation": pickUpLocationConroller.text,
        "dropOffLocation": dropOffLocationConroller.text,
        "pickUpDate": course.pickUpDate,
        "dropOffDate": isReturn.value == true ? course.dropOffDate : null,
        "passengersNum": int.tryParse(passagersConroller.text) ?? 0,
        "seatingCapacity": int.tryParse(seatingCapacityController.text) ?? 0,
        "driverName": selectedItem.value,
        "identityNum": selectedItemId.value,
        "regNumber": regNumberController.text,
        if( passengerDetails.value.length > 0)"passengersDetails":
        passengerDetails.value
            ?.map((passenger) => passenger.toJson())
            .toList()
        else if( course.passengersDetails !=null)"passengersDetails": course.passengersDetails
            ?.map((passenger) => passenger.toJson())
            .toList(),
        "check": "passengers",
        if (course.adminId != null) "idAdmin": course.adminId,
        // "luggageBigSize":course.luggageBigSize,
        // "luggageMediumSize":course.luggageMediumSize,
        "collie": course.collie,
        // "usedLuggageBigSize":course.usedLuggageBigSize,
        // "usedLuggageMediumSize":course.usedLuggageMediumSize,
        "usedCollie": course.usedCollie,
      }).then((value) {
        init();
        fetchCourses();
        Get.back();
      });
    }
    else if (checkBox2.value == true) {
      if (image.value != "") {
        try {
          await uploadOrderImage();
          FirebaseStorage.instance.refFromURL(course.orderUrl!).delete();
        } catch (e) {
          print(e.toString());
        }
      }
      if (imageCar1.value != "") {
        try {
          await uploadCar1Image();
          FirebaseStorage.instance.refFromURL(course.carImage1URL!).delete();
        } catch (e) {
          print(e.toString());
        }
      }
      if (imageCar2.value != "") {
        try {
          await uploadCar2Image();
          FirebaseStorage.instance.refFromURL(course.carImage2URL!).delete();
        } catch (e) {
          print(e.toString());
        }
      }
      if (imageCar3.value != "") {
        try {
          await uploadCar3Image();
          FirebaseStorage.instance.refFromURL(course.carImage3URL!).delete();
        } catch (e) {
          print(e.toString());
        }
      }
      if (imageCar4.value != "") {
        try {
          await uploadCar4Image();
          FirebaseStorage.instance.refFromURL(course.carImage4URL!).delete();
        } catch (e) {
          print(e.toString());
        }
      }

      courses.doc(course.id).set({
        "seen": course.seen,
        "finished": course.finished,
        "pickUpLocation": pickUpLocationConroller.text,
        "dropOffLocation": dropOffLocationConroller.text,
        "pickUpDate": course.pickUpDate,
        "dropOffDate": isReturn.value == true ? course.dropOffDate : null,
        "passengersNum": int.tryParse(passagersConroller.text) ?? 0,
        "seatingCapacity": int.tryParse(seatingCapacityController.text) ?? 0,
        "driverName": selectedItem.value,
        "identityNum": selectedItemId.value,
        "regNumber": regNumberController.text,
        "orderUrl": image.value == "" ? course.orderUrl : orderImageURL.value,

        if( passengerCarDetails.value.length > 0)"passengersDetails":
             passengerCarDetails.value
                ?.map((passenger) => passenger.toJson())
                .toList()
            else if( course.passengersDetails !=null)"passengersDetails": course.passengersDetails
                ?.map((passenger) => passenger.toJson())
                .toList(),
        "check": "car",
        if (course.adminId != null) "idAdmin": course.adminId,
        // "luggageBigSize":course.luggageBigSize,
        // "luggageMediumSize":course.luggageMediumSize,
        "collie": course.collie,
        // "usedLuggageBigSize":course.usedLuggageBigSize,
        // "usedLuggageMediumSize":course.usedLuggageMediumSize,
        "usedCollie": course.usedCollie,
        "checkCarDetails": checkListTable.value
            ?.map((checklistData) => checklistData.toJson())
            .toList(),
        // if(course.carImage1URL!= null || carImage1URL.value != null)
        "carImage1URL":
            carImage1URL.value == "" ? course.carImage1URL : carImage1URL.value,
        // if(course.carImage2URL!= null || carImage2URL.value != null)
        "carImage2URL":
            carImage2URL.value == "" ? course.carImage2URL : carImage2URL.value,
        // if(course.carImage3URL!= null || carImage3URL.value != null)
        "carImage3URL":
            carImage3URL.value == "" ? course.carImage3URL : carImage3URL.value,
        // if(course.carImage4URL!= null || carImage4URL.value != null)
        "carImage4URL":
            carImage4URL.value == "" ? course.carImage4URL : carImage4URL.value,
      }).then((value) {
        init();
        fetchCourses();
        Get.back();
      });
    }
    else {
      if(course.orderUrl !=null && course.orderUrl!.isNotEmpty){
        FirebaseStorage.instance.refFromURL(course.orderUrl!).delete();
      }
      if(course.carImage1URL !=null && course.carImage1URL!.isNotEmpty){
        FirebaseStorage.instance.refFromURL(course.carImage1URL!).delete();
      }
      if(course.carImage2URL !=null && course.carImage2URL!.isNotEmpty){
        FirebaseStorage.instance.refFromURL(course.carImage2URL!).delete();
      }
      if(course.carImage3URL !=null && course.carImage3URL!.isNotEmpty){
        FirebaseStorage.instance.refFromURL(course.carImage3URL!).delete();
      }
      if(course.carImage4URL !=null && course.carImage4URL!.isNotEmpty ){
        FirebaseStorage.instance.refFromURL(course.carImage4URL!).delete();
      }

      courses.doc(course.id).set({
        "seen": course.seen,
        "finished": course.finished,
        "pickUpLocation": pickUpLocationConroller.text,
        "dropOffLocation": dropOffLocationConroller.text,
        "pickUpDate": course.pickUpDate,
        "dropOffDate": isReturn.value == true ? course.dropOffDate : null,
        "passengersDetails": null,
        "passengersNum": int.tryParse(passagersConroller.text) ?? 0,
        "seatingCapacity": int.tryParse(seatingCapacityController.text) ?? 0,
        "driverName": selectedItem.value,
        "identityNum": selectedItemId.value,
        "regNumber": regNumberController.text,
        "check": course.check,
        if (course.adminId != null) "idAdmin": course.adminId,
        // "luggageBigSize":course.luggageBigSize,
        // "luggageMediumSize":course.luggageMediumSize,
        "collie": course.collie,
        // "usedLuggageBigSize":course.usedLuggageBigSize,
        // "usedLuggageMediumSize":course.usedLuggageMediumSize,
        "usedCollie": course.usedCollie,
      }).then((value) {
        init();
        fetchCourses();
        Get.back();
      });
    }
  }

  Future delete_course(Course course) async {
    if (course.orderUrl != null)
      FirebaseStorage.instance.refFromURL(course.orderUrl!).delete();

    if (course.carImage1URL != null)
      FirebaseStorage.instance.refFromURL(course.carImage1URL!).delete();

    if (course.carImage2URL != null)
      FirebaseStorage.instance.refFromURL(course.carImage2URL!).delete();

    if (course.carImage3URL != null)
      FirebaseStorage.instance.refFromURL(course.carImage3URL!).delete();

    if (course.carImage4URL != null)
      FirebaseStorage.instance.refFromURL(course.carImage4URL!).delete();

    await courses.doc(course.id).delete();
  }

  ///////////////admin/////////////////////////
  void filterCoursesTodayAdmin() {
    coursesListToday.assignAll(coursesListAdmin.where((course) =>
        course.pickUpDate.year == DateTime.now().year &&
        course.pickUpDate.month == DateTime.now().month &&
        course.pickUpDate.day == DateTime.now().day &&
        course.finished == false));
  }

  void filterCoursesTomorrowAdmin() {
    coursesListTomorrow.assignAll(coursesListAdmin.where((course) =>
        course.pickUpDate.year == DateTime.now().add(Duration(days: 1)).year &&
        course.pickUpDate.month ==
            DateTime.now().add(Duration(days: 1)).month &&
        course.pickUpDate.day == DateTime.now().add(Duration(days: 1)).day));
  }

  void filterCoursesOthersAdmin() {
    coursesList.assignAll(coursesListAdmin.where((course) =>
      course.pickUpDate.isAfter(DateTime.now().add(Duration(days: 1,hours: 24-DateTime.now().hour))))
    );
  }

///////////////////driver///////////////////////////
  void filterCoursesTodayDriver() {
    coursesListTodayDrivers.assignAll(coursesListDriver.where((course) =>
        course.pickUpDate.year == DateTime.now().year &&
        course.pickUpDate.month == DateTime.now().month &&
        course.pickUpDate.day == DateTime.now().day&&
            course.finished == false));
  }

  void filterCoursesTomorrowDriver() {
    coursesListTomorrowDrivers.assignAll(coursesListDriver.where((course) =>
        course.pickUpDate.year == DateTime.now().add(Duration(days: 1)).year &&
        course.pickUpDate.month ==
            DateTime.now().add(Duration(days: 1)).month &&
        course.pickUpDate.day == DateTime.now().add(Duration(days: 1)).day));
  }

  void filterCoursesOthersDriver() {
    coursesListDrivers.assignAll(coursesListDriver.where((course) =>
    course.pickUpDate.isAfter(DateTime.now().add(Duration(days: 1,hours: 24-DateTime.now().hour)))
    ));
  }

/////////////////history/////////////////////////////
  void filterCoursesTodayHistory() {
    coursesListTodayHistory.assignAll(coursesAll.where((course) =>
        course.pickUpDate.year == DateTime.now().year &&
        course.pickUpDate.month == DateTime.now().month &&
        course.pickUpDate.day == DateTime.now().day));
  }

  void filterCoursesYesterdayHistory() {
    coursesListYesterDayHistory.assignAll(coursesAll.where((course) =>
        course.pickUpDate.year == DateTime.now().add(Duration(days: -1)).year &&
        course.pickUpDate.month ==
            DateTime.now().add(Duration(days: -1)).month &&
        course.pickUpDate.day == DateTime.now().add(Duration(days: -1)).day));
  }

  void filterCoursesOlderHistory() {
    coursesListOlderHistory.assignAll(coursesAll.where((course) =>
        course.pickUpDate.year <= DateTime.now().add(Duration(days: -1)).year &&
        course.pickUpDate.month <=
            DateTime.now().add(Duration(days: -1)).month &&
        course.pickUpDate.day < DateTime.now().add(Duration(days: -1)).day));
  }

//////////////////////////////////////////////
  void filter(String prefix) {
    /////////////////admin//////////////////////////
    coursesListToday.assignAll(coursesListAdmin.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase()) &&
        course.pickUpDate.year == DateTime.now().year &&
        course.pickUpDate.month == DateTime.now().month &&
        course.pickUpDate.day == DateTime.now().day));
    coursesListTomorrow.assignAll(coursesListAdmin.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase()) &&
        course.pickUpDate.year == DateTime.now().add(Duration(days: 1)).year &&
        course.pickUpDate.month ==
            DateTime.now().add(Duration(days: 1)).month &&
        course.pickUpDate.day == DateTime.now().add(Duration(days: 1)).day));

    coursesList.assignAll(coursesListAdmin.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase()) &&
        !coursesListToday.contains(course) &&
        !coursesListTomorrow.contains(course)));

    /////////////////driver//////////////////////////

    coursesListTodayDrivers.assignAll(coursesListDriver.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase()) &&
        course.pickUpDate.year == DateTime.now().year &&
        course.pickUpDate.month == DateTime.now().month &&
        course.pickUpDate.day == DateTime.now().day));
    coursesListTomorrowDrivers.assignAll(coursesListDriver.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase()) &&
        course.pickUpDate.year == DateTime.now().add(Duration(days: 1)).year &&
        course.pickUpDate.month ==
            DateTime.now().add(Duration(days: 1)).month &&
        course.pickUpDate.day == DateTime.now().add(Duration(days: 1)).day));

    coursesListDrivers.assignAll(coursesListDriver.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase()) &&
        !coursesListToday.contains(course) &&
        !coursesListTomorrow.contains(course)));
    /////////////////history////////////////////////////
    coursesListTodayHistory.assignAll(coursesAll.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase()) &&
        course.pickUpDate.year == DateTime.now().year &&
        course.pickUpDate.month == DateTime.now().month &&
        course.pickUpDate.day == DateTime.now().day));
    coursesListYesterDayHistory.assignAll(coursesAll.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase()) &&
        course.pickUpDate.year == DateTime.now().add(Duration(days: -1)).year &&
        course.pickUpDate.month ==
            DateTime.now().add(Duration(days: -1)).month &&
        course.pickUpDate.day == DateTime.now().add(Duration(days: -1)).day));
    coursesListOlderHistory.assignAll(coursesAll.where((course) =>
        course.pickUpLocation.toLowerCase()!.startsWith(prefix.toLowerCase()) &&
        course.pickUpDate.year <= DateTime.now().add(Duration(days: -1)).year &&
        course.pickUpDate.month <=
            DateTime.now().add(Duration(days: -1)).month &&
        course.pickUpDate.day < DateTime.now().add(Duration(days: -1)).day));
  }

///////////////////////////pick excel for car/////////////////////////////////////////
  RxList<rowdata> passengerCarDetails = <rowdata>[].obs;

  String? file;

  Future importFromExcel() async {
    passengerCarDetails = RxList<rowdata>([]);

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

        passengerCarDetails.add(rowdata(
            firstname: row[0]?.value ?? "",
            lastName: row[1]?.value ?? "",
            phoneNum: row[2]?.value.toString() ?? "",
            state: false,
          collieNumber: 1,
          passengersNumber: 1
        ));
      }
    }
    passengerCarDetails.length;
  }

////////////////////////////////////////////////////////////////////
///////////////////////////pick excel for bus/////////////////////////////////////////
  RxList<rowdata> passengerDetails = <rowdata>[].obs;

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
    passengerDetails = RxList<rowdata>([]);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (isFirstRow) {
          isFirstRow = false;
          continue;
        }
        passengerDetails.add(rowdata(
            firstname: row[0]?.value ?? "",
            lastName: row[1]?.value ?? "",
            phoneNum: row[2]?.value.toString()  ?? "",
            // state:row[3]?.value ?? false
            state: false,
            collieNumber: 1,
            passengersNumber: 1));
      }
    }
    passengerDetails.length;
  }
}
