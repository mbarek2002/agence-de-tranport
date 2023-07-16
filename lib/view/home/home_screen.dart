import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/controllers/notication_new_driver/notication_new_driver_controller.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/utils/text_strings.dart';
import 'package:admin_citygo/view/drivers_list/driver_list_screen.dart';
import 'package:admin_citygo/view/login/login_screen.dart';
import 'package:admin_citygo/view/notification_new_driver_screen/notification_new_driver_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;



class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

  NotificationNewDriverController notificationNewDriverController = Get.put(NotificationNewDriverController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
           Padding(
             padding: const EdgeInsets.only(right: 20),
             child:
                 Column(
                   children: [
                     IconButton(
                         onPressed: (){
                       LoginController().signAdminOut();
                       Get.offAll(()=>LogInScreen());
                     },icon: Icon(Icons.logout,color: Colors.white,size: 30,),),
                   ],
                 ),
           ),
        ],
        backgroundColor: Color(0xFF0F5CA0),
        title: Padding(
          padding:  EdgeInsets.only(
              top:20,
              left: 40
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
                SizedBox(height: 150,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                    width: 80,
                    height: 80,
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=>DriversListScreen());
                        },
                        child: Container(
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
                      ),
                    badges.Badge(
                      badgeContent: Text(''),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white
                          ),
                          // child:  Icon(Icons.person,color: Colors.blue,size: 50,),
                          child: GestureDetector(
                            child: Container(
                            decoration: BoxDecoration(
                            image: DecorationImage(
                            image: AssetImage(
                              "assets/icons/person-combination.png"
                            )
                            )
                            ),
                            ),
                            onTap: (){
                              // notificationNewDriverController.fetchNotifiactionNewDriver();
                              // print("length :"+notificationNewDriverController.newNotiDriverList.length.toString());
                              Get.to(()=>NotificationNewDrivers());
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage("assets/icons/request-new.png")
                              )
                            ),
                          ),
                        ),
                    ),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: GestureDetector(
                      onTap: (){
                        Get.to(()=>NotificationNewDrivers());
                        },
                        child: Container(
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
                                  "assets/icons/planning.png"
                                )
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                      ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                    width: 80,
                    height: 80,
                    child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(tHomeList)
                    )
                    ),
                      child:  Container(
                        decoration: BoxDecoration(
                        image:DecorationImage(
                          image: AssetImage(
                            "assets/icons/care-request-reviewer.png"
                          )
                        )),
                      ),
                    ),
                    ),

                    badges.Badge(
                      badgeContent: Text(''),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                    image: AssetImage(
                                        "assets/icons/notification-bell-new.png"
                                    )
                                )),
                          ),

                        ),
                      ),
                    )
                  ],
                ),
                  ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height* .04,
            // right:MediaQuery.of(context).size.width*0.5 ,
            // width: MediaQuery.of(context).size.width,
            child: Container(
              // color: Colors.green,
              width: MediaQuery.of(context).size.width,
              // height: 20,
              alignment: Alignment.center,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/home_screen/person.jpg"),
                      fit: BoxFit.cover
                  ),
                ),
                child: GestureDetector(
                  onTap: ()=>Get.to(()=>HomeScreen()),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height* .24,
            width: MediaQuery.of(context).size.width*1.52,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: 20,
              alignment: Alignment.center,
              child: Container(
                width: 20,
                height: 20,
                child:  Icon(Icons.add,color: Color(0xFF0F5CA0),size: 30,)
              ),
            ),
          ),
        ],
      ),
    );
  }
}


