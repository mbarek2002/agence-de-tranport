import 'package:admin_citygo/controllers/notication_new_driver/consult_noti_new_drivers_controller.dart';
import 'package:admin_citygo/controllers/notication_new_driver/notication_new_driver_controller.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/models/notification_new_driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ConsultNotiNewDriversController consultNotiNewDrivers = Get.put(ConsultNotiNewDriversController());
NotificationNewDriverController notificationNewDriverController = Get.put(NotificationNewDriverController());

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
                              fontFamily: "Georgia"),),

                        SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.only(left:110),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: NetworkImage(widget.record.identityLink),
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left:30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text(widget.record.firstName.capitalize.toString(),style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                indent: 0,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("First Name".capitalize.toString(),style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text(widget.record.lastName.capitalize.toString(),style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                indent: 0,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Last Name".capitalize.toString(),style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text(widget.record.birthDate,style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                indent: 0,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Birth Date".capitalize.toString(),style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(widget.record.identityNumber.toString(),style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Georgia"),),
                                        Padding(
                                          padding: const EdgeInsets.only(right:18.0),
                                          child: GestureDetector(
                                            onTap: (){},
                                            child: Icon(Icons.file_copy_outlined),
                                          ),
                                        )
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                indent: 0,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Identity Card".capitalize.toString(),style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("+216 "+widget.record.phoneNumber.toString(),style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                indent: 0,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Phone Number ".capitalize.toString(),style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(widget.record.licenceType.capitalize.toString(),style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Georgia"),),
                                    Padding(
                                      padding: const EdgeInsets.only(right:18.0),
                                      child: GestureDetector(
                                        onTap: (){},
                                        child: Icon(Icons.file_copy_outlined),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                indent: 0,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Licence type".capitalize.toString(),style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text(widget.record.email.capitalize.toString(),style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              const Divider(
                                height: 10,
                                thickness: 2,
                                indent: 0,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Text("Email".capitalize.toString(),style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Georgia"),),
                              ),
                              SizedBox(height: 15,),
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
                              SizedBox(height: 20,),
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    print("object");
                                    if(checkBox1 || checkBox2){
                                      String contract="";
                                    if(checkBox1)
                                      contract="seasonal" ;
                                    else contract= "Full Time Contract";
                                    consultNotiNewDrivers.add_driver(
                                      DriverModel(
                                          driverImage: widget.record.identityLink,
                                          firstName: widget.record.firstName.capitalize.toString(),
                                          lastName: widget.record.lastName.capitalize.toString(),
                                          birthDate: widget.record.birthDate,
                                          identityNumber: widget.record.identityNumber,
                                          identityCardImage: widget.record.identityLink,
                                          phoneNumber: widget.record.phoneNumber,
                                          licenceType: widget.record.licenceType,
                                          licenceImage: widget.record.identityLink,
                                          email: widget.record.email,
                                          contractType: contract
                                      )
                                    );
                                    print(widget.record.valid);
                                    notificationNewDriverController.notiDrivers.doc(widget.record.id).update({"valid":true});
                                    print('oookkk');
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
                                      child: Text('confirm',
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
