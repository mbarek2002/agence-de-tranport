import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
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
LoginController loginController =Get.put(LoginController());


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
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      // height: MediaQuery.of(context).size.height*0.75,
                      decoration: BoxDecoration(
                        color: Color(0xFFffffff).withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)
                        )
                      ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text("Driver Register",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Georgia"),
                            ),
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
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:18.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child:
                                  Center(
                                    child: DataTable(
                                      columns:  <DataColumn>[
                                        DataColumn(label: Text(
                                          'First Name',
                                          style: TextStyle(
                                              color:Colors.black,
                                              fontWeight: FontWeight.w400
                                          ),
                                        )),
                                        DataColumn(label: Text(':',
                                          style: TextStyle(
                                              color:Colors.black,
                                              fontWeight: FontWeight.w400
                                          ),)),
                                        DataColumn(label: Text(widget.record.firstName,
                                          style: TextStyle(
                                              color:Colors.black,
                                              fontWeight: FontWeight.w400
                                          ),)),
                                      ],
                                      rows:  <DataRow>[
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text("Last Name ",
                                          )),
                                          DataCell(Text(':')),
                                          DataCell(Text(widget.record.lastName)),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text("Birth Date")),
                                          DataCell(Text(':')),
                                          DataCell(Text(widget.record.birthDate)),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text("Identity Number")),
                                          DataCell(Text(':')),
                                          DataCell(Text(widget.record.identityNumber.toString())),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text("Phone Number")),
                                          DataCell(Text(':')),
                                          DataCell(Text(widget.record.phoneNumber.toString())),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text("Licence type")),
                                          DataCell(Text(':')),
                                          DataCell(Text(widget.record.licenceType)),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text("Email")),
                                          DataCell(Text(':')),
                                          DataCell(Text(widget.record.email)),
                                        ]),
                                        // DataRow(cells: <DataCell>[
                                        //   DataCell(Text("contract type")),
                                        //   DataCell(Text(':')),
                                        //   DataCell(Text(widget.record.contractType)),
                                        // ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Contract type".capitalize.toString(),style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Georgia"),
                                  ),
                                  Row(
                                    children: [
                                      Text("seasonal",style: TextStyle(fontSize: 10),),
                                      Checkbox(value: checkBox1, onChanged: (value){
                                        if(checkBox2==true){
                                          setState(() {
                                            checkBox1=!checkBox1;
                                            checkBox2=!checkBox2;
                                          });}
                                        else{
                                          setState(() {
                                            checkBox1=!checkBox1;
                                          });
                                        }
                                      }),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Text("Full Time Contract",style: TextStyle(fontSize: 10),),
                                      Checkbox(value: checkBox2, onChanged: (value){
                                        if(checkBox1==true){
                                          setState(() {
                                            checkBox1=!checkBox1;
                                            checkBox2=!checkBox2;
                                          });}
                                        else{
                                          setState(() {
                                            checkBox2=!checkBox2;

                                          });
                                        }
                                      }),
                                    ],
                                  ),

                                ],
                              ),
                              SizedBox(height:MediaQuery.of(context).size.height*0.04,),
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    if(checkBox1 || checkBox2){
                                      String contract="";
                                      if(checkBox1)
                                        contract="seasonal" ;
                                      else contract= "Full Time Contract";
                                      Get.to(()=>ConsultNotiNewDriversImages(record: widget.record , contract: contract));
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
                          )
                          ,SizedBox(height: 64,),
                        ],
                      ),
                    ),
                    ),
                  )
                ],
              ),
            ),
            // Positioned(
            //   top: MediaQuery.of(context).size.height* .04,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     alignment: Alignment.center,
            //     child: Container(
            //       width: 50,
            //       height: 50,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(20)),
            //         image: DecorationImage(
            //             image: NetworkImage(loginController.adminImageUrl.value),
            //             fit: BoxFit.cover
            //         ),
            //       ),
            //       child: GestureDetector(
            //         onTap: ()=>Get.offAll(()=>HomeScreen()),
            //       ),
            //     ),
            //   ),
            // )
          ],
        )


    );


  }
}
