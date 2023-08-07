import 'dart:io';

import 'package:admin_citygo/models/course.dart';
import 'package:admin_citygo/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_excel/excel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CoursesController extends GetxController{

  TextEditingController pickUpLocationConroller = TextEditingController();
  TextEditingController dropOffLocationConroller = TextEditingController();
  TextEditingController pickUpDateConroller= TextEditingController();
  TextEditingController passagersConroller= TextEditingController();
  TextEditingController luggageConroller= TextEditingController();
  TextEditingController regNumberController= TextEditingController();
  TextEditingController seatingCapacityController= TextEditingController();

  CollectionReference courses = FirebaseFirestore.instance.collection("courses");


  RxInt formNum = 1.obs;

  RxString selectedItem = 'Driver name'.obs;

  RxInt selectedItemId=RxInt(0);

  final formKey = GlobalKey<FormState>();

  RxBool validLicenceType=false.obs;

  RxString image=''.obs;

  RxBool isChecked = true.obs;

  RxBool isReturn = false.obs;
  RxBool checkBox1 = false.obs;
  RxBool checkBox2 = false.obs;
////////////////////////////////////////////



////////////////////////////////////////////


  void init(){
    image.value='';
    selectedItem.value = 'Driver name';
    formNum.value = 1;
    validLicenceType.value=false;
    passengerCarDetails=RxList<rowdata>([]);
    passengerDetails=RxList<rowdata>([]);
    isReturn = false.obs;
    checkBox1 = false.obs;
    checkBox2 = false.obs;
  }
  Future<void> pickOrderFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      image.value = result.files.single.path!;
    }

  }

  var coursesList = <Course>[].obs;
  var coursesListToday = <Course>[].obs;
  var coursesListTomorrow = <Course>[].obs;

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
  Future<void> fetchCourses() async {
    // try {
      Timestamp? dropOffDate;
      List<rowdata>? passengersDetails;
      QuerySnapshot courses =await FirebaseFirestore.instance.collection('courses').orderBy('pickUpDate', descending: true).get();
      coursesList.clear();
      coursesListToday.clear();
      coursesListTomorrow.clear();
      for (var course in courses.docs) {
        var courseData = course.data() as Map<String, dynamic>;
        // if (courseData.containsKey('dropOffLocation')) {
        //   if (course['dropOffLocation'] != null ||
        //       course['dropOffLocation'] != "")
        //     dropOffLocation = course['dropOffLocation'];
        // }
        //
        // if (courseData.containsKey('dropOffDate')) {
        //   if (course['dropOffDate'] != null || course['dropOffDate'] != "")
        //     dropOffDate = course['dropOffDate'];
        // }
        //
        // if (courseData.containsKey('passengersNum')){
        //   if(course['passengersNum']!=null || course['passengersNum']!="")
        //     passengersNum= course['passengersNum'];
        // }
        //
        // if(courseData.containsKey('orderUrl')){
        //   if(course['orderUrl']!=null || course['orderUrl']!="")
        //     orderUrl=  course['orderUrl'];
        // }
        //
        // if(courseData.containsKey('passengersDetails') ){
        //   List<dynamic>? passengersDetailsData = courseData['passengersDetails'];
        //   passengersDetails = passengersDetailsData?.map(
        //         (passengerData) => rowdata(
        //       firstname: passengerData['firstname'],
        //       lastName: passengerData['lastName'],
        //       identityNum: passengerData['identityNum'],
        //     ),
        //   ).toList();}
        //
        // pickUpDate=courseData['pickUpDate'];
        // coursesList.add(
        //     CourseModel(
        //         id: course.id,
        //         type: "",
        //         pickUpLocation: courseData['pickUpLocation'],
        //         driverName: courseData['driverName'],
        //         dropOffLocation: dropOffLocation,
        //         pickUpDate:pickUpDate.toDate(),
        //         dropOffDate:dropOffDate?.toDate(),
        //         passengersNum:passengersNum,
        //         orderUrl:orderUrl,
        //         passengersDetails:passengersDetails,
        //         identityNum: courseData['identityNum']
        //     )
        // );
        Timestamp date=course['pickUpDate'];
        // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);
        // print(dateTime);
        // print(course['regNumber']);
        // print(date.toDate());
        // print(DateTime.fromMillisecondsSinceEpoch(course['pickUpDate'].millisecondsSinceEpoch));
        // DateTime dateTime2 = DateTime.fromMillisecondsSinceEpoch(course['pickUpDate'].millisecondsSinceEpoch, isUtc: true);
        // final parisTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(dateTime.toLocal());
        //
        // print(parisTime);
        // print('////////////////111///////////////');
        // print(DateFormat('dd/MM/yyyy, HH:mm').format( DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch)));
        // print('///////////////////////////////');
        // print(readTimestamp(date.millisecondsSinceEpoch));

        if(course['check']=="car"){
          if( date.toDate().year==DateTime.now().year && date.toDate().month==DateTime.now().month && date.toDate().day==DateTime.now().day)
            {
          coursesListToday.add(
                Course(
                  id: course.id,
                  pickUpLocation: course['pickUpLocation'],
                  dropOffLocation: course['dropOffLocation'],
                  pickUpDate:date.toDate(),
                  passengersNum: course['passengersNum'],
                  seatingCapacity:course['seatingCapacity'],
                  regNumber: course['regNumber'],
                  driverName: course['driverName'],
                  seen: course['seen'],
                  identityNum: course['identityNum'],
                )
            );}
          else if(date.toDate().year==DateTime.now().add(Duration(days: 1)).year && date.toDate().month==DateTime.now().add(Duration(days: 1)).month && date.toDate().day==DateTime.now().add(Duration(days: 1)).day)
            {

              coursesListTomorrow.add(
                Course(
                  id: course.id,
                  pickUpLocation: course['pickUpLocation'],
                  dropOffLocation: course['dropOffLocation'],
                  pickUpDate:date.toDate(),
                  passengersNum: course['passengersNum'],
                  seatingCapacity:course['seatingCapacity'],
                  regNumber: course['regNumber'],
                  driverName: course['driverName'],
                  seen: course['seen'],
                  identityNum: course['identityNum'],

                )
            );
            }
            else {
        coursesList.add(
                Course(
                  id: course.id,
                  pickUpLocation: course['pickUpLocation'],
                  dropOffLocation: course['dropOffLocation'],
                  pickUpDate:date.toDate(),
                  passengersNum: course['passengersNum'],
                  seatingCapacity:course['seatingCapacity'],
                  regNumber: course['regNumber'],
                  driverName: course['driverName'],
                  seen: course['seen'],
                  identityNum: course['identityNum'],
                )
            );
            }
        }
      }


    // } catch (e) {
    //   print('Error '+ e.toString());
    // }

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
  ////////////////////////////////////////*


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
  }
////////////////////////////////////////////////////////////////////
///////////////////////////pick excel for bus/////////////////////////////////////////
  RxList<rowdata> passengerDetails =RxList<rowdata>([]);

  String? filePassenger;
  Future importFromExcelForPassenger() async {

    passengerDetails =RxList<rowdata>([]);

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

        passengerDetails.add(
            rowdata(
              firstname: row[0]?.value ?? "",
              lastName: row[1]?.value ?? "",
              identityNum: row[2]?.value.toString() ?? "",
            )
        );
      }
    }
  }
////////////////////////////////////////////////////////////////////


}

class rowdata {
  final String firstname;
  final String lastName;
  final String identityNum;
  rowdata({required this.firstname, required this.lastName, required this.identityNum});

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastName': lastName,
      'identityNum': identityNum,
    };
  }

}