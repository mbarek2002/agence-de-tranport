import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/course.dart';
import 'package:admin_citygo/view/courses_list/add_course.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/courses_list/course_passenger_detail.dart';
import 'package:admin_citygo/view/courses_list/edit_course.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursesListSceen extends StatefulWidget {
  CoursesListSceen({Key? key}) : super(key: key);

  @override
  State<CoursesListSceen> createState() => _CoursesListSceenState();
}

class _CoursesListSceenState extends State<CoursesListSceen> {
  CoursesController coursesController = Get.put(CoursesController());

  DriversController driversController = Get.put(DriversController());

  LoginController loginController = Get.put(LoginController());

  void initState() {
    super.initState();
    coursesController.fetchCourses();
    // loginController.getAdminImage(loginController.emailController.text);
    loginController
        .getAdminImage(FirebaseAuth.instance.currentUser!.email.toString());
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];

      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print('download with sssuucccss');
      }
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future download(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
        url: url,
        headers: {},
        savedDir: baseStorage!.path,
        fileName: "mission order",
        showNotification: true,
        openFileFromNotification: true,
      );
    }
  }

  Future downloadCarImage(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
        url: url,
        headers: {},
        savedDir: baseStorage!.path,
        fileName: "car_image",
        showNotification: true,
        openFileFromNotification: true,
      );
    }
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  ReceivePort _port = ReceivePort();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddCourseScreen()));
          },
        ),
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: IconButton(
              iconSize: 35,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          backgroundColor: Color(0xFF0F5CA0),
          title: Padding(
            padding: EdgeInsets.only(top: 30, left: 0),
            child: Text(
              "Target List",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Georgia"),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(tHomebackground))),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                        ),
                        color: Color(0xFF0F5CA0)),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Container(
                    height: 55,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                    onChanged: (value) => coursesController.filter(value),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: "search by pick up location",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    // style:,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Row(children: [
                    GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: coursesController.formNum.value == 1
                                  ? Color(0xFF0F5CA0).withOpacity(0.6)
                                  : Color(0xFF3C77E1),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                              )),
                          width: MediaQuery.of(context).size.width *
                              (0.95 / 2),
                          child: Center(
                            child: Text(
                              'Courses',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Georgia",
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          coursesController.formNum.value = 1;
                        }),
                    GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: coursesController.formNum.value == 2
                                  ? Color(0xFF0F5CA0).withOpacity(0.6)
                                  : Color(0xFF3C77E1),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                              )),
                          width: MediaQuery.of(context).size.width *
                              (0.95 / 2),
                          child: Center(
                            child: Text(
                              'History',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "Georgia",
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          coursesController.formNum.value = 2;
                        })
                  ]),
                ),
                if (coursesController.isLoading.value)
                  Center(child: CircularProgressIndicator())
                else
                  Flexible(
                    child: Container(
                        // height: MediaQuery.of(context).size.height * 0.55,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: RefreshIndicator(
                            onRefresh: () {
                              try {
                                coursesController.fetchCourses();
                              } catch (e) {
                                print(e.toString);
                              }
                              return Future.delayed(Duration(seconds: 1));
                            },
                            child: coursesController.formNum.value == 1
                            
                                ? ListView(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(5)),
                                          color: Color(0xFF0F5CA0)
                                              .withOpacity(0.7),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [



                                            //--------------------Today List Admin ---------------
                                            if (coursesController
                                                .coursesListToday.isNotEmpty)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 35.0,top: 12),
                                                child: Text(
                                                  'Today',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: "Georgia",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),

                                            if (coursesController .coursesListToday.isNotEmpty)
                                              for (int i = 0;i <coursesController.coursesListToday .length;i++)
                                                Container(
                                                  height: 70,
                                                  width: MediaQuery.of(context).size.width * 0.9,
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      right: 5,
                                                      bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              courseDetails(
                                                                  context,
                                                                  coursesController
                                                                      .coursesListToday[i]);
                                                            },
                                                            child:
                                                                Container(
                                                              width: 200,
                                                              height: 48,
                                                              decoration: BoxDecoration(
                                                                  color: coursesController.coursesListToday[i].seen ==
                                                                          true
                                                                      ? Colors.white.withOpacity(
                                                                          0.8)
                                                                      : Colors.white.withOpacity(
                                                                          0.3),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    width:
                                                                        70,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesListToday[i].pickUpLocation.capitalize.toString(),
                                                                          style: TextStyle(
                                                                            fontSize: 13,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            2,
                                                                        width:
                                                                            30,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            5,
                                                                        width:
                                                                            5,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape: BoxShape.circle,
                                                                          color: Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        70,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesListToday[i].dropOffLocation!.capitalize.toString(),
                                                                          style: TextStyle(
                                                                            fontSize: 13,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  if (coursesController
                                                                          .coursesListToday[
                                                                              i]
                                                                          .seen ==
                                                                      true)
                                                                    Icon(Icons
                                                                        .check_circle)
                                                                  else
                                                                    Icon(Icons
                                                                        .check_circle_outline_rounded)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: 5),
                                                          GestureDetector(
                                                            child:
                                                                Container(
                                                              width: 65,
                                                              height: 48,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.8),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .people_alt_outlined,
                                                                    size:
                                                                        20,
                                                                  ),
                                                                  Center(
                                                                    child:
                                                                        Container(
                                                                      child: Text(
                                                                          coursesController.coursesListToday[i].passengersNum.toString() + '/' + coursesController.coursesListToday[i].seatingCapacity.toString(),
                                                                          style: TextStyle(fontSize: 13, fontFamily: 'Georgia', fontWeight: FontWeight.bold)),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              if (coursesController
                                                                          .coursesListToday[
                                                                              i]
                                                                          .passengersDetails !=
                                                                      null &&
                                                                  coursesController
                                                                      .coursesListToday[
                                                                          i]
                                                                      .passengersDetails!
                                                                      .isNotEmpty) {
                                                                Get.to(() =>
                                                                    CoursePassengerDetail(
                                                                        course:
                                                                            coursesController.coursesListToday[i]));
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  EditCourseScreen(
                                                                      record:
                                                                          coursesController.coursesListToday[i]));
                                                            },
                                                            child:
                                                                Container(
                                                              height: 40,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Icon(
                                                                Icons.edit,
                                                                color: Color(
                                                                    0xFF0F5CA0),
                                                                size: 23,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: ((builder) =>
                                                                      AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height: 100,
                                                                          width: 300,
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                                                                          child: Center(
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: <Widget>[
                                                                                SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 100,
                                                                                  child: ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                                    child: const Text(
                                                                                      'Delete',
                                                                                      style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      print("tataatat");
                                                                                      coursesController.delete_course(coursesController.coursesListToday[i]);
                                                                                      // coursesController.fetchCourses();
                                                                                      // Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 25,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 100,
                                                                                  child: ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                                    child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                                    onPressed: () => Navigator.pop(context),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )));
                                                            },
                                                            child:
                                                                Container(
                                                              height: 40,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Icon(
                                                                Icons
                                                                    .delete,
                                                                color: Color(
                                                                        0xFF000000)
                                                                    .withOpacity(
                                                                        0.54),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                            
                                            
                                            
                                            //----------Tommorow List Admin--------------
                                            if (coursesController.coursesListTomorrow .length >0)
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 35.0),
                                                child: Text(
                                                  'Tomorrow',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: "Georgia",
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            if (coursesController.coursesListTomorrow.isNotEmpty)
                                              for (int i = 0; i < coursesController.coursesListTomorrow.length; i++)
                                                Container(
                                                  height: 70,
                                                  width:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.9,
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      right: 5,
                                                      bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              courseDetails(
                                                                  context,
                                                                  coursesController
                                                                      .coursesListTomorrow[i]);
                                                            },
                                                            child:
                                                            Container(
                                                              width: 200,
                                                              height: 48,
                                                              decoration: BoxDecoration(
                                                                  color: coursesController.coursesListTomorrow[i].seen ==
                                                                      true
                                                                      ? Colors.white.withOpacity(
                                                                      0.8)
                                                                      : Colors.white.withOpacity(
                                                                      0.3),
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                        8.0),
                                                                    width:
                                                                    70,
                                                                    child:
                                                                    Center(
                                                                      child: Text(
                                                                          coursesController.coursesListTomorrow[i].pickUpLocation.capitalize.toString(),
                                                                          style: TextStyle(
                                                                            fontSize: 15,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                        2,
                                                                        width:
                                                                        30,
                                                                        color:
                                                                        Colors.black,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                        5,
                                                                        width:
                                                                        5,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                          shape: BoxShape.circle,
                                                                          color: Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                    70,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                        8.0),
                                                                    child:
                                                                    Center(
                                                                      child: Text(
                                                                          coursesController.coursesListTomorrow[i].dropOffLocation!.capitalize.toString(),
                                                                          style: TextStyle(
                                                                            fontSize: 15,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  if (coursesController
                                                                      .coursesListTomorrow[
                                                                  i]
                                                                      .seen ==
                                                                      true)
                                                                    Icon(Icons
                                                                        .check_circle)
                                                                  else
                                                                    Icon(Icons
                                                                        .check_circle_outline_rounded)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: 5),
                                                          GestureDetector(
                                                            child:
                                                            Container(
                                                              width: 65,
                                                              height: 48,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                      0.8),
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5)),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .people_alt_outlined,
                                                                    size:
                                                                    20,
                                                                  ),
                                                                  Container(
                                                                    // width:70,
                                                                    child: Text(
                                                                        coursesController.coursesListTomorrow[i].passengersNum.toString() +
                                                                            '/' +
                                                                            coursesController.coursesListTomorrow[i].seatingCapacity.toString(),
                                                                        style: TextStyle(fontSize: 13, fontFamily: 'Georgia', fontWeight: FontWeight.bold)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              if (coursesController
                                                                  .coursesListTomorrow[
                                                              i]
                                                                  .passengersDetails !=
                                                                  null &&
                                                                  coursesController
                                                                      .coursesListTomorrow[
                                                                  i]
                                                                      .passengersDetails!
                                                                      .isNotEmpty) {
                                                                coursesController
                                                                    .course1
                                                                    .value = coursesController
                                                                    .coursesListTomorrow[
                                                                i];
                                                                Get.to(() => CoursePassengerDetail(
                                                                    course: coursesController
                                                                        .course1
                                                                        .value));
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  EditCourseScreen(
                                                                      record:
                                                                      coursesController.coursesListTomorrow[i]));
                                                            },
                                                            child:
                                                            Container(
                                                              height: 40,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5)),
                                                              child: Icon(
                                                                Icons.edit,
                                                                color: Color(
                                                                    0xFF0F5CA0),
                                                                size: 23,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                  context,
                                                                  builder: ((builder) =>
                                                                      AlertDialog(
                                                                        content:
                                                                        Container(
                                                                          height: 100,
                                                                          width: 300,
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                                                                          child: Center(
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: <Widget>[
                                                                                SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 100,
                                                                                  child: ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                                    child: const Text(
                                                                                      'Delete',
                                                                                      style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      coursesController.delete_course(coursesController.coursesListTomorrow[i]);
                                                                                      // coursesController.fetchCourses();
                                                                                      // Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 25,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 100,
                                                                                  child: ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                                    child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                                    onPressed: () => Navigator.pop(context),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )));
                                                            },
                                                            child:
                                                            Container(
                                                              height: 40,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      5)),
                                                              child: Icon(
                                                                Icons
                                                                    .delete,
                                                                color: Color(
                                                                    0xFF000000)
                                                                    .withOpacity(
                                                                    0.54),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                            
                                            
                                            
                                            
                                            //----------------- Other Futur List Admin---------------------
                                            if (coursesController.coursesList.isNotEmpty)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 35.0),
                                                child: Text(
                                                  'Others',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: "Georgia",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            
                                            if (coursesController.coursesList.isNotEmpty)
                                              for (int i = 0;i < coursesController.coursesList.length; i++)
                                                Container(
                                                  height: 70,
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.9,
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      right: 5,
                                                      bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              courseDetails(
                                                                  context,
                                                                  coursesController
                                                                      .coursesList[i]);
                                                            },
                                                            child:
                                                                Container(
                                                              width: 200,
                                                              height: 48,
                                                              decoration: BoxDecoration(
                                                                  color: coursesController.coursesList[i].seen ==
                                                                          true
                                                                      ? Colors.white.withOpacity(
                                                                          0.8)
                                                                      : Colors.white.withOpacity(
                                                                          0.3),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        45,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    width:
                                                                        70,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesList[i].pickUpLocation.capitalize.toString(),
                                                                          style: TextStyle(
                                                                            fontSize: 13,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            2,
                                                                        width:
                                                                            30,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            5,
                                                                        width:
                                                                            5,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape: BoxShape.circle,
                                                                          color: Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        70,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesList[i].dropOffLocation!.capitalize.toString(),
                                                                          style: TextStyle(
                                                                            fontSize: 13,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  if (coursesController
                                                                          .coursesList[
                                                                              i]
                                                                          .seen ==
                                                                      true)
                                                                    Icon(Icons
                                                                        .check_circle)
                                                                  else
                                                                    Icon(Icons
                                                                        .check_circle_outline_rounded)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: 5),
                                                          GestureDetector(
                                                            child:
                                                                Container(
                                                              width: 60,
                                                              height: 48,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.8),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Center(
                                                                child:
                                                                    Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .people_alt_outlined,
                                                                      size:
                                                                          20,
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          Container(
                                                                        // width:60,
                                                                        child:
                                                                            Text(coursesController.coursesList[i].passengersNum.toString() + '/' + coursesController.coursesList[i].seatingCapacity.toString(), style: TextStyle(fontSize: 13, fontFamily: 'Georgia', fontWeight: FontWeight.bold)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              if (coursesController
                                                                          .coursesList[
                                                                              i]
                                                                          .passengersDetails !=
                                                                      null &&
                                                                  coursesController
                                                                      .coursesList[
                                                                          i]
                                                                      .passengersDetails!
                                                                      .isNotEmpty) {
                                                                Get.to(() =>
                                                                    CoursePassengerDetail(
                                                                        course:
                                                                            coursesController.coursesList[i]));
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  EditCourseScreen(
                                                                      record:
                                                                          coursesController.coursesList[i]));
                                                            },
                                                            child:
                                                                Container(
                                                              height: 40,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Icon(
                                                                Icons.edit,
                                                                color: Color(
                                                                    0xFF0F5CA0),
                                                                size: 23,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: ((builder) =>
                                                                      AlertDialog(
                                                                        content:
                                                                            Container(
                                                                          height: 100,
                                                                          width: 300,
                                                                          decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                                                                          child: Center(
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: <Widget>[
                                                                                SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 100,
                                                                                  child: ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                                    child: const Text(
                                                                                      'Delete',
                                                                                      style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                                    ),
                                                                                    onPressed: () async {
                                                                                      await coursesController.delete_course(coursesController.coursesList[i]);
                                                                                      // coursesController.fetchCourses();
                                                                                      // Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 25,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 100,
                                                                                  child: ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                                    child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                                    onPressed: () => Navigator.pop(context),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )));
                                                            },
                                                            child:
                                                                Container(
                                                              height: 40,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Icon(
                                                                Icons
                                                                    .delete,
                                                                color: Color(
                                                                        0xFF000000)
                                                                    .withOpacity(
                                                                        0.54),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                            
                                            
                                            
                                            
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12),


                                      //-----------------------Driver part---------------------
                                      if (coursesController.coursesListDrivers.length > 0 || coursesController.coursesListTodayDrivers.length > 0 ||
                                          coursesController.coursesListTomorrowDrivers.length > 0)
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xFF0F5CA0)
                                                          .withOpacity(0.7),
                                                  child: Image.asset(
                                                      "assets/icons/driver_black.png")),
                                              SizedBox(width: 8,),
                                              
                                              Text("Drivers",style: TextStyle(   fontSize: 18,fontWeight: FontWeight.bold, fontFamily: 'Georgia',),)
                                            ],
                                          ),
                                        ),
                                      SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xFF0F5CA0)
                                              .withOpacity(0.7),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [

                                            if (coursesController
                                                .coursesListTodayDrivers
                                                .length >
                                                0)
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 35.0,top: 16),
                                                child: Text(
                                                  'Today',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: "Georgia",
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                            if (coursesController
                                                .coursesListTodayDrivers
                                                .isNotEmpty)
                                              for (int i = 0;
                                              i <
                                                  coursesController
                                                      .coursesListTodayDrivers
                                                      .length;
                                              i++)
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 10),
                                                  child: Container(
                                                    height: 70,
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.9,
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                courseDetails(
                                                                    context,
                                                                    coursesController
                                                                        .coursesListTodayDrivers[i]);
                                                              },
                                                              child:
                                                              Container(
                                                                width: 200,
                                                                height: 48,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                        0.8),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        5)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                          8.0),
                                                                      width:
                                                                      70,
                                                                      child:
                                                                      Center(
                                                                        child: Text(
                                                                            coursesController.coursesListTodayDrivers[i].pickUpLocation.capitalize.toString(),
                                                                            style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontFamily: 'Georgia',
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                          2,
                                                                          width:
                                                                          30,
                                                                          color:
                                                                          Colors.black,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                          5,
                                                                          width:
                                                                          5,
                                                                          decoration:
                                                                          BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                      70,
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                          8.0),
                                                                      child:
                                                                      Center(
                                                                        child: Text(
                                                                            coursesController.coursesListTodayDrivers[i].dropOffLocation!.capitalize.toString(),
                                                                            style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontFamily: 'Georgia',
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 5),
                                                            GestureDetector(
                                                              child:
                                                              Container(
                                                                width: 65,
                                                                height: 48,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                        0.8),
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        5)),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .people_alt_outlined,
                                                                      size:
                                                                      20,
                                                                    ),
                                                                    Container(
                                                                      // width:70,
                                                                      child: Text(
                                                                          coursesController.coursesListTodayDrivers[i].passengersNum.toString() +
                                                                              '/' +
                                                                              coursesController.coursesListTodayDrivers[i].seatingCapacity.toString(),
                                                                          style: TextStyle(fontSize: 13, fontFamily: 'Georgia', fontWeight: FontWeight.bold)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                if (coursesController
                                                                    .coursesListTodayDrivers[
                                                                i]
                                                                    .passengersDetails !=
                                                                    null &&
                                                                    coursesController
                                                                        .coursesListTodayDrivers[
                                                                    i]
                                                                        .passengersDetails!
                                                                        .isNotEmpty) {
                                                                  Get.to(() =>
                                                                      CoursePassengerDetail(
                                                                          course:
                                                                          coursesController.coursesListTodayDrivers[i]));
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    EditCourseScreen(
                                                                        record:
                                                                        coursesController.coursesListTodayDrivers[i]));
                                                              },
                                                              child:
                                                              Container(
                                                                height: 40,
                                                                width: 25,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        5)),
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  color: Color(
                                                                      0xFF0F5CA0),
                                                                  size: 23,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                    context,
                                                                    builder: ((builder) =>
                                                                        AlertDialog(
                                                                          content:
                                                                          Container(
                                                                            height: 100,
                                                                            width: 300,
                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                                                                            child: Center(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: <Widget>[
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 100,
                                                                                    child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                                      child: const Text(
                                                                                        'Delete',
                                                                                        style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        await coursesController.delete_course(coursesController.coursesListTodayDrivers[i]);
                                                                                        // coursesController.fetchCourses();
                                                                                        // Navigator.pop(context);
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 25,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 100,
                                                                                    child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                                      child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                                      onPressed: () => Navigator.pop(context),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )));
                                                              },
                                                              child:
                                                              Container(
                                                                height: 40,
                                                                width: 25,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        5)),
                                                                child: Icon(
                                                                  Icons
                                                                      .delete,
                                                                  color: Color(
                                                                      0xFF000000)
                                                                      .withOpacity(
                                                                      0.54),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),




                                            if (coursesController
                                                .coursesListTomorrowDrivers
                                                .isNotEmpty)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 35.0),
                                                child: Text(
                                                  'Tomorrow',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: "Georgia",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            if (coursesController
                                                .coursesListTomorrowDrivers
                                                .isNotEmpty)
                                              for (int i = 0;
                                                  i <
                                                      coursesController
                                                          .coursesListTomorrowDrivers
                                                          .length;
                                                  i++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Container(
                                                    height: 70,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                courseDetails(
                                                                    context,
                                                                    coursesController
                                                                        .coursesListTomorrowDrivers[i]);
                                                              },
                                                              child:
                                                                  Container(
                                                                width: 200,
                                                                height: 48,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.8),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              8.0),
                                                                      width:
                                                                          70,
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            coursesController.coursesListTomorrowDrivers[i].pickUpLocation.capitalize.toString(),
                                                                            style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontFamily: 'Georgia',
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              2,
                                                                          width:
                                                                              30,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              5,
                                                                          width:
                                                                              5,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          70,
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              8.0),
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            coursesController.coursesListTomorrowDrivers[i].dropOffLocation!.capitalize.toString(),
                                                                            style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontFamily: 'Georgia',
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 5),
                                                            GestureDetector(
                                                              child:
                                                                  Container(
                                                                width: 65,
                                                                height: 48,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.8),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .people_alt_outlined,
                                                                      size:
                                                                          20,
                                                                    ),
                                                                    Container(
                                                                      // width:70,
                                                                      child: Text(
                                                                          coursesController.coursesListTomorrowDrivers[i].passengersNum.toString() +
                                                                              '/' +
                                                                              coursesController.coursesListTomorrowDrivers[i].seatingCapacity.toString(),
                                                                          style: TextStyle(fontSize: 13, fontFamily: 'Georgia', fontWeight: FontWeight.bold)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                if (coursesController
                                                                            .coursesListTomorrowDrivers[
                                                                                i]
                                                                            .passengersDetails !=
                                                                        null &&
                                                                    coursesController
                                                                        .coursesListTomorrowDrivers[
                                                                            i]
                                                                        .passengersDetails!
                                                                        .isNotEmpty) {
                                                                  Get.to(() =>
                                                                      CoursePassengerDetail(
                                                                          course:
                                                                              coursesController.coursesListTomorrowDrivers[i]));
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    EditCourseScreen(
                                                                        record:
                                                                            coursesController.coursesListTomorrowDrivers[i]));
                                                              },
                                                              child:
                                                                  Container(
                                                                height: 40,
                                                                width: 25,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  color: Color(
                                                                      0xFF0F5CA0),
                                                                  size: 23,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: ((builder) =>
                                                                        AlertDialog(
                                                                          content:
                                                                              Container(
                                                                            height: 100,
                                                                            width: 300,
                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                                                                            child: Center(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: <Widget>[
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 100,
                                                                                    child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                                      child: const Text(
                                                                                        'Delete',
                                                                                        style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        await coursesController
                                                                                            .delete_course(
                                                                                            coursesController
                                                                                                .coursesListTomorrowDrivers[i]);
                                                                                        //   coursesController.fetchCourses();
                                                                                        //   Navigator.pop(context);
                                                                                        // },
                                                                                      }),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 25,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 100,
                                                                                    child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                                      child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                                      onPressed: () => Navigator.pop(context),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )));
                                                              },
                                                              child:
                                                                  Container(
                                                                height: 40,
                                                                width: 25,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Icon(
                                                                  Icons
                                                                      .delete,
                                                                  color: Color(
                                                                          0xFF000000)
                                                                      .withOpacity(
                                                                          0.54),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),




                                            if (coursesController
                                                .coursesListDrivers
                                                .isNotEmpty)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 35.0),
                                                child: Text(
                                                  'Others',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: "Georgia",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            if (coursesController
                                                .coursesListDrivers
                                                .isNotEmpty)
                                              for (int i = 0;
                                                  i <
                                                      coursesController
                                                          .coursesListDrivers
                                                          .length;
                                                  i++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Container(
                                                    height: 70,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    padding: EdgeInsets.only(
                                                        left: 5,
                                                        right: 5,
                                                        bottom: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                courseDetails(
                                                                    context,
                                                                    coursesController
                                                                        .coursesListDrivers[i]);
                                                              },
                                                              child:
                                                                  Container(
                                                                width: 200,
                                                                height: 48,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.8),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              8.0),
                                                                      width:
                                                                          70,
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            coursesController.coursesListDrivers[i].pickUpLocation.capitalize.toString(),
                                                                            style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontFamily: 'Georgia',
                                                                            )),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              2,
                                                                          width:
                                                                              30,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              5,
                                                                          width:
                                                                              5,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          70,
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              8.0),
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            coursesController.coursesListDrivers[i].dropOffLocation!.capitalize.toString(),
                                                                            style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontFamily: 'Georgia',
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 5),
                                                            GestureDetector(
                                                              child:
                                                                  Container(
                                                                width: 65,
                                                                height: 48,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.8),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .people_alt_outlined,
                                                                      size:
                                                                          20,
                                                                    ),
                                                                    Container(
                                                                      // width:70,
                                                                      child: Text(
                                                                          coursesController.coursesListDrivers[i].passengersNum.toString() +
                                                                              '/' +
                                                                              coursesController.coursesListDrivers[i].seatingCapacity.toString(),
                                                                          style: TextStyle(fontSize: 13, fontFamily: 'Georgia', fontWeight: FontWeight.bold)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                if (coursesController
                                                                            .coursesListDrivers[
                                                                                i]
                                                                            .passengersDetails !=
                                                                        null &&
                                                                    coursesController
                                                                        .coursesListDrivers[
                                                                            i]
                                                                        .passengersDetails!
                                                                        .isNotEmpty) {
                                                                  Get.to(() =>
                                                                      CoursePassengerDetail(
                                                                          course:
                                                                              coursesController.coursesListDrivers[i]));
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    EditCourseScreen(
                                                                        record:
                                                                            coursesController.coursesListDrivers[i]));
                                                              },
                                                              child:
                                                                  Container(
                                                                height: 40,
                                                                width: 25,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  color: Color(
                                                                      0xFF0F5CA0),
                                                                  size: 23,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: ((builder) =>
                                                                        AlertDialog(
                                                                          content:
                                                                              Container(
                                                                            height: 100,
                                                                            width: 300,
                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                                                                            child: Center(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: <Widget>[
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 100,
                                                                                    child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                                      child: const Text(
                                                                                        'Delete',
                                                                                        style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        await coursesController.delete_course(coursesController.coursesListDrivers[i]);
                                                                                        coursesController.fetchCourses();
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 25,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 100,
                                                                                    child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0x0F5CA0).withOpacity(0.8), onPrimary: Colors.white),
                                                                                      child: const Text('Cancel', style: TextStyle(fontFamily: "Georgia", fontSize: 15)),
                                                                                      onPressed: () => Navigator.pop(context),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )));
                                                              },
                                                              child:
                                                                  Container(
                                                                height: 40,
                                                                width: 25,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child: Icon(
                                                                  Icons
                                                                      .delete,
                                                                  color: Color(
                                                                          0xFF000000)
                                                                      .withOpacity(
                                                                          0.54),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),




                                            SizedBox(height: 150,)
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                
                            
                            
                                : ListView(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                        ),
                                        color: Color(0xFF0F5CA0)
                                            .withOpacity(0.7),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          
                                          

                                          if (coursesController.coursesListTodayHistory.isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 35.0),
                                              child: Text(
                                                'Today',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: "Georgia",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          if (coursesController.coursesListTodayHistory.isNotEmpty)
                                            for (int i = 0;i <coursesController .coursesListTodayHistory.length; i++)
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Container(height:MediaQuery.of(context).size.height *  0.1,
                                                  width:   MediaQuery.of(context) .size.width * 0.9,
                                                  padding: EdgeInsets.only( left: 5, right: 5,  bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              courseHistory(
                                                                  context,
                                                                  coursesController
                                                                      .coursesListTodayHistory[i]);
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.85,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.065,
                                                              decoration: BoxDecoration(
                                                                  color: coursesController.coursesListTodayHistory[i].finished ==
                                                                          true
                                                                      ? Color(0xFF0F5CA0).withOpacity(
                                                                          0.5)
                                                                      : Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.8),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    width: 70,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesListTodayHistory[i].pickUpLocation.capitalize
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize: 13,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            2,
                                                                        width:
                                                                            30,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            5,
                                                                        width:
                                                                            5,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    width: 70,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesListTodayHistory[i].dropOffLocation!.capitalize
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize: 13,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  if (coursesController
                                                                          .coursesListTodayHistory[
                                                                              i]
                                                                          .finished ==
                                                                      true)
                                                                    Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color:
                                                                            Color(0xFF1590CF))
                                                                  else
                                                                    Icon(
                                                                      Icons
                                                                          .hourglass_full,
                                                                      color: Colors
                                                                          .grey[400],
                                                                    )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),



                                          if (coursesController
                                                  .coursesListYesterDayHistory
                                                  .length >
                                              0)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 35.0, top: 10),
                                              child: Text(
                                                'YesterDay',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: "Georgia",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          if (coursesController
                                              .coursesListYesterDayHistory
                                              .isNotEmpty)
                                            for (int i = 0;
                                                i <
                                                    coursesController
                                                        .coursesListYesterDayHistory
                                                        .length;
                                                i++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        left: 10),
                                                child: Container(
                                                  height:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.085,
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.9,
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              courseHistory(
                                                                  context,
                                                                  coursesController
                                                                      .coursesListYesterDayHistory[i]);
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.85,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.065,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                          0xFF0F5CA0)
                                                                      .withOpacity(
                                                                          0.5),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    width: 70,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesListYesterDayHistory[i].pickUpLocation.capitalize
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize: 15,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            2,
                                                                        width:
                                                                            30,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            5,
                                                                        width:
                                                                            5,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    width: 70,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesListYesterDayHistory[i].dropOffLocation!.capitalize
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize: 15,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),




                                          //----------------- Other Futur List Admin---------------------
                                          
                                          if (coursesController
                                              .coursesListOlderHistory
                                              .isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 35.0),
                                              child: Text(
                                                'Older',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontFamily: "Georgia",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          if (coursesController
                                              .coursesListOlderHistory
                                              .isNotEmpty)
                                            for (int i = 0;
                                                i <
                                                    coursesController
                                                        .coursesListOlderHistory
                                                        .length;
                                                i++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                        bottom: 0.0,
                                                        left: 10),
                                                child: Container(
                                                  height:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.085,
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.9,
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              courseHistory(
                                                                  context,
                                                                  coursesController
                                                                      .coursesListOlderHistory[i]);
                                                            },
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.85,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.065,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                          0xFF0F5CA0)
                                                                      .withOpacity(
                                                                          0.7),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        45,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    width: 70,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesListOlderHistory[i].pickUpLocation.capitalize
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize: 13,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            2,
                                                                        width:
                                                                            30,
                                                                        color:
                                                                            Colors.black,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            5,
                                                                        width:
                                                                            5,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    width: 70,
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          coursesController.coursesListOlderHistory[i].dropOffLocation!.capitalize
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize: 13,
                                                                            fontFamily: 'Georgia',
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                        ],
                                      ),
                                    ),
                                  ]))),
                  )
              ],
            ),
          ),
        ));
  }

  Future<dynamic> courseDetails(BuildContext context, Course course) {
    return showDialog(
        context: context,
        builder: (builder) => AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),


                    Container(
                      width: MediaQuery.of(context).size.width * 0.77,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),


                      child: Column(
                        children: [
                          _buildLabelValueRow("Luggage:",course.usedCollie.toString() +"/" +course.collie.toString(),Icons.card_travel_outlined),
                          _buildLabelValueRow("Driver:",course.driverName.toString() ,Icons.drive_eta_outlined),
                          _buildLabelValueRow("Reg.N°:",course.regNumber.toString() ,Icons.car_repair),
                          _buildLabelValuecolumn("Pick-up Location", course.pickUpLocation, Icons.location_on_outlined),
                          _buildLabelValuecolumn("Drop-off Location", course.dropOffLocation,  Icons.location_on_outlined),

                        ],
                      ),
                    ),


                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        showCheckListCarDetails(context, course);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        height: 42,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.car_crash_outlined,
                                color: Colors.white
                              ),
                              SizedBox(
                                width:8,
                              ),
                              Text(
                                "Car Checklist",
                                style: TextStyle(color: Colors.white),
                              )
                            ]),
                            // if ((course.carImage1URL != null &&
                            //     course.carImage1URL != "") ||
                            //     (course.carImage2URL != null &&
                            //         course.carImage2URL != "") ||
                            //     (course.carImage3URL != null &&
                            //         course.carImage3URL != "") ||
                            //     (course.carImage4URL != null &&
                            //         course.carImage4URL != "") ||
                            //     (course.carListDetails != null &&
                            //         course.carListDetails!.length > 0))
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.white,
                              // size: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      // height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Pick up Date',
                              style: TextStyle(
                                  fontFamily: "Gidugu",
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                          Flexible(
                            child: Center(
                              child: Text(
                                  DateFormat("d MMM y 'At' h:mm a")
                                      .format(course.pickUpDate),
                                  style: TextStyle(
                                      fontFamily: "Gidugu",
                                      fontSize: 13,
                                      color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (course.dropOffDate != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    if (course.dropOffDate != null)
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        // height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Drop off Date',
                                style: TextStyle(
                                    fontFamily: "Gidugu",
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: Text(
                                    DateFormat("d MMM y 'At' h:mm a")
                                        .format(course.dropOffDate!),
                                    style: TextStyle(
                                        fontFamily: "Gidugu",
                                        fontSize: 13,
                                        color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    if (course.check == "car" && course.orderUrl != null)
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.77,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              String pdfUrl = course.orderUrl!;
                              download(pdfUrl);
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mission Order file',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "Gidugu"),
                              ),
                              Icon(
                                Icons.file_download_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    // if(coursesController.coursesListToday.contains(course)
                    // || coursesController.coursesListTodayDrivers.contains(course))
                    //   Center(
                    //     child: GestureDetector(
                    //         onTap: (){
                    //           coursesController.courses.doc(course.id).update({
                    //             "finished":true
                    //           }).then((value){
                    //             coursesController
                    //           .fetchCourses();
                    //             Navigator.pop(context);
                    //           });
                    //         },
                    //         child: Container(
                    //           height:MediaQuery.of(context).size.height*0.05,
                    //             width: MediaQuery.of(context).size.width*0.3,
                    //             decoration: BoxDecoration(
                    //               color: Color(0xFF0F5CA0).withOpacity(0.8),
                    //               borderRadius: BorderRadius.circular(20)
                    //             ),
                    //             child: Center(child: Text("Finish",style:TextStyle(color:Colors.white),))
                    //         )
                    //     ),
                    //   )
                  ],
                ),
              ),
            ));
  }
  Future<dynamic> courseHistory(BuildContext context, Course course) {
    return showDialog(
        context: context,
        builder: (builder) => AlertDialog(
              content: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),


                    Container(
                      width: MediaQuery.of(context).size.width * 0.77,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),


                      child: Column(
                        children: [
                          _buildLabelValueRow("Luggage:",course.usedCollie.toString() +"/" +course.collie.toString(),Icons.card_travel_outlined),
                          _buildLabelValueRow("Driver:",course.driverName.toString() ,Icons.drive_eta_outlined),
                          _buildLabelValueRow("Reg.N°:",course.regNumber.toString() ,Icons.car_repair),
                          _buildLabelValuecolumn("Pick-up Location", course.pickUpLocation, Icons.location_on_outlined),
                          _buildLabelValuecolumn("Drop-off Location", course.dropOffLocation,  Icons.location_on_outlined),

                        ],
                      ),
                    ),


                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (course.passengersDetails != null &&
                            course.passengersDetails!.isNotEmpty)
                        showPaassengerDetails(context, course);

                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        height: 42,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                  Icons.people_alt_outlined,
                                  color: Colors.white
                              ),
                              SizedBox(
                                width:8,
                              ),
                              Text(
                                 "Passenger: "+ course.passengersNum.toString()+ "/"+course.seatingCapacity.toString(),
                                style: TextStyle(color: Colors.white),
                              )
                            ]),
                            // if ((course.carImage1URL != null &&
                            //     course.carImage1URL != "") ||
                            //     (course.carImage2URL != null &&
                            //         course.carImage2URL != "") ||
                            //     (course.carImage3URL != null &&
                            //         course.carImage3URL != "") ||
                            //     (course.carImage4URL != null &&
                            //         course.carImage4URL != "") ||
                            //     (course.carListDetails != null &&
                            //         course.carListDetails!.length > 0))
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.white,
                              // size: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () {
                        if ((course.carImage1URL != null &&
                            course.carImage1URL != "") ||
                            (course.carImage2URL != null &&
                                course.carImage2URL != "") ||
                            (course.carImage3URL != null &&
                                course.carImage3URL != "") ||
                            (course.carImage4URL != null &&
                                course.carImage4URL != "") ||
                            (course.carListDetails != null &&
                                course.carListDetails!.length > 0))
                        showCheckListCarDetails(context, course);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        height: 42,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.car_crash_outlined,
                                color: Colors.white
                              ),
                              SizedBox(
                                width:8,
                              ),
                              Text(
                                "Car Checklist",
                                style: TextStyle(color: Colors.white),
                              )
                            ]),
                            // if ((course.carImage1URL != null &&
                            //     course.carImage1URL != "") ||
                            //     (course.carImage2URL != null &&
                            //         course.carImage2URL != "") ||
                            //     (course.carImage3URL != null &&
                            //         course.carImage3URL != "") ||
                            //     (course.carImage4URL != null &&
                            //         course.carImage4URL != "") ||
                            //     (course.carListDetails != null &&
                            //         course.carListDetails!.length > 0))
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.white,
                              // size: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      // height: MediaQuery.of(context).size.height * .08,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Pick up Date',
                              style: TextStyle(
                                  fontFamily: "Gidugu",
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                          Flexible(
                            child: Center(
                              child: Text(
                                  DateFormat("d MMM y 'At' h:mm a")
                                      .format(course.pickUpDate),
                                  style: TextStyle(
                                      fontFamily: "Gidugu",
                                      fontSize: 13,
                                      color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (course.dropOffDate != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    if (course.dropOffDate != null)
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        // height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Drop off Date',
                                style: TextStyle(
                                    fontFamily: "Gidugu",
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: Text(
                                    DateFormat("d MMM y 'At' h:mm a")
                                        .format(course.dropOffDate!),
                                    style: TextStyle(
                                        fontFamily: "Gidugu",
                                        fontSize: 13,
                                        color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    if (course.check == "car" && course.orderUrl != null)
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.77,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              String pdfUrl = course.orderUrl!;
                              download(pdfUrl);
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mission Order file',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "Gidugu"),
                              ),
                              Icon(
                                Icons.file_download_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    // if(coursesController.coursesListToday.contains(course)
                    // || coursesController.coursesListTodayDrivers.contains(course))
                    //   Center(
                    //     child: GestureDetector(
                    //         onTap: (){
                    //           coursesController.courses.doc(course.id).update({
                    //             "finished":true
                    //           }).then((value){
                    //             coursesController
                    //           .fetchCourses();
                    //             Navigator.pop(context);
                    //           });
                    //         },
                    //         child: Container(
                    //           height:MediaQuery.of(context).size.height*0.05,
                    //             width: MediaQuery.of(context).size.width*0.3,
                    //             decoration: BoxDecoration(
                    //               color: Color(0xFF0F5CA0).withOpacity(0.8),
                    //               borderRadius: BorderRadius.circular(20)
                    //             ),
                    //             child: Center(child: Text("Finish",style:TextStyle(color:Colors.white),))
                    //         )
                    //     ),
                    //   )
                  ],
                ),
              ),
            ));
  }

  Future<dynamic> showPaassengerDetails(BuildContext context, Course course) {
    return showModalBottomSheet(
                          context: context,
                          builder: (BuildContext ctx) {
                            return Container(
                                height:
                                MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.53,
                                child:
                                SingleChildScrollView(
                                  scrollDirection:
                                  Axis.vertical,
                                  child:
                                  SingleChildScrollView(
                                    scrollDirection:
                                    Axis.horizontal,
                                    child: Column(
                                      children: [
                                        DataTable(
                                          columnSpacing:
                                          10,
                                          dataRowHeight:
                                          50,
                                          columns: const <DataColumn>[
                                            DataColumn(
                                              label:
                                              Expanded(
                                                child:
                                                Text(
                                                  'First Name',
                                                  style: TextStyle(
                                                      fontStyle:
                                                      FontStyle.italic),
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label:
                                              Expanded(
                                                child:
                                                Text(
                                                  'Last Name',
                                                  style: TextStyle(
                                                      fontStyle:
                                                      FontStyle.italic),
                                                ),
                                              ),
                                            ),
                                            DataColumn(
                                              label:
                                              Expanded(
                                                child:
                                                Text(
                                                  'Phone Number',
                                                  style: TextStyle(
                                                      fontStyle:
                                                      FontStyle.italic),
                                                ),
                                              ),
                                              numeric:
                                              true,
                                            ),
                                            DataColumn(
                                              label:
                                              Expanded(
                                                child:
                                                Text(
                                                  'State',
                                                  style: TextStyle(
                                                      fontStyle:
                                                      FontStyle.italic),
                                                ),
                                              ),
                                              numeric:
                                              true,
                                            ),
                                          ],
                                          rows: List<
                                              DataRow>.generate(
                                              course
                                                  .passengersDetails!
                                                  .length,
                                                  (int index) =>
                                                  DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(Text(course.passengersDetails![index].firstname)),
                                                        DataCell(Text(course.passengersDetails![index].lastName)),
                                                        (course.passengersDetails![index].phoneNum.contains('.') && course.passengersDetails![index].phoneNum.endsWith('.0')) ? DataCell(Text(course.passengersDetails![index].phoneNum.substring(0, course.passengersDetails![index].phoneNum.indexOf('.')))) : DataCell(Text(course.passengersDetails![index].phoneNum.toString())),
                                                        DataCell(Checkbox(value: course.passengersDetails![index].state, onChanged: (value) {}))
                                                      ])),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          });
  }

  Future<dynamic> showCheckListCarDetails(BuildContext context, Course course) {
    return showModalBottomSheet(
                                    context: context,
                                    builder:
                                        (BuildContext context) {print(course.carListDetails);
                                      return Container(
                                        padding: EdgeInsets.symmetric(vertical: 32,horizontal: 8),
                                          height:
                                          MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.53,
                                          width:
                                          MediaQuery.of(context)
                                              .size
                                              .width,
                                          child:
                                          SingleChildScrollView(
                                            scrollDirection:
                                            Axis.vertical,
                                            child:
                                            SingleChildScrollView(
                                                scrollDirection:
                                                Axis.horizontal,
                                                child: Column(
                                                  children: [
                                                    if (course.carListDetails !=
                                                        null &&
                                                        course.carListDetails!.length >
                                                            0)
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 120,
                                                                height: 48,
                                                                decoration: BoxDecoration(color: Color(0xFF0F5CA0).withOpacity(0.7), borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text('legend',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            16,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![0].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![0].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![1].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![1].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![2].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![2].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![4].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![4].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![3].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![3].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![5].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![5].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![6].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![6].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![7].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![7].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![8].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![8].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![9].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![9].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![10].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![10].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![11].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![11].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![12].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![12].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![13].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![13].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![14].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![14].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 150,
                                                                // height: 30,
                                                                margin: EdgeInsets.symmetric(vertical: 8),
                                                                padding: EdgeInsets.all(8),
                                                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                                                                child: Center(child: Text(course.carListDetails![15].name)),
                                                              ),
                                                              GFCheckbox(
                                                                size: 30,
                                                                value: course.carListDetails![15].state,
                                                                onChanged: (bool value) {},
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    else
                                                      Center(child: Text("the car checklist is empty",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),)
                                                    ,SizedBox(
                                                      height: 5,
                                                    ),
                                                    if ((course.carImage1URL !=
                                                        null &&
                                                        course.carImage1URL !=
                                                            "") ||
                                                        (course.carImage2URL !=
                                                            null &&
                                                            course.carImage2URL !=
                                                                ""))
                                                      Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        child:
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            if (course.carImage1URL != null &&
                                                                course.carImage1URL != "")
                                                              GestureDetector(
                                                                child: Container(
                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                  height: MediaQuery.of(context).size.height * 0.1,
                                                                  decoration: BoxDecoration(color: Color(0xFF0F5CA0).withOpacity(0.6), borderRadius: BorderRadius.circular(5)),
                                                                  child: Image.network(
                                                                    course.carImage1URL!,
                                                                    fit: BoxFit.fill,
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (builder) => AlertDialog(
                                                                        content: CarDetail(course.carImage1URL!),
                                                                      ));
                                                                },
                                                              ),
                                                            if (course.carImage2URL != null &&
                                                                course.carImage2URL != "")
                                                              GestureDetector(
                                                                child: Container(
                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                  height: MediaQuery.of(context).size.height * 0.1,
                                                                  decoration: BoxDecoration(color: Color(0xFF0F5CA0).withOpacity(0.6), borderRadius: BorderRadius.circular(5)),
                                                                  child: Image.network(
                                                                    course.carImage2URL!,
                                                                    fit: BoxFit.fill,
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (builder) => AlertDialog(
                                                                        content: CarDetail(course.carImage2URL!),
                                                                      ));
                                                                },
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    if ((course.carImage3URL !=
                                                        null &&
                                                        course.carImage3URL !=
                                                            "") ||
                                                        (course.carImage4URL !=
                                                            null &&
                                                            course.carImage4URL !=
                                                                ""))
                                                      Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                        child:
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            if (course.carImage3URL != null &&
                                                                course.carImage3URL != "")
                                                              GestureDetector(
                                                                  child: Container(
                                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                    decoration: BoxDecoration(color: Color(0xFF0F5CA0).withOpacity(0.6), borderRadius: BorderRadius.circular(5)),
                                                                    child: Image.network(
                                                                      course.carImage3URL!,
                                                                      fit: BoxFit.fill,
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (builder) => AlertDialog(
                                                                          content: CarDetail(course.carImage3URL!),
                                                                        ));
                                                                  }),
                                                            if (course.carImage4URL != null &&
                                                                course.carImage4URL != "")
                                                              GestureDetector(
                                                                  child: Container(
                                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                                    height: MediaQuery.of(context).size.height * 0.1,
                                                                    decoration: BoxDecoration(color: Color(0xFF0F5CA0).withOpacity(0.6), borderRadius: BorderRadius.circular(5)),
                                                                    child: Image.network(
                                                                      course.carImage4URL!,
                                                                      fit: BoxFit.fill,
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (builder) => AlertDialog(
                                                                          content: CarDetail(course.carImage4URL!),
                                                                        ));
                                                                  }),
                                                          ],
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                )),
                                          ));
                                    });
  }


  /////////////////////////add to driver code////////////////////////////////////
  Future<dynamic> coursesHistoryDetails(BuildContext context, Course course) {
    print(course.id);
    return showDialog(
        context: context,
        builder: (builder) => AlertDialog(
              content: Container(
                // height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    Container(
                      // height: coursesController.formNum.value == 2
                      //     ? MediaQuery.of(context).size.height * 0.6
                      //     : MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.77,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFF0F5CA0).withOpacity(0.6)),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icons/arrow.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          course.pickUpLocation,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.6,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Icon(
                                          Icons.location_on,
                                          color: Color(0xFF0F5CA0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          course.dropOffLocation,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.6,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                              child: Icon(
                                            Icons.person,
                                            color: Color(0xFF0F5CA0),
                                          )),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                        Text(
                                          course.passengersNum.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    //////////////////////////add to driver ///////////////////////////////////
                                    if (course.passengersDetails != null &&
                                        course.passengersDetails!.isNotEmpty)
                                      //////////////////////////add to driver ///////////////////////////////////
                                      IconButton(
                                          onPressed: () {
                                            showPaassengerDetails(context, course);
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                            size: 25,
                                          ))
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.6,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icons/balance.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Text(
                                      course.seatingCapacity.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.6,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.58,
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       course.usedLuggageBigSize.toString()+
                                    //           "/"+course.luggageBigSize.toString(),
                                    //       style: TextStyle(
                                    //           color: Colors.white
                                    //       ),
                                    //     ),
                                    //     Icon(
                                    //         Icons.luggage_outlined,
                                    //         color: Colors.white
                                    //     ),
                                    //   ],
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       course.usedLuggageMediumSize.toString()
                                    //           +"/"+course.luggageMediumSize.toString(),
                                    //       style: TextStyle(
                                    //           color: Colors.white
                                    //       ),),
                                    //     Icon(Icons.luggage,size: 20,color: Colors.white
                                    //     ),
                                    //   ],
                                    // ),
                                    Text('Luggage',
                                        style: TextStyle(color: Colors.white)),
                                    Row(
                                      children: [
                                        Text(
                                          course.usedCollie.toString() +
                                              "/" +
                                              course.collie.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        // Icon(
                                        //     Icons.mark_email_unread_sharp,
                                        //     color: Colors.white
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.6,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icons/driver_blue.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                    ),
                                    Text(
                                      course.driverName,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.6,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05,
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                            child: FaIcon(
                                          FontAwesomeIcons.car,
                                          color: Color(0xFF0F5CA0),
                                        )),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      Text(
                                        course.regNumber,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ]),
                                    if ((course.carImage1URL != null &&
                                            course.carImage1URL != "") ||
                                        (course.carImage2URL != null &&
                                            course.carImage2URL != "") ||
                                        (course.carImage3URL != null &&
                                            course.carImage3URL != "") ||
                                        (course.carImage4URL != null &&
                                            course.carImage1URL != "") ||
                                        (course.carListDetails != null &&
                                            course.carListDetails!.length > 0))
                                      IconButton(
                                          onPressed: () {
                                            showCheckListCarDetails(context, course);
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                            size: 25,
                                          ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Container(
                                color: Colors.white,
                                height: 2,
                                width: MediaQuery.of(context).size.width * 0.6,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),


                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.01,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      // height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.77,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFF0F5CA0).withOpacity(0.6)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'Pick up Date',
                              style: TextStyle(
                                  fontFamily: "Gidugu",
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                          Flexible(
                            child: Center(
                              child: Text(
                                  DateFormat("d MMM y 'At' h:mm a")
                                      .format(course.pickUpDate),
                                  style: TextStyle(
                                      fontFamily: "Gidugu",
                                      fontSize: 13,
                                      color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (course.dropOffDate != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    if (course.dropOffDate != null)
                      Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.01,
                          right: MediaQuery.of(context).size.width * 0.05,
                        ),
                        // height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.77,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF0F5CA0).withOpacity(0.6)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Drop off Date',
                                style: TextStyle(
                                    fontFamily: "Gidugu",
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: Text(
                                    DateFormat("d MMM y 'At' h:mm a")
                                        .format(course.dropOffDate!),
                                    style: TextStyle(
                                        fontFamily: "Gidugu",
                                        fontSize: 13,
                                        color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    if (course.check == "car" && course.orderUrl != null)
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.01,
                            right: MediaQuery.of(context).size.width * 0.05,
                          ),
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.77,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF0F5CA0).withOpacity(0.6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mission Order file',
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "Gidugu"),
                              ),
                              Icon(
                                Icons.file_download_outlined,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          print(course.orderUrl);
                          try {
                            String pdfUrl = course.orderUrl!;
                            download(pdfUrl);
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                      )
                  ],
                ),
              ),
            ));
  }

  Widget CarDetail(String carUrl) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: Color(0xFF0F5CA0).withOpacity(0.6),
                borderRadius: BorderRadius.circular(5)),
            child: PhotoView(
              imageProvider: NetworkImage(
                carUrl!,
                // fit: BoxFit.fill,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.01,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.77,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF0F5CA0).withOpacity(0.6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'download car Image',
                    style: TextStyle(color: Colors.white, fontFamily: "Gidugu"),
                  ),
                  Icon(
                    Icons.file_download_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            onTap: () async {
              try {
                String downloadcarUrl = carUrl!;
                downloadCarImage(downloadcarUrl);
              } catch (e) {
                print(e.toString());
              }
            },
          )
        ],
      ),
    );
  }

  static void openGoogleMaps(String address) async {
    final Uri googleMapsUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$address");
    if (!await launchUrl(googleMapsUrl)) {
      throw Exception('Could not launch $googleMapsUrl');
    }
    return;

  }
  static Widget _buildLabelValueRow(String label, String value, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              SizedBox(width: 8), // Add some spacing between icon and text
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
  static Widget _buildLabelValuecolumn(String label, String value, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
      child: GestureDetector(
        onTap: ()=>openGoogleMaps(value),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    iconData,
                    color: Colors.greenAccent,
                  ),
                  // SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black))
                    ),
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  static Widget _buildDateValuecolumn(String label, String value, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                iconData,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
