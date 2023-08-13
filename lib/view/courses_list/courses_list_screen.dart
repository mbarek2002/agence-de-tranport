import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/view/courses_list/add_course.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/courses_list/edit_course.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    loginController.getAdminImage(loginController.emailController.text);
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
              child: Obx(() =>
              Column(
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
                    height: 40,
                  ),
                  Container(
                  width: MediaQuery.of(context).size.width*0.95,
                    child: TextFormField(
                      onChanged: (value)=>coursesController.filter(value),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        hintText:"search by name , identity card",
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
                    height: 10,
                  ),
                  if(coursesController.isLoading.value)
                  Center(child:CircularProgressIndicator())
                  else Container(
                    height: MediaQuery.of(context).size.height * 0.615,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child:RefreshIndicator(
                        onRefresh: () {
                          try {
                            coursesController.fetchCourses();
                          } catch (e) {
                            print(e.toString);
                          }
                          return Future.delayed(Duration(seconds: 1));
                        },
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(5),
                                color: Color(0xFF0F5CA0).withOpacity(0.7),

                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(coursesController.coursesListTomorrow.length>0)Padding(
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
                                  for (int i = 0; i <coursesController.coursesListTomorrow.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 5),
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
                                                  height: 48,
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
                                                        width: 70,
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListTomorrow[i]
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
                                                            width: 30,
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
                                                        width: 70,
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
                                                  width: 65,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.people_alt_outlined,
                                                        size: 20,
                                                      ),
                                                      Container(
                                                        // width:70,
                                                        child: Text(
                                                            coursesController
                                                                    .coursesListTomorrow[i]
                                                                    .passengersNum
                                                                    .toString() +
                                                                '/' +
                                                                coursesController
                                                                    .coursesListTomorrow[i]
                                                                    .seatingCapacity
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Georgia',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(()=>EditCourseScreen(record: coursesController.coursesListTomorrow[i]));
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
                                  if(coursesController.coursesListToday.length>0)Padding(
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
                                        height: 70,
                                        width:
                                            MediaQuery.of(context).size.width * 0.9,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    showDialog(
                                                        // barrierDismissible:false,
                                                        context: context,
                                                        builder: (builder)=>AlertDialog(
                                                          content: Container(
                                                            height: MediaQuery.of(context).size.height*0.7,
                                                            width: MediaQuery.of(context).size.width*0.8,
                                                            // child:Text(coursesController.coursesListToday[i].driverName)
                                                            child:Column(
                                                              children: [
                                                                SizedBox(
                                                                  height:MediaQuery.of(context).size.height*0.02,
                                                                ),
                                                                Container(
                                                                  height:MediaQuery.of(context).size.height*0.5,
                                                                  width: MediaQuery.of(context).size.width*0.77,
                                                                  decoration:BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(15),
                                                                  color: Color(0xFF0F5CA0).withOpacity(0.6)
                                                                ),
                                                                  child: Column(
                                                                    children: [
                                                                  //   TextFormField(
                                                                  //   initialValue: coursesController.coursesListToday[i].driverName,
                                                                  //   enabled: false,
                                                                  //   readOnly: true,
                                                                  //     style: TextStyle(color: Colors.white),
                                                                  //   decoration: InputDecoration(
                                                                  //     prefixIcon: Container(
                                                                  //       height: 10,
                                                                  //       width: 10,
                                                                  //       decoration: BoxDecoration(
                                                                  //         color: Colors.white,
                                                                  //         borderRadius: BorderRadius.circular(30)
                                                                  //       ),
                                                                  //       child: Icon(
                                                                  //         Icons.arrow_forward_rounded
                                                                  //       ),
                                                                  //     ),
                                                                  //     enabledBorder: OutlineInputBorder(
                                                                  //       borderSide: BorderSide(color: Colors.white),
                                                                  //     ),
                                                                  //   ),
                                                                  // )
                                                                      Column(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:  EdgeInsets.only(
                                                                                left:MediaQuery.of(context).size.width*0.05,
                                                                              top: MediaQuery.of(context).size.height*0.03
                                                                            ),
                                                                            child: Row(
                                                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Container(
                                                                                  height:30,
                                                                                  width: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(20)
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Image.asset(
                                                                                        "assets/icons/arrow.png",
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width*0.05,
                                                                                ),
                                                                                Text(
                                                                                    coursesController.coursesListToday[i].pickUpLocation,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white
                                                                                    ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height*0.01,
                                                                          ),
                                                                          Container(
                                                                            color: Colors.white,
                                                                            height: 2,
                                                                            width: MediaQuery.of(context).size.width*0.6,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:  EdgeInsets.only(
                                                                                left:MediaQuery.of(context).size.width*0.05,
                                                                              top: MediaQuery.of(context).size.height*0.03
                                                                            ),
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  height:30,
                                                                                  width: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(20)
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Icon(
                                                                                      Icons.location_on,
                                                                                      color: Color(0xFF0F5CA0),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width*0.05,
                                                                                ),
                                                                                Text(
                                                                                    coursesController.coursesListToday[i].dropOffLocation,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white
                                                                                    ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height*0.01,
                                                                          ),
                                                                          Container(
                                                                            color: Colors.white,
                                                                            height: 2,
                                                                            width: MediaQuery.of(context).size.width*0.6,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:  EdgeInsets.only(
                                                                                left:MediaQuery.of(context).size.width*0.05,
                                                                              top: MediaQuery.of(context).size.height*0.03
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    Container(
                                                                                      height:30,
                                                                                      width: 30,
                                                                                      decoration: BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          borderRadius: BorderRadius.circular(20)
                                                                                      ),
                                                                                      child: Center(
                                                                                          child: Icon(
                                                                                            Icons.person,
                                                                                            color: Color(0xFF0F5CA0),
                                                                                          )
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: MediaQuery.of(context).size.width*0.05,
                                                                                    ),
                                                                                    Text(
                                                                                      coursesController.coursesListToday[i].passengersNum.toString(),
                                                                                      style: TextStyle(
                                                                                          color: Colors.white
                                                                                      ),
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                                IconButton(
                                                                                    onPressed:(){}
                                                                                    , icon: Icon(
                                                                                  Icons.remove_red_eye,
                                                                                  color: Colors.white,
                                                                                  size: 25,
                                                                                )
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          // SizedBox(
                                                                          //   height: MediaQuery.of(context).size.height*0.005,
                                                                          // ),
                                                                          Container(
                                                                            color: Colors.white,
                                                                            height: 2,
                                                                            width: MediaQuery.of(context).size.width*0.6,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:  EdgeInsets.only(
                                                                                left:MediaQuery.of(context).size.width*0.05,
                                                                              top: MediaQuery.of(context).size.height*0.03
                                                                            ),
                                                                            child: Row(
                                                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Container(
                                                                                  height:30,
                                                                                  width: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(20)
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Image.asset(
                                                                                        "assets/icons/balance.png",
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width*0.05,
                                                                                ),
                                                                                Text(
                                                                                    coursesController.coursesListToday[i].seatingCapacity.toString(),
                                                                                    style: TextStyle(
                                                                                      color: Colors.white
                                                                                    ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height*0.01,
                                                                          ),
                                                                          Container(
                                                                            color: Colors.white,
                                                                            height: 2,
                                                                            width: MediaQuery.of(context).size.width*0.6,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:  EdgeInsets.only(
                                                                                left:MediaQuery.of(context).size.width*0.05,
                                                                              top: MediaQuery.of(context).size.height*0.03
                                                                            ),
                                                                            child: Row(
                                                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Container(
                                                                                  height:30,
                                                                                  width: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(20)
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Image.asset(
                                                                                        "assets/icons/driver_blue.png",
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width*0.05,
                                                                                ),
                                                                                Text(
                                                                                    coursesController.coursesListToday[i].driverName,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white
                                                                                    ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height*0.01,
                                                                          ),
                                                                          Container(
                                                                            color: Colors.white,
                                                                            height: 2,
                                                                            width: MediaQuery.of(context).size.width*0.6,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:  EdgeInsets.only(
                                                                                left:MediaQuery.of(context).size.width*0.05,
                                                                              top: MediaQuery.of(context).size.height*0.03
                                                                            ),
                                                                            child: Row(
                                                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Container(
                                                                                  height:30,
                                                                                  width: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    borderRadius: BorderRadius.circular(20)
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: FaIcon(
                                                                                        FontAwesomeIcons.car,
                                                                                    color: Color(0xFF0F5CA0),)
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width*0.05,
                                                                                ),
                                                                                Text(
                                                                                    coursesController.coursesListToday[i].pickUpLocation,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white
                                                                                    ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height*0.01,
                                                                          ),
                                                                          Container(
                                                                            color: Colors.white,
                                                                            height: 2,
                                                                            width: MediaQuery.of(context).size.width*0.6,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:MediaQuery.of(context).size.height*0.02,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                    left: MediaQuery.of(context).size.width*0.01,
                                                                    right: MediaQuery.of(context).size.width*0.05,
                                                                  ),
                                                                  height:MediaQuery.of(context).size.height*0.05,
                                                                  width: MediaQuery.of(context).size.width*0.77,
                                                                  decoration:BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      color: Color(0xFF0F5CA0).withOpacity(0.6)
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text('Pick up Date',
                                                                      style:TextStyle(
                                                                        fontFamily: "Gidugu",
                                                                        fontSize: 15,
                                                                        color: Colors.white
                                                                      ),),
                                                                      Center(
                                                                        child: Text(
                                                                            DateFormat("d MMM y 'At' h:mm a").format(coursesController.coursesListToday[i].pickUpDate),
                                                                            style:TextStyle(
                                                                                fontFamily: "Gidugu",
                                                                                fontSize: 13,
                                                                                color: Colors.white
                                                                            )
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:MediaQuery.of(context).size.height*0.02,
                                                                ),
                                                                if(coursesController.coursesListToday[i].check=="car")
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                    left: MediaQuery.of(context).size.width*0.01,
                                                                    right: MediaQuery.of(context).size.width*0.05,
                                                                  ),
                                                                  height:MediaQuery.of(context).size.height*0.05,
                                                                  width: MediaQuery.of(context).size.width*0.77,
                                                                  decoration:BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      color: Color(0xFF0F5CA0).withOpacity(0.6)
                                                                  ),
                                                                  child:Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Text('Mission Order file',
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontFamily: "Gidugu"
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                          onPressed:()async{

                                                                            final taskId = await FlutterDownloader.enqueue(
                                                                              url: coursesController.coursesListToday[i].orderUrl!,
                                                                              savedDir: 'download',
                                                                              fileName: 'mission_order',
                                                                              showNotification: true,
                                                                              openFileFromNotification: true,
                                                                            );
                                                                          } ,
                                                                          icon: Icon(
                                                                              Icons.file_download_outlined,
                                                                          color: Colors.white,
                                                                          )
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 200,
                                                    height: 48,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        borderRadius:
                                                            BorderRadius.circular(5)),
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
                                                          width: 70,
                                                          child: Center(
                                                            child: Text(
                                                                coursesController
                                                                    .coursesListToday[i]
                                                                    .pickUpLocation
                                                                    .capitalize
                                                                    .toString(),
                                                                style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                      'Georgia',
                                                                )),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 2,
                                                              width: 30,
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
                                                          width: 70,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 8.0),
                                                          child: Center(
                                                            child: Text(
                                                                coursesController
                                                                    .coursesListToday[i]
                                                                    .dropOffLocation!
                                                                    .capitalize
                                                                    .toString(),
                                                                style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                      'Georgia',
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  width: 65,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
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
                                                        size: 20,
                                                      ),
                                                      Center(
                                                        child: Container(
                                                          child: Text(
                                                              coursesController
                                                                      .coursesListToday[
                                                                          i]
                                                                      .passengersNum
                                                                      .toString() +
                                                                  '/' +
                                                                  coursesController
                                                                      .coursesListToday[i]
                                                                      .seatingCapacity
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                      'Georgia',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(()=>EditCourseScreen(record: coursesController.coursesListToday[i]));
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
                                  if(coursesController.coursesList.length>0)Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
                                    child: Text(
                                      'Others',
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
                                          bottom: 0.0, left: 10),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 5),
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
                                                  height: 48,
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
                                                        height:45,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 8.0),
                                                        width: 70,
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesList[
                                                                      i]
                                                                  .pickUpLocation
                                                                  .capitalize
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Georgia',
                                                              )),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 2,
                                                            width: 30,
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
                                                        width: 70,
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
                                                                fontSize: 13,
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
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .people_alt_outlined,
                                                          size: 20,
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            // width:60,
                                                            child: Text(
                                                                coursesController
                                                                        .coursesList[i]
                                                                        .passengersNum
                                                                        .toString() +
                                                                    '/' +
                                                                    coursesController
                                                                        .coursesList[i]
                                                                        .seatingCapacity
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 13,
                                                                    fontFamily:
                                                                        'Georgia',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ),
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
                                                     Get.to(()=>EditCourseScreen(record: coursesController.coursesList[i]));
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

                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            if(
                            coursesController.coursesListDrivers.length>0
                            || coursesController.coursesListTodayDrivers.length>0
                            || coursesController.coursesListTomorrowDrivers.length>0
                            )
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
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(5),
                                color: Color(0xFF0F5CA0).withOpacity(0.7),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(coursesController.coursesListTomorrowDrivers.length>0)Padding(
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
                                  for (int i = 0; i < coursesController.coursesListTomorrowDrivers.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 5),
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
                                                  height: 48,
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
                                                        width: 70,
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListTomorrowDrivers[i]
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
                                                            width: 30,
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
                                                        width: 70,
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            bottom: 8.0),
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListTomorrowDrivers[i]
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
                                                  width: 65,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.people_alt_outlined,
                                                        size: 20,
                                                      ),
                                                      Container(
                                                        // width:70,
                                                        child: Text(
                                                            coursesController
                                                                .coursesListTomorrowDrivers[i]
                                                                .passengersNum
                                                                .toString() +
                                                                '/' +
                                                                coursesController
                                                                    .coursesListTomorrowDrivers[i]
                                                                    .seatingCapacity
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                'Georgia',
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(()=>EditCourseScreen(record: coursesController.coursesListTomorrowDrivers[i]));
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
                                                                            coursesController.delete_course(coursesController.coursesListTomorrowDrivers[i].id!);
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
                                  if(coursesController.coursesListTodayDrivers.length>0)Padding(
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
                                  for (int i = 0; i <coursesController.coursesListTodayDrivers.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 5),
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
                                                  height: 48,
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
                                                        width: 70,
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListTodayDrivers[i]
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
                                                            width: 30,
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
                                                        width: 70,
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            bottom: 8.0),
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListTodayDrivers[i]
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
                                                  width: 65,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.people_alt_outlined,
                                                        size: 20,
                                                      ),
                                                      Container(
                                                        // width:70,
                                                        child: Text(
                                                            coursesController
                                                                .coursesListTodayDrivers[i]
                                                                .passengersNum
                                                                .toString() +
                                                                '/' +
                                                                coursesController
                                                                    .coursesListTodayDrivers[i]
                                                                    .seatingCapacity
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                'Georgia',
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(()=>EditCourseScreen(record: coursesController.coursesListTodayDrivers[i]));
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
                                                                            coursesController.delete_course(coursesController.coursesListTodayDrivers[i].id!);
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
                                  if(coursesController.coursesListDrivers.length>0)Padding(
                                    padding: const EdgeInsets.only(left: 35.0),
                                    child: Text(
                                      'Others',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Georgia",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  for (int i = 0;i < coursesController.coursesListDrivers.length;i++)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 5),
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
                                                  height: 48,
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
                                                        width: 70,
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListDrivers[i]
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
                                                            width: 30,
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
                                                        width: 70,
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            bottom: 8.0),
                                                        child: Center(
                                                          child: Text(
                                                              coursesController
                                                                  .coursesListDrivers[i]
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
                                                  width: 65,
                                                  height: 48,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.people_alt_outlined,
                                                        size: 20,
                                                      ),
                                                      Container(
                                                        // width:70,
                                                        child: Text(
                                                            coursesController
                                                                .coursesListDrivers[i]
                                                                .passengersNum
                                                                .toString() +
                                                                '/' +
                                                                coursesController
                                                                    .coursesListDrivers[i]
                                                                    .seatingCapacity
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                'Georgia',
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(()=>EditCourseScreen(record: coursesController.coursesListDrivers[i]));
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
                                                                            coursesController.delete_course(coursesController.coursesListDrivers[i].id!);
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
                                ],
                              ),
                            )
                          ],
                        )
                      )
                  )
                ],
              ),
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