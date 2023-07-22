import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/notication_new_driver/notication_new_driver_controller.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/models/notification_new_driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:admin_citygo/view/notification_new_driver_screen/consult_notification_new_driver_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NotificationNewDriverController notificationNewDriverController = Get.put(NotificationNewDriverController());
DriversController driversController = Get.put(DriversController());

class ConsultNotiNewDrivers extends StatefulWidget {
  ConsultNotiNewDrivers({Key? key,required this.record}) : super(key: key);
  NotificationNewDriver record;
  @override
  State<ConsultNotiNewDrivers> createState() => _ConsultNotiNewDriversState();
}

class _ConsultNotiNewDriversState extends State<ConsultNotiNewDrivers> {

  bool checkBox1 = false;
  bool checkBox2 = false;
    @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text("Notification new drivers",style: TextStyle(
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
                  SizedBox(height: 35,),
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    height: MediaQuery.of(context).size.height*0.787,
                    decoration: BoxDecoration(
                      color: Color(0xFFffffff).withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)
                      )
                    ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text("Driver Register",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Georgia"),
                        ),
                        SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.only(left:110),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: NetworkImage(widget.record.driverImage),
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25,),
                        Padding(
                          padding: const EdgeInsets.only(left:30.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("First Name".capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text("Last Name".capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text("Birth Date".capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text("Identity Card".capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text("Phone Number ".capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text("Licence type".capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text("Email".capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(':'),
                                      SizedBox(height: 25,),
                                      Text(':'),
                                      SizedBox(height: 25,),
                                      Text(':'),
                                      SizedBox(height: 28,),
                                      Text(':'),
                                      SizedBox(height: 28,),
                                      Text(':'),
                                      SizedBox(height: 28,),
                                      Text(':'),
                                      SizedBox(height: 25,),
                                      Text(':'),
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.record.firstName.capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text(widget.record.lastName.capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text(widget.record.birthDate,style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text(widget.record.identityNumber.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text("+216 "+widget.record.phoneNumber.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text(widget.record.licenceType.capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),
                                      SizedBox(height: 25,),
                                      Text(widget.record.email.capitalize.toString(),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"),),



                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 25,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Contract type".capitalize.toString(),style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Georgia"),),
                                  Row(
                                    children: [
                                      Text("seasonal",style: TextStyle(fontSize: 10),),
                                      Checkbox(value: checkBox1, onChanged: (value){
                                        if(checkBox2==false){
                                          setState(() {
                                            checkBox1=!checkBox1;
                                          });}
                                        else{
                                          setState(() {
                                            checkBox1=false;
                                          });
                                        }
                                      }),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Text("Full Time Contract",style: TextStyle(fontSize: 10),),
                                      Checkbox(value: checkBox2, onChanged: (value){
                                        if(checkBox1==false){
                                          setState(() {
                                            checkBox2=!checkBox2;
                                          });}
                                        else{
                                          setState((){
                                            checkBox2=false;
                                          });
                                        }
                                      }),
                                    ],
                                  ),

                                ],
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                indent: 0,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                              SizedBox(height: 50,),
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    if(checkBox1 || checkBox2){
                                      String contract="";
                                      if(checkBox1)
                                        contract="seasonal" ;
                                      else contract= "Full Time Contract";
                                      Get.to(()=>ConsultNotiNewDriversImages(record: widget.record , contract: contract));

                                      // driversController.add_driver(
                                      //     DriverModel(
                                      //         driverImage: widget.record.driverImage,
                                      //         firstName: widget.record.firstName.capitalize.toString(),
                                      //         lastName: widget.record.lastName.capitalize.toString(),
                                      //         birthDate: widget.record.birthDate,
                                      //         identityNumber: widget.record.identityNumber,
                                      //         identityCardImageFace1: widget.record.identityCardImage,
                                      //         identityCardImageFace2: widget.record.identityCardImage,
                                      //         phoneNumber: widget.record.phoneNumber,
                                      //         licenceType: widget.record.licenceType,
                                      //         licenceImageFace1: widget.record.licenceImage,
                                      //         licenceImageFace2: widget.record.licenceImage,
                                      //         email: widget.record.email,
                                      //         contractType: contract,
                                      //         password:widget.record.password
                                      //     )
                                      // );
                                      // notificationNewDriverController.notiDrivers.doc(widget.record.id).update({"valid":true});

                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Please select contract type"),
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xFF0F5CA0),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text('Next',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Georgia',
                                            color: Colors.white
                                        ),),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  )
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
