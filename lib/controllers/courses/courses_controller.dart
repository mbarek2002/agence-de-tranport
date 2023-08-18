import 'dart:io';
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

  List<Course> mergedList =<Course>[].obs;
///////////////////////////////////////
  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date); // Doesn't get called when it should be
    } else {
      time = diff.inDays.toString() + 'DAYS AGO'; // Gets call and it's wrong date
    }

    return time;
  }

/////////////////crud opertion///////////////////////
  List<rowdata>? passengersDetailsFetch;
  List<checklistData>? carDetailsFetch;

  int? collie;
  int? luggageBigSize;
  int? luggageMediumSize;
  String? carImg1Url;
  String? carImg2Url;
  String? carImg3Url;
  String? carImg4Url;

  Future<void> fetchCourses() async {
    try {
      isLoading.value=true;
    Timestamp? dropOffDate;
      String? orderUrl;
      QuerySnapshot courses =await FirebaseFirestore.instance.collection('courses').orderBy('pickUpDate', descending: true).get();
      coursesListAdmin.clear();
      coursesListDriver.clear();

      for (var course in courses.docs) {
        var courseData = course.data() as Map<String, dynamic>;
          print(course.id);
        try {
        //   passengersDetailsFetch?.clear();
        //   carDetailsFetch?.clear();
          if (courseData.containsKey('passengersDetails')) {
            List<dynamic>? passengersDetailsData = courseData['passengersDetails'];
            passengersDetailsFetch = passengersDetailsData?.map(
                  (passengerData) =>
                  rowdata(
                    firstname: passengerData['firstname'],
                    lastName: passengerData['lastName'],
                    identityNum: passengerData['identityNum'],
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

          if(courseData.containsKey('collie')){
            collie = course['collie'];
          }
          if(courseData.containsKey('luggageBigSize')){
            luggageBigSize = course['luggageBigSize'];
          }
          if(courseData.containsKey('luggageMediumSize')){
            luggageMediumSize = course['luggageMediumSize'];
          }

          if(courseData.containsKey('usedCollie')){
            usedCollie.value = course['usedCollie'];
          }
          if(courseData.containsKey('usedLuggageBigSize')){
            usedLuggageBigSize.value = course['usedLuggageBigSize'];
          }
          if(courseData.containsKey('usedLuggageMediumSize')){
            usedLuggageMediumSize.value = course['usedLuggageMediumSize'];
          }



          Timestamp date = course['pickUpDate'];


          if(courseData.containsKey('idAdmin')) {
            if (course['idAdmin'] == loginController.idAdmin.value) {

              coursesListAdmin.add(
                  Course(
                    check: course['check'],
                    adminId: course['idAdmin'],
                    id: course.id,
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
                    collie: collie,
                    usedCollie: usedCollie.value,
                    luggageBigSize: luggageBigSize,
                    usedLuggageBigSize: usedLuggageBigSize.value,
                    luggageMediumSize: luggageMediumSize,
                    usedLuggageMediumSize: usedLuggageMediumSize.value
                  )
              );
            }
          }
          else{
            coursesListDriver.add(
                Course(
                  check: course['check'],
                  id: course.id,
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
                )
            );
          }


        }catch(e){
          print(e.toString());
        }
      }



    filterCoursesTodayAdmin();
    filterCoursesTomorrowAdmin();
    filterCoursesOthersAdmin();

////////////////////////
    filterCoursesTodayDriver();
    filterCoursesTomorrowDriver();
    filterCoursesOthersDriver();

      isLoading.value=false;

    } catch (e) {
      print('Error '+ e.toString());
    }
  }

  Future add_course(CourseModel d)async{
    courses.add({
      "type":d.type,
      "pickUpLocation":d.pickUpLocation,
      "dropOffLocation":d.dropOffLocation,
      "pickUpDate":Timestamp.fromDate(d.pickUpDate),
      if(d.dropOffDate!=null)"dropOffDate":Timestamp.fromDate(d.dropOffDate!),
      "driverName":d.driverName,
      "identityNum":d.identityNum,
      if(d.orderUrl!=null)"orderUrl":d.orderUrl,
      if(d.passengersNum!=null)"passengersNum":d.passengersNum,
      if(d.passengersDetails!=null)"passengersDetails": d.passengersDetails?.map((passenger) => passenger.toJson()).toList(),
    });
  }

  Future update_course(CourseModel d)async{
    courses.doc(d.id).update({
        "type":d.type,
        "pickUpLocation":d.pickUpLocation,
        "dropOffLocation":d.dropOffLocation,
        "pickUpDate":Timestamp.fromDate(d.pickUpDate),
        if(d.dropOffDate!=null)"dropOffDate":Timestamp.fromDate(d.dropOffDate!),
        "driverName":d.driverName,
        if(d.orderUrl!=null)"orderUrl":d.orderUrl,
        if(d.passengersNum!=null)"passengersNum":d.passengersNum,
        if(d.passengersDetails!=null)"passengersDetails": d.passengersDetails?.map((passenger) => passenger.toJson()).toList(),
        "identityNum":d.identityNum
  }
    );
  }

  Future delete_course(String id )async{
    await courses.doc(id).delete();
  }
  ///////////////admin/////////////////////////
  void filterCoursesTodayAdmin() {
    coursesListToday.assignAll(coursesListAdmin.where((course) =>
    course.pickUpDate.year == DateTime.now().year
    && course.pickUpDate.month == DateTime.now().month
    && course.pickUpDate.day == DateTime.now().day
    ));
  }
  void filterCoursesTomorrowAdmin() {
    coursesListTomorrow.assignAll(coursesListAdmin.where((course) =>
    course.pickUpDate.year == DateTime.now().add(Duration(days: 1)).year
    && course.pickUpDate.month == DateTime.now().add(Duration(days: 1)).month
    && course.pickUpDate.day == DateTime.now().add(Duration(days: 1)).day
    ));
    print("///////////////");
    print(coursesListTomorrow[0].carListDetails!.length);
    print(coursesListTomorrow[0].carImage1URL);

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


  void filter(String prefix){
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

  rowdata(
      {required this.firstname, required this.lastName, required this.identityNum});

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastName': lastName,
      'identityNum': identityNum,
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