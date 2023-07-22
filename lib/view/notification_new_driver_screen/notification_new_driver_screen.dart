import 'package:admin_citygo/controllers/notication_new_driver/notication_new_driver_controller.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:admin_citygo/view/notification_new_driver_screen/toggle_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NotificationNewDrivers extends StatefulWidget {
   NotificationNewDrivers({Key? key}) : super(key: key);


  @override
  State<NotificationNewDrivers> createState() => _NotificationNewDriversState();
}


class _NotificationNewDriversState extends State<NotificationNewDrivers> {

  NotificationNewDriverController notificationNewDriverController = Get.put(NotificationNewDriverController());

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding:  EdgeInsets.only(
                    top:20.0
                ),
                child: IconButton(
                  iconSize: 35,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Get.back();
                  },
                ),
              ),
              backgroundColor: Color(0xFF0F5CA0),
              title: Padding(
                padding:  EdgeInsets.only(
                    top:30,
                    left: 0
                ),
                child: Text("notification new drivers",style: TextStyle(
                    fontSize: 22,
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(80),
                              bottomRight: Radius.circular(80),
                            ),
                            color: Color(0xFF0F5CA0)
                        ),
                      ),
                    ),
                    // TopWidget(title: 'Notification New driver'),
                    SizedBox(height: 80,),
                    Center(child: Container(
                      height: MediaQuery.of(context).size.height*0.73,
                      width: MediaQuery.of(context).size.width,
                        child:StreamBuilder<QuerySnapshot>(
                          stream:notificationNewDriverController.notiDrivers.snapshots(),
                          builder: (context,AsyncSnapshot snapshots) {
                            if(snapshots.connectionState == ConnectionState.waiting){
                              return Center(
                                child: CircularProgressIndicator(color: Colors.green,),
                              );
                            }
                            if(snapshots.hasData){
                              print(snapshots.data!.docs.length);
                              return ListView.builder(
                                    itemCount: snapshots.data!.docs.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final DocumentSnapshot record = snapshots.data!.docs[index];
                                      print(record['valid']);
                                      return Card(
                                          child:!record['valid'] ? ToggleContainer(record: record):null,
                                      );
                                    }
                          );
                            }
                            else{
                              return Center(child: CircularProgressIndicator(color: Colors.red,),);}
                          }
                        ),
                    )
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height* .04,
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
                      onTap: ()=>Get.offAll(()=>HomeScreen()),
                    ),
                  ),
                ),
              )
            ],
            )


          );

  }
}

