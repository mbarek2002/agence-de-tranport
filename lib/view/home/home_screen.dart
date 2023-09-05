import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/home/home_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/controllers/notication_new_driver/notication_new_driver_controller.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/utils/text_strings.dart';
import 'package:admin_citygo/view/courses_list/courses_list_screen.dart';
import 'package:admin_citygo/view/drivers_list/driver_list_screen.dart';
import 'package:admin_citygo/view/login/login_screen.dart';
import 'package:admin_citygo/view/notification_new_driver_screen/notification_new_driver_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationNewDriverController notificationNewDriverController = Get.put(NotificationNewDriverController());
  LoginController loginController = Get.put(LoginController());
  DriversController  driversController =Get.put(DriversController());
  CoursesController coursesController = Get.put(CoursesController());

  HomeController homeController = Get.put(HomeController());
  @override
  void initState(){
    super.initState();
     loginController.getAdminImage(FirebaseAuth.instance.currentUser!.email.toString());
    driversController.fetchDrivers();
    coursesController.fetchCourses();
    homeController.box.write("email", FirebaseAuth.instance.currentUser!.email.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
           Padding(
             padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),
             child:
                 IconButton(
                     onPressed: (){
                   LoginController().signAdminOut();
                   homeController.box.remove("email");

                   Get.offAll(()=>LogInScreen());
                 }
                 ,icon: Icon(Icons.logout,color: Colors.white,size: 30,),),
           ),
        ],
        backgroundColor: Color(0xFF0F5CA0),
        title: Padding(
          padding:  EdgeInsets.only(
              left:  MediaQuery.of(context).size.width*0.1
          ),
          child: Text(tHome,style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Georgia"
          ),),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(tHomebackground)
              )
            ),
            child: Column(
              children: [
                SizedBox(
                height: MediaQuery.of(context).size.height*0.07,
                width: MediaQuery.of(context).size.width,
                  child: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                    ),
                    color: Color(0xFF0F5CA0)
                    ),
                    ),
                    ),
                SizedBox(height:  MediaQuery.of(context).size.height*0.2,),
                Container(
                  height: MediaQuery.of(context).size.height*0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>DriversListScreen());
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                            color: Color(0xFF0F5CA0).withOpacity(0.45),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround  ,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(
                                    left:MediaQuery.of(context).size.width*0.05
                                ),
                                child: Container(
                                    height: MediaQuery.of(context).size.height*0.08,
                                    width: MediaQuery.of(context).size.width*0.18,
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(tHomeList)
                                  )
                                  ),
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                    image:DecorationImage(
                                      image:
                                  AssetImage("assets/icons/driver.png"))))
                                ),
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.height*0.06,
                                  width: MediaQuery.of(context).size.width*0.45,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(
                                      child: Text(
                                      'Drivers List',
                                        style: TextStyle(
                                          color: Color(0xFF105EA0),
                                          fontSize: 20,
                                            fontFamily: "Georgia"

                                        ),
                                      ))
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>NotificationNewDrivers());
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                              color: Color(0xFF0F5CA0).withOpacity(0.45),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // badges.Badge(
                              //   badgeContent: Text(''),
                              //   child:
                                Padding(
                                  padding:  EdgeInsets.only(
                                      left:MediaQuery.of(context).size.width*0.05
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.08,
                                    width: MediaQuery.of(context).size.width*0.18,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white
                                    ),
                                    child: Container(
                                    decoration: BoxDecoration(
                                    image: DecorationImage(
                                    image: AssetImage(
                                      "assets/icons/person-combination.png"
                                    )
                                    )
                                    ),
                                    ),
                                  ),
                                ),
                              // ),
                              Container(
                                  height: MediaQuery.of(context).size.height*0.06,
                                  width: MediaQuery.of(context).size.width*0.45,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(
                                      child: Padding(
                                        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03),
                                        child: Text(
                                          'New Drivers Request',
                                          style: TextStyle(
                                              color: Color(0xFF105EA0),
                                              fontSize: 19,
                                            fontFamily: "Georgia"
                                          ),
                                        ),
                                      ))
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>CoursesListSceen());
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width*0.8,
                          decoration: BoxDecoration(
                              color: Color(0xFF0F5CA0).withOpacity(0.45),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(
                                    left:MediaQuery.of(context).size.width*0.05
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.08,
                                  width: MediaQuery.of(context).size.width*0.18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(tHomeList)
                                      )
                                  ),
                                  // child:  Icon(Icons.person,color: Colors.blue,size: 50,),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/icons/care-request-reviewer.png"
                                            )
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.height*0.06,
                                  width: MediaQuery.of(context).size.width*0.45,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(
                                      child: Text(
                                        'Courses List',
                                        style: TextStyle(
                                            color: Color(0xFF105EA0),
                                            fontSize: 20,
                                            fontFamily: "Georgia"
                                        ),
                                      ))
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 60,),

                  ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height* .04,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: GestureDetector(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Obx(() {
                    if (loginController.isLoading.value) {
                      return SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: Center(
                            child: CircularProgressIndicator()
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.2),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                            NetworkImage(
                              loginController.adminImageUrl.value
                            ),
                          )
                        ),
                        height: 60,
                        width: 60,
                      );
                    }
                  }
                  )
               ),
                
                onTap: () {
                  Get.offAll(() => HomeScreen());
                }

                ),
                ),
                ),
        ],
      ),
    );
  }
}


