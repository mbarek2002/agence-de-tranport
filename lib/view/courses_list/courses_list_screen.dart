import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/course.dart';
import 'package:admin_citygo/view/courses_list/add_course.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/courses_list/edit_course.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  }

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
            print("add");
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
              "Courses List",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Georgia"),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(tHomebackground))),
              child: Column(
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
                    height: 50,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.665,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Obx(() => RefreshIndicator(
                        onRefresh: () {
                          try {
                            coursesController.fetchCourses();
                            print(coursesController.coursesList.length);
                          } catch (e) {
                            print(e.toString);
                          }
                          return Future.delayed(Duration(seconds: 1));
                        },
                        child: ListView(
                          children: [
                            Container(
                              color: Color(0xFF0F5CA0).withOpacity(0.7),
                              height: 350,
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
                                    child: Text(
                                      'Tomorrow',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Georgia",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  for (int i = 0; i < coursesController.coursesListTomorrow.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 88,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        width: 55,
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListTomorrow[
                                                                      i]
                                                                  .pickUpLocation
                                                                  .capitalize
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Georgia',
                                                              )),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 2,
                                                            width: 50,
                                                            color: Colors.black,
                                                          ),
                                                          Container(
                                                            height: 5,
                                                            width: 5,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 55,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListTomorrow[
                                                                      i]
                                                                  .dropOffLocation!
                                                                  .capitalize
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Georgia',
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: 60,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .people_alt_outlined,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                            coursesController
                                                                    .coursesListTomorrow[
                                                                        i]
                                                                    .passengersNum
                                                                    .toString() +
                                                                '/' +
                                                                coursesController
                                                                    .coursesListTomorrow[
                                                                        i]
                                                                    .seatingCapacity
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Georgia',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // Get.to(()=>EditCourseScreen(record: coursesController.coursesList[index]));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    // decoration: BoxDecoration(
                                                    //     image: DecorationImage(
                                                    //         image: AssetImage(
                                                    //             "assets/icons/edit.png"
                                                    //         )
                                                    //     )
                                                    // ),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Color(0xFF0F5CA0),
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
                                                        context: context,
                                                        builder:
                                                            ((builder) =>
                                                                AlertDialog(
                                                                  content:
                                                                      Container(
                                                                    height: 100,
                                                                    width: 300,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(40),
                                                                            topRight: Radius.circular(40))),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: <Widget>[
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                              child: const Text(
                                                                                'Delete',
                                                                                style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                              ),
                                                                              onPressed: () {
                                                                                coursesController.delete_course(coursesController.coursesListTomorrow[i].id!);
                                                                                coursesController.fetchCourses();
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                25,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                ElevatedButton(
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
                                                  child: Container(
                                                    height: 40,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Color(0xFF000000)
                                                          .withOpacity(0.54),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
                                    child: Text(
                                      'Today',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Georgia",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  for (int i = 0; i <coursesController.coursesListToday.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 88,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        width: 55,
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListToday[
                                                                      i]
                                                                  .pickUpLocation
                                                                  .capitalize
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Georgia',
                                                              )),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 2,
                                                            width: 50,
                                                            color: Colors.black,
                                                          ),
                                                          Container(
                                                            height: 5,
                                                            width: 5,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 55,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListToday[
                                                                      i]
                                                                  .dropOffLocation!
                                                                  .capitalize
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Georgia',
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: 60,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .people_alt_outlined,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                            coursesController
                                                                    .coursesListToday[
                                                                        i]
                                                                    .passengersNum
                                                                    .toString() +
                                                                '/' +
                                                                coursesController
                                                                    .coursesListToday[
                                                                        i]
                                                                    .seatingCapacity
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Georgia',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // Get.to(()=>EditCourseScreen(record: coursesController.coursesList[index]));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    // decoration: BoxDecoration(
                                                    //     image: DecorationImage(
                                                    //         image: AssetImage(
                                                    //             "assets/icons/edit.png"
                                                    //         )
                                                    //     )
                                                    // ),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Color(0xFF0F5CA0),
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
                                                        context: context,
                                                        builder:
                                                            ((builder) =>
                                                                AlertDialog(
                                                                  content:
                                                                      Container(
                                                                    height: 100,
                                                                    width: 300,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(40),
                                                                            topRight: Radius.circular(40))),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: <Widget>[
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                              child: const Text(
                                                                                'Delete',
                                                                                style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                              ),
                                                                              onPressed: () {
                                                                                coursesController.delete_course(coursesController.coursesListTomorrow[i].id!);
                                                                                coursesController.fetchCourses();
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                25,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                ElevatedButton(
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
                                                  child: Container(
                                                    height: 40,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Color(0xFF000000)
                                                          .withOpacity(0.54),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
                                    child: Text(
                                      'Last 10 days',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Georgia",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  for (int i = 0;i < coursesController.coursesList.length;i++)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, left: 10),
                                      child: Container(
                                        height: 88,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        width: 55,
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesList[
                                                                      i]
                                                                  .pickUpLocation
                                                                  .capitalize
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Georgia',
                                                              )),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 2,
                                                            width: 50,
                                                            color: Colors.black,
                                                          ),
                                                          Container(
                                                            height: 5,
                                                            width: 5,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 55,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesList[
                                                                      i]
                                                                  .dropOffLocation!
                                                                  .capitalize
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Georgia',
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: 60,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .people_alt_outlined,
                                                          size: 20,
                                                        ),
                                                        Text(
                                                            coursesController
                                                                    .coursesList[
                                                                        i]
                                                                    .passengersNum
                                                                    .toString() +
                                                                '/' +
                                                                coursesController
                                                                    .coursesList[
                                                                        i]
                                                                    .seatingCapacity
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'Georgia',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // Get.to(()=>EditCourseScreen(record: coursesController.coursesList[index]));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    // decoration: BoxDecoration(
                                                    //     image: DecorationImage(
                                                    //         image: AssetImage(
                                                    //             "assets/icons/edit.png"
                                                    //         )
                                                    //     )
                                                    // ),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Color(0xFF0F5CA0),
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
                                                        context: context,
                                                        builder:
                                                            ((builder) =>
                                                                AlertDialog(
                                                                  content:
                                                                      Container(
                                                                    height: 100,
                                                                    width: 300,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(40),
                                                                            topRight: Radius.circular(40))),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: <Widget>[
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(elevation: 20, shadowColor: Colors.blue[700], primary: Color(0xDADADA).withOpacity(0.69), onPrimary: Colors.white),
                                                                              child: const Text(
                                                                                'Delete',
                                                                                style: TextStyle(fontFamily: "Georgia", fontSize: 15),
                                                                              ),
                                                                              onPressed: () {
                                                                                coursesController.delete_course(coursesController.coursesListTomorrow[i].id!);
                                                                                coursesController.fetchCourses();
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                25,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                100,
                                                                            child:
                                                                                ElevatedButton(
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
                                                  child: Container(
                                                    height: 40,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Color(0xFF000000)
                                                          .withOpacity(0.54),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )

                                  // Container(
                                  //   color: Color(0xFF0F5CA0).withOpacity(0.54),
                                  //   child: ListView.builder(
                                  //   itemCount:coursesController.coursesList.length,
                                  //   itemBuilder: (BuildContext context,int index){
                                  //     try{
                                  //       return Padding(
                                  //         padding: const EdgeInsets.only(bottom: 18.0),
                                  //         child: Container(
                                  //           height: 88,
                                  //           width: MediaQuery.of(context).size.width*0.9,
                                  //           padding: EdgeInsets.only(
                                  //               left:5,
                                  //               right: 5,
                                  //               bottom: 15
                                  //           ),
                                  //           child: Row(
                                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //             children: [
                                  //               Row(
                                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //                 children: [
                                  //                   Container(
                                  //                     width:200,
                                  //                     height: 40,
                                  //                     decoration: BoxDecoration(
                                  //                         color:Colors.white.withOpacity(0.8),
                                  //                         borderRadius: BorderRadius.circular(5)
                                  //                     ),
                                  //                     child: Row(
                                  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  //                       children: [
                                  //                         Container(
                                  //                           padding: const EdgeInsets.only(bottom:8.0),
                                  //                           width: 55,
                                  //                           child: Center(
                                  //                             child: Text(
                                  //                                 coursesController.coursesList[index].pickUpLocation.capitalize.toString(),
                                  //                                 style: TextStyle(
                                  //                                   fontSize: 15,
                                  //                                   fontFamily: 'Georgia',
                                  //                                 )),
                                  //                           ),
                                  //                         ),
                                  //                         Row(
                                  //                           children: [
                                  //                             Container(
                                  //                               height: 2,
                                  //                               width: 50,
                                  //                               color: Colors.black,
                                  //                             ),
                                  //                             Container(
                                  //                               height: 5,
                                  //                               width: 5,
                                  //                               decoration: BoxDecoration(
                                  //                                 shape: BoxShape.circle,
                                  //                                 color: Colors.black,
                                  //                               ),
                                  //                             ),
                                  //                           ],
                                  //                         ),
                                  //                         Container(
                                  //                           width: 55,
                                  //                           padding: const EdgeInsets.only(bottom:8.0),
                                  //                           child: Center(
                                  //                             child: Text(
                                  //                                 coursesController.coursesList[index].dropOffLocation!.capitalize.toString(),
                                  //                                 style: TextStyle(
                                  //                                   fontSize: 15,
                                  //                                   fontFamily: 'Georgia',
                                  //                                 )),
                                  //                           ),
                                  //                         ),
                                  //                       ],
                                  //                     ),
                                  //                   ),
                                  //                   SizedBox(width: 5),
                                  //                   Container(
                                  //                     width:60,
                                  //                     height: 40,
                                  //                     decoration: BoxDecoration(
                                  //                         color:Colors.white.withOpacity(0.8),
                                  //                         borderRadius: BorderRadius.circular(5)
                                  //                     ),
                                  //                     child: Center(
                                  //                       child: Row(
                                  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //                         children: [
                                  //                           Icon(Icons.people_alt_outlined,size: 20,),
                                  //
                                  //                           Text(
                                  //                               coursesController.coursesList[index].passengersNum.toString()+'/'
                                  //                               +coursesController.coursesList[index].seatingCapacity.toString(),
                                  //                               style: TextStyle(
                                  //                                   fontSize: 18,
                                  //                                   fontFamily: 'Georgia',
                                  //                                   fontWeight: FontWeight.bold
                                  //                               )
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //               Row(
                                  //                 children: [
                                  //                   GestureDetector(
                                  //                     onTap: (){
                                  //                       // Get.to(()=>EditCourseScreen(record: coursesController.coursesList[index]));
                                  //                     },
                                  //                     child: Container(
                                  //                       height:40,
                                  //                       width:25,
                                  //                       decoration: BoxDecoration(
                                  //                         color: Colors.white,
                                  //
                                  //                         borderRadius: BorderRadius.circular(5)
                                  //                       ),
                                  //                       // decoration: BoxDecoration(
                                  //                       //     image: DecorationImage(
                                  //                       //         image: AssetImage(
                                  //                       //             "assets/icons/edit.png"
                                  //                       //         )
                                  //                       //     )
                                  //                       // ),
                                  //                       child: Icon(Icons.edit,color: Color(0xFF0F5CA0),size: 23,),
                                  //                     ),
                                  //                   ),
                                  //                   SizedBox(width: 5,),
                                  //                   GestureDetector(
                                  //                     onTap:  () {
                                  //                       showDialog(
                                  //                           context: context,
                                  //                           builder: ((builder)=>
                                  //                               AlertDialog(
                                  //                                 content: Container(
                                  //                                   height: 100,
                                  //                                   width: 300,
                                  //                                   decoration: BoxDecoration(
                                  //                                       borderRadius: BorderRadius.only(
                                  //                                           topLeft: Radius.circular(40),
                                  //                                           topRight: Radius.circular(40)
                                  //                                       )
                                  //                                   ),
                                  //                                   child: Center(
                                  //                                     child: Row(
                                  //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //                                       mainAxisSize: MainAxisSize.min,
                                  //                                       children: <Widget>[
                                  //                                         SizedBox(height: 10,),
                                  //                                         SizedBox(
                                  //                                           width: 100,
                                  //                                           child: ElevatedButton(
                                  //                                             style: ElevatedButton.styleFrom(
                                  //                                                 elevation: 20,
                                  //                                                 shadowColor: Colors.blue[700],
                                  //                                                 primary: Color(0xDADADA).withOpacity(0.69),
                                  //                                                 onPrimary: Colors.white
                                  //                                             ),
                                  //                                             child: const Text('Delete',style: TextStyle(fontFamily: "Georgia",fontSize: 15),),
                                  //                                             onPressed: (){
                                  //                                               coursesController.delete_course(coursesController.coursesList[index].id!);
                                  //                                               coursesController.fetchCourses();
                                  //                                               Navigator.pop(context);
                                  //                                             },
                                  //                                           ),
                                  //                                         ),
                                  //                                         SizedBox(width: 25,),
                                  //                                         SizedBox(
                                  //                                           width: 100,
                                  //                                           child: ElevatedButton(
                                  //                                             style: ElevatedButton.styleFrom(
                                  //                                                 elevation: 20,
                                  //                                                 shadowColor: Colors.blue[700],
                                  //                                                 primary: Color(0x0F5CA0).withOpacity(0.8),
                                  //                                                 onPrimary: Colors.white
                                  //                                             ),
                                  //                                             child: const Text('Cancel',style: TextStyle(fontFamily: "Georgia",fontSize: 15)),
                                  //                                             onPressed: () => Navigator.pop(context),
                                  //                                           ),
                                  //                                         ),
                                  //                                       ],
                                  //                                     ),
                                  //                                   ),
                                  //                                 ),
                                  //                               )
                                  //                           )
                                  //                       );
                                  //                     },
                                  //                     child: Container(
                                  //                       height:40,
                                  //                       width:25,
                                  //                       decoration: BoxDecoration(
                                  //                           color: Colors.white,
                                  //
                                  //                           borderRadius: BorderRadius.circular(5)
                                  //                       ),
                                  //                       child: Icon(
                                  //                         Icons.delete,color: Color(0xFF000000).withOpacity(0.54),
                                  //                       ),
                                  //                     ),
                                  //                   )
                                  //                 ],
                                  //               )
                                  //
                                  //
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       );
                                  //     }catch(e){
                                  //     print(e.toString);
                                  //     }
                                  //     },
                                  //   )
                                  //
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: CircleAvatar(
                                  backgroundColor:
                                      Color(0xFF0F5CA0).withOpacity(0.7),
                                  child: Image.asset(
                                      "assets/icons/driver_black.png")),
                            ),
                            SizedBox(height: 10),
                            Container(
                              color: Color(0xFF0F5CA0).withOpacity(0.7),
                              height: 170,
                              child: ListView(
                                children: [
                                  Text('dshufuiosdg'),
                                  Text('dshufuiosdg'),
                                  Text('dshufuiosdg'),
                                  Text('dshufuiosdg'),
                                  Text('dshufuiosdg'),
                                  Text('dshufuiosdg'),
                                  Text('dshufuiosdg'),
                                ],
                              ),
                            )
                          ],
                        ))),
                  )
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .04,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image:
                            NetworkImage(loginController.adminImageUrl.value),
                        fit: BoxFit.cover),
                  ),
                  child: GestureDetector(
                    onTap: () => Get.offAll(() => HomeScreen()),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
