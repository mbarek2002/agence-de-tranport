import 'dart:io';

import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/checkListData.dart';
import 'package:admin_citygo/models/course.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/driver_list/drivers_controller.dart';
import 'package:getwidget/getwidget.dart';


class EditCourseScreen extends StatefulWidget {
   EditCourseScreen({
    Key? key,
    required this.record,
  }) : super(key: key);

  Course record;

  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {

  DriversController driversController = Get.put(DriversController());
  CoursesController coursesController =Get.put(CoursesController());
  LoginController loginController =Get.put(LoginController());


  XFile? pickedFile;
  final picker = ImagePicker();

  List<String> errorList =[];

  String image='';

  void initState() {
    // TODO: implement initState
    super.initState();
    coursesController.init();
    coursesController.pickUpLocationConroller.text =widget.record.pickUpLocation ;
    coursesController.dropOffLocationConroller.text =widget.record.dropOffLocation!;
    dateTimePickUp = DateTime(
      widget.record.pickUpDate.year,
      widget.record.pickUpDate.month,
      widget.record.pickUpDate.day,
      widget.record.pickUpDate.hour,
      widget.record.pickUpDate.minute,
    );
    if(widget.record.dropOffDate!=null){
      dateTimeDropOff=DateTime(
        widget.record.dropOffDate!.year,
        widget.record.dropOffDate!.month,
        widget.record.dropOffDate!.day,
        widget.record.dropOffDate!.hour,
        widget.record.dropOffDate!.minute,
      );
      coursesController.isReturn.value=true;
    }
    coursesController.seatingCapacityController.text =widget.record.seatingCapacity.toString();
    coursesController.passagersConroller.text =widget.record.passengersNum.toString();
    coursesController.regNumberController.text =widget.record.regNumber.toString();
    coursesController.selectedItem.value=widget.record.driverName;
    coursesController.selectedItemId.value=widget.record.identityNum!;
    // coursesController.luggageBigSizeController.text=widget.record.luggageBigSize.toString();
    // coursesController.luggageMediumSizeController.text=widget.record.luggageMediumSize.toString();
    coursesController.collieController.text=widget.record.collie.toString();
    // coursesController.usedLuggageBigSize.value = widget.record.usedLuggageBigSize!;
    // coursesController.usedLuggageMediumSize.value = widget.record.usedLuggageMediumSize!;
    coursesController.usedCollie.value = widget.record.usedCollie!;


    if(widget.record.check=="car") {
      coursesController.checkBox2.value = true;
      if(widget.record.passengersDetails!=null)
      coursesController.passengerCarDetails.value = widget.record.passengersDetails!;
      if(widget.record.carListDetails!=null)coursesController.checkListTable.value = widget.record.carListDetails!;
    }
    if(widget.record.check=="passengers"){
      if(widget.record.passengersDetails!=null)
        coursesController.passengerDetails.value = widget.record.passengersDetails!;
    coursesController.checkBox1.value=true;
    }


    print(widget.record.id);
  }

/////////////////pick up date //////////////////////

  late DateTime dateTimePickUp ;

  Future pickDateTime()async{
    DateTime? date = await pickDate();
    if(date== null )return;

    TimeOfDay? time = await pickTime();
    if(time==null)return;

    final dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute
    );
    setState(() {
      this.dateTimePickUp =dateTime;
    });

  }

  Future<DateTime?> pickDate()=> showDatePicker(
      context: context,
      initialDate: dateTimePickUp,
      firstDate: DateTime.now(),
      lastDate: DateTime(2200)
  );
  Future<TimeOfDay?> pickTime()=>showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTimePickUp.hour, minute: dateTimePickUp.minute)
  );
  ////////////////drop off///////////////////////////
  DateTime dateTimeDropOff = DateTime.now().add(Duration(days: 2, hours: 2));

  Future<DateTime?> dropDate() => showDatePicker(
      context: context,
      initialDate: dateTimeDropOff,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> dropTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: dateTimeDropOff.hour, minute: dateTimeDropOff.minute));

  Future dropDateTime() async {
    DateTime? date = await dropDate();
    if (date == null) return;

    TimeOfDay? time = await dropTime();
    if (time == null) return;

    final dateTime =
    DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      this.dateTimeDropOff = dateTime;
    });
  }
  ///////////////////////////////////////////
  @override
  Widget build(BuildContext context) {

    final hours = dateTimePickUp.hour.toString().padLeft(2,'0');
    final minutes = dateTimePickUp.minute.toString().padLeft(2,'0');

    final hoursDrop = dateTimeDropOff.hour.toString().padLeft(2,'0');
    final minutesDrop = dateTimeDropOff.minute.toString().padLeft(2,'0');


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
            child: Text("Edit course",style: TextStyle(
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
                  SizedBox(height: 40,),
                  Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Center(
                          child: Obx(()=>Column(
                            children: [
                              Container(
                                  color: Color(0xFF0F5CA0).withOpacity(0.8),
                                  height: MediaQuery.of(context).size.height*0.735,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(height: MediaQuery.of(context).size.height*0.02),
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.85,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.white.withOpacity(0.7),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                              )),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(left: 20.0),
                                            child: TextFormField(
                                              controller: coursesController
                                                  .pickUpLocationConroller,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: 'Pick-up location',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Georgia',
                                                      color: Color(0xFF0F5CA0))),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.85,
                                          height: 60,

                                          decoration: BoxDecoration(
                                              color:
                                              Colors.white.withOpacity(0.7),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                              )),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(left: 20.0),
                                            child: TextFormField(
                                              controller: coursesController
                                                  .dropOffLocationConroller,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: 'Drop off location',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Georgia',
                                                      color: Color(0xFF0F5CA0))),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.85,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      pickDateTime();
                                                    },
                                                    child: Container(
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.4,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          borderRadius:
                                                          BorderRadius.only(
                                                            topRight:
                                                            Radius.circular(
                                                                5),
                                                            topLeft:
                                                            Radius.circular(
                                                                5),
                                                          )),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Text(
                                                            "Pick-up Date",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Georgia',
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0xFF0F5CA0)),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              Text(
                                                                  '${dateTimePickUp.year}/${dateTimePickUp.month}/${dateTimePickUp.day}'),
                                                              Text(
                                                                  '$hours:$minutes'),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (coursesController
                                                          .isReturn.value ==
                                                          false) {
                                                        coursesController
                                                            .checkBox1
                                                            .value = true;
                                                        coursesController.isReturn
                                                            .value = true;
                                                      }

                                                      if (coursesController
                                                          .isReturn
                                                          .value) dropDateTime();
                                                    },
                                                    child: Container(
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.4,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          borderRadius:
                                                          BorderRadius.only(
                                                            topRight:
                                                            Radius.circular(
                                                                5),
                                                            topLeft:
                                                            Radius.circular(
                                                                5),
                                                          )),
                                                      child: coursesController
                                                          .isReturn.value
                                                          ? Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Text(
                                                            "Drop off Date",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Georgia',
                                                                fontSize:
                                                                18,
                                                                color: Color(
                                                                    0xFF0F5CA0)),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              Text(
                                                                  '${dateTimeDropOff.year}/${dateTimeDropOff.month}/${dateTimeDropOff.day}'),
                                                              Text(
                                                                  '$hoursDrop:$minutesDrop'),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          )
                                                        ],
                                                      )
                                                          : Container(
                                                          height: 60,
                                                          width: 100,
                                                          child: Center(
                                                              child: Text(
                                                                'Return Date',
                                                                style: TextStyle(
                                                                  color: Color(
                                                                      0xFF0F5CA0),
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                  'Georgia',
                                                                ),
                                                              ))),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (coursesController
                                                  .isReturn.value)
                                                Container(
                                                  padding:
                                                  EdgeInsets.only(top: 5),
                                                  height: 25,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                            .transparent)),
                                                    onPressed: () {
                                                      coursesController
                                                          .isReturn.value = false;
                                                    },
                                                    child: Container(
                                                        child: Text('cancel',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.85,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.white.withOpacity(0.7),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                              )),
                                          child: TextFormField(
                                            controller: coursesController
                                                .passagersConroller,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  color: Color(0xFF0F5CA0)),
                                              labelText: 'Passengers',
                                              prefixIcon: Icon(Icons.person),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.85,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.white.withOpacity(0.7),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                              )
                                          ),
                                          child: TextFormField(
                                            controller: coursesController
                                                .seatingCapacityController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Georgia',
                                                  color: Color(0xFF0F5CA0)),
                                              labelText: 'Seating capacity',
                                              prefixIcon: Icon(Icons.person),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        GestureDetector(
                                          onTap: (){
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context){
                                                  return Container(
                                                    height: MediaQuery.of(context).size.height*0.35,
                                                    width: MediaQuery.of(context).size.width*0.8,
                                                    child: Obx(()=>Column(
                                                      children: [
                                                        Text(
                                                          'Luggage Capacity',
                                                          style:TextStyle(
                                                              fontSize: 20,
                                                              fontFamily: 'Georgia',
                                                              color: Color(0xFF0F5CA0)),
                                                        ),
                                                        // SizedBox(height: MediaQuery.of(context).size.height*0.02),
                                                        // Container(
                                                        //     width:MediaQuery.of(context).size.width*0.3,
                                                        //     height: 30,
                                                        //     decoration: BoxDecoration(
                                                        //       gradient: LinearGradient(
                                                        //         colors: [Color(0xFF0F5CA0).withOpacity(0.8), Color(0xFF0F5CA0).withOpacity(0.5)],
                                                        //         begin: Alignment.centerLeft,
                                                        //         end: Alignment.centerRight,
                                                        //       ),
                                                        //     ),
                                                        //     child: TextFormField(
                                                        //       controller: coursesController.luggageBigSizeController,
                                                        //       keyboardType: TextInputType.number,
                                                        //       style: TextStyle(
                                                        //           color: Colors.white
                                                        //       ),
                                                        //       decoration: InputDecoration(
                                                        //           prefixIcon: Icon(Icons.luggage)
                                                        //       ),
                                                        //     )),
                                                        // SizedBox(height: MediaQuery.of(context).size.height*0.05),
                                                        // Container(
                                                        //     width:MediaQuery.of(context).size.width*0.3,
                                                        //     height: 30,
                                                        //     decoration: BoxDecoration(
                                                        //       gradient: LinearGradient(
                                                        //         colors: [Color(0xFF0F5CA0).withOpacity(0.8), Color(0xFF0F5CA0).withOpacity(0.5)],
                                                        //         begin: Alignment.centerLeft,
                                                        //         end: Alignment.centerRight,
                                                        //       ),
                                                        //     ),
                                                        //     child: TextFormField(
                                                        //       controller: coursesController.luggageMediumSizeController,
                                                        //       keyboardType: TextInputType.number,
                                                        //       style: TextStyle(
                                                        //           color: Colors.white
                                                        //       ),
                                                        //       decoration: InputDecoration(
                                                        //           prefixIcon: Icon(
                                                        //             Icons.luggage,
                                                        //             size: 20,
                                                        //           ),
                                                        //       ),
                                                        //     )),
                                                        SizedBox(height: MediaQuery.of(context).size.height*0.05),
                                                        Container(
                                                            width:MediaQuery.of(context).size.width*0.3,
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [Color(0xFF0F5CA0).withOpacity(0.8), Color(0xFF0F5CA0).withOpacity(0.5)],
                                                                begin: Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                              ),
                                                            ),
                                                            child: TextFormField(
                                                              controller: coursesController.collieController,
                                                              keyboardType: TextInputType.number,
                                                              style: TextStyle(
                                                                  color: Colors.white
                                                              ),
                                                              decoration: InputDecoration(
                                                                  prefixIcon: Icon(
                                                                      Icons.mark_email_unread_outlined
                                                                  ),
                                                              ),
                                                              onChanged: (value){
                                                                if(int.parse(coursesController.collieController.text)<coursesController.usedCollie.value)
                                                                coursesController.usedCollie.value=0;
                                                                else if(coursesController.collieController.text == "")
                                                                  coursesController.collieController.text='0';
                                                              },
                                                            )),
                                                        SizedBox(height: MediaQuery.of(context).size.height*0.02),
                                                        Text('Used Luggage Capacity',
                                                            style:TextStyle(
                                                                fontSize: 20,
                                                                fontFamily: 'Georgia',
                                                                color: Color(0xFF0F5CA0))),
                                                        // SizedBox(height: MediaQuery.of(context).size.height*0.02),
                                                        // Container(
                                                        //     width:MediaQuery.of(context).size.width*0.3,
                                                        //     height: 30,
                                                        //     decoration: BoxDecoration(
                                                        //       gradient: LinearGradient(
                                                        //         colors: [Color(0xFF0F5CA0).withOpacity(0.8), Color(0xFF0F5CA0).withOpacity(0.5)],
                                                        //         begin: Alignment.centerLeft,
                                                        //         end: Alignment.centerRight,
                                                        //       ),
                                                        //     ),
                                                        //     child: Row(
                                                        //       mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                        //       children: [
                                                        //         Icon(
                                                        //             Icons.luggage
                                                        //         ),
                                                        //         DropdownButton<int>(
                                                        //           value: coursesController.usedLuggageBigSize.value,
                                                        //           onChanged: (int? newValue) {
                                                        //             coursesController.usedLuggageBigSize.value = newValue!;
                                                        //           },
                                                        //           items: List.generate((int.tryParse(coursesController.luggageBigSizeController.text)  ?? 0)+1, (index) {
                                                        //             return DropdownMenuItem<int>(
                                                        //               value: index,
                                                        //               child: Text('$index'),
                                                        //             );
                                                        //           }),
                                                        //         ),
                                                        //       ],
                                                        //     )
                                                        // ),
                                                        // SizedBox(height: MediaQuery.of(context).size.height*0.05),
                                                        // Container(
                                                        //     width:MediaQuery.of(context).size.width*0.3,
                                                        //     height: 30,
                                                        //     decoration: BoxDecoration(
                                                        //       gradient: LinearGradient(
                                                        //         colors: [Color(0xFF0F5CA0).withOpacity(0.8), Color(0xFF0F5CA0).withOpacity(0.5)],
                                                        //         begin: Alignment.centerLeft,
                                                        //         end: Alignment.centerRight,
                                                        //       ),
                                                        //     ),
                                                        //     child: Row(
                                                        //       mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                        //       children: [
                                                        //         Icon(
                                                        //           Icons.luggage,
                                                        //           size: 20,
                                                        //         ),
                                                        //         DropdownButton<int>(
                                                        //           value: coursesController.usedLuggageMediumSize.value,
                                                        //           onChanged: (int? newValue) {
                                                        //             coursesController.usedLuggageMediumSize.value = newValue!;
                                                        //           },
                                                        //           items: List.generate((int.tryParse(coursesController.luggageMediumSizeController.text)  ?? 0)+1, (index) {
                                                        //             return DropdownMenuItem<int>(
                                                        //               value: index,
                                                        //               child: Text('$index'),
                                                        //             );
                                                        //           }),
                                                        //         ),
                                                        //       ],
                                                        //     )
                                                        // ),
                                                        SizedBox(height: MediaQuery.of(context).size.height*0.05),
                                                        Container(
                                                            width:MediaQuery.of(context).size.width*0.3,
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [Color(0xFF0F5CA0).withOpacity(0.8), Color(0xFF0F5CA0).withOpacity(0.5)],
                                                                begin: Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Icon(
                                                                    Icons.mark_email_unread_outlined
                                                                ),
                                                                DropdownButton<int>(
                                                                  value: coursesController.usedCollie.value,
                                                                  onChanged: (int? newValue) {
                                                                    coursesController.usedCollie.value = newValue!;
                                                                  },
                                                                  items: List.generate((int.tryParse(coursesController.collieController.text)  ?? 0)+1, (index) {
                                                                    return DropdownMenuItem<int>(
                                                                      value: index,
                                                                      child: Text('$index'),
                                                                    );
                                                                  }),
                                                                ),
                                                              ],
                                                            )
                                                        ),
                                                      ],
                                                    )),
                                                  );
                                                }
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 5,
                                                right: 5
                                            ),
                                            height: 55,
                                            width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                            decoration: BoxDecoration(
                                                color:
                                                Colors.white.withOpacity(0.7),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                )),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('Luggage',
                                                  style: TextStyle(
                                                      fontFamily: "Georgia",
                                                      fontSize: 20,
                                                      color: Color(0xFF0F5CA0)
                                                  ),
                                                ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       coursesController.usedLuggageBigSize.toString()+
                                                //           "/"+coursesController.luggageBigSizeController.text,
                                                //       style: TextStyle(
                                                //           color: Color(0xFF0F5CA0)
                                                //       ),
                                                //     ),
                                                //     Icon(
                                                //         Icons.luggage_outlined,
                                                //         color: Color(0xFF0F5CA0)
                                                //     ),
                                                //   ],
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       coursesController.usedLuggageMediumSize.toString()
                                                //           +"/"+coursesController.luggageMediumSizeController.text,
                                                //       style: TextStyle(
                                                //           color: Color(0xFF0F5CA0)
                                                //       ),),
                                                //     Icon(Icons.luggage,size: 20,color: Color(0xFF0F5CA0)
                                                //     ),
                                                //   ],
                                                // ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      coursesController.usedCollie.toString()
                                                          +"/"+coursesController.collieController.text,

                                                      style: TextStyle(
                                                          color: Color(0xFF0F5CA0)
                                                      ),),
                                                    // Icon(
                                                    //     Icons.mark_email_unread_sharp,
                                                    //     color: Color(0xFF0F5CA0)
                                                    // ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.85,
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.white.withOpacity(0.7),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                              )),
                                          child: DropdownButton<DriverModel>(
                                            dropdownColor: Color(0xFF0F5CA0),
                                            // value: _selectedItem,
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18.0),
                                              child: Text(
                                                coursesController
                                                    .selectedItem.value,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Georgia',
                                                    color: Color(0xFF0F5CA0)),
                                              ),
                                            ),
                                            elevation: 16,
                                            items: driversController.driverList
                                                .map((DriverModel item) {
                                              return DropdownMenuItem<
                                                  DriverModel>(
                                                value: item,
                                                child: Text(
                                                  item.firstName +
                                                      " " +
                                                      item.lastName,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            onChanged: (DriverModel? newValue) {
                                              if (newValue != null)
                                                coursesController
                                                    .selectedItem!.value =
                                                    newValue!.firstName +
                                                        " " +
                                                        newValue!.lastName;

                                              coursesController
                                                  .selectedItemId!.value =
                                                  newValue!.identityNumber;
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.85,
                                          height: 65,
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.white.withOpacity(0.7),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                              )),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(left: 20.0),
                                            child: TextFormField(
                                              controller: coursesController
                                                  .regNumberController,
                                              // keyboardType:TextInputType.number,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Georgia',
                                                    color: Color(0xFF0F5CA0)),
                                                labelText: 'Reg n°',
                                                // prefixIcon: Icon(Icons.car_rental),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    GFCheckbox(
                                                      inactiveBgColor:
                                                      Colors.transparent,
                                                      size: 20,
                                                      activeBgColor:
                                                      Colors.transparent,
                                                      inactiveBorderColor:
                                                      Colors.white,
                                                      type: GFCheckboxType.square,
                                                      onChanged: (value) {
                                                        if (coursesController.checkBox1.value == false) {
                                                          coursesController
                                                              .importFromExcelForPassenger()
                                                              .then((value) {
                                                            {
                                                              coursesController.passagersConroller.text=coursesController.passengerDetails.length.toString();
                                                              widget.record.passengersDetails=null;
                                                              if (coursesController
                                                                  .checkBox2
                                                                  .value ==
                                                                  true) {
                                                                coursesController
                                                                    .checkBox1
                                                                    .value =
                                                                !coursesController
                                                                    .checkBox1
                                                                    .value;
                                                                coursesController
                                                                    .checkBox2
                                                                    .value =
                                                                !coursesController
                                                                    .checkBox2
                                                                    .value;
                                                              } else {
                                                                coursesController
                                                                    .checkBox1
                                                                    .value =
                                                                !coursesController
                                                                    .checkBox1
                                                                    .value;
                                                              }
                                                            }
                                                          });
                                                        } else {
                                                          coursesController.checkBox1.value =
                                                          !coursesController.checkBox1.value;
                                                          coursesController.passengerDetails.value = [];
                                                          widget.record.passengersDetails=null;
                                                        }
                                                      },
                                                      value: coursesController
                                                          .checkBox1.value,
                                                      inactiveIcon: null,
                                                    ),
                                                    Text(
                                                      'Check passengers',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                if(coursesController.checkBox1.value)Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.edit,size:20,color: Colors.white,),
                                                      onPressed: (){
                                                        coursesController.importFromExcelForPassenger().then((value) {
                                                          widget.record.passengersDetails=null;
                                                        });
                                                        coursesController.passagersConroller.text=coursesController.passengerDetails.length.toString();
                                                      },
                                                    ),
                                                    // IconButton(
                                                    //   icon: Icon(Icons.remove_red_eye,size:20,color: Colors.white,),
                                                    //   onPressed: (){
                                                    //     if(coursesController.passengerDetails.value!=null)
                                                    //     Get.dialog(
                                                    //       AlertDialog(
                                                    //         content:  Container(
                                                    //             width: MediaQuery.of(context).size.width*0.75,
                                                    //             height: MediaQuery.of(context).size.height*0.53,
                                                    //             child: SingleChildScrollView(
                                                    //               scrollDirection: Axis.vertical,
                                                    //               child: SingleChildScrollView(
                                                    //                 scrollDirection: Axis.horizontal,
                                                    //                 child: DataTable(
                                                    //                   columnSpacing: 5,
                                                    //                   dataRowHeight: 50,
                                                    //                   columns: const <DataColumn>[
                                                    //                     DataColumn(
                                                    //                       label: Expanded(
                                                    //                         child: Text(
                                                    //                           'First Name',
                                                    //                           style: TextStyle(fontStyle: FontStyle.italic),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ),
                                                    //                     DataColumn(
                                                    //                       label: Expanded(
                                                    //                         child: Text(
                                                    //                           'Last Name',
                                                    //                           style: TextStyle(fontStyle: FontStyle.italic),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ),
                                                    //                     DataColumn(
                                                    //                       label: Expanded(
                                                    //                         child: Text(
                                                    //                           'Identity Number',
                                                    //                           style: TextStyle(fontStyle: FontStyle.italic),
                                                    //                         ),
                                                    //                       ),
                                                    //                       numeric: true,
                                                    //                     ),
                                                    //                   ],
                                                    //
                                                    //                   rows: List<DataRow>.generate(coursesController.passengerDetails.length, (int index) =>
                                                    //                       DataRow(
                                                    //                           cells:<DataCell>[
                                                    //                             DataCell(Text(coursesController.passengerDetails[index].firstname)),
                                                    //                             DataCell(Text(coursesController.passengerDetails[index].lastName)),
                                                    //                             (coursesController.passengerDetails[index].identityNum.contains('.') && coursesController.passengerDetails[index].identityNum.endsWith('.0'))?
                                                    //                             DataCell(Text(coursesController.passengerDetails[index].identityNum.substring(0, coursesController.passengerDetails[index].identityNum.indexOf('.'))))
                                                    //                                 :
                                                    //                             DataCell(Text(coursesController.passengerDetails[index].identityNum)),
                                                    //
                                                    //                           ]
                                                    //                       )
                                                    //                   ),
                                                    //                 ),
                                                    //               ),
                                                    //             )
                                                    //         ),
                                                    //       )
                                                    //     );
                                                    //   },
                                                    // ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    GFCheckbox(
                                                      inactiveBgColor:
                                                      Colors.transparent,
                                                      size: 20,
                                                      activeBgColor:
                                                      Colors.transparent,
                                                      inactiveBorderColor:
                                                      Colors.white,
                                                      type: GFCheckboxType.square,
                                                      onChanged: (value) {
                                                        if (coursesController
                                                            .checkBox2.value ==
                                                            false) {
                                                          showDialog(
                                                              barrierDismissible:
                                                              false,
                                                              context: context,
                                                              builder:
                                                                  (builder) =>checkCarDialog()
                                                          );
                                                        } else {
                                                          coursesController.checkBox2.value = !coursesController.checkBox2.value;
                                                          coursesController.image.value = "";
                                                          coursesController.imageCar1.value="";
                                                          coursesController.imageCar2.value="";
                                                          coursesController.imageCar3.value="";
                                                          coursesController.imageCar4.value="";
                                                          coursesController.passengerCarDetails.value = [];
                                                          coursesController.checkListTable.value=[];
                                                          widget.record.passengersDetails=null;
                                                          widget.record.carListDetails=null;


                                                        }
                                                      },
                                                      value: coursesController
                                                          .checkBox2.value,
                                                      inactiveIcon: null,
                                                    ),
                                                    Text(
                                                      'Check car',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                if(coursesController.checkBox2.value)Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.edit,size:20,color: Colors.white,),
                                                      onPressed: (){
                                                        {
                                                          showDialog(
                                                              barrierDismissible:
                                                              false,
                                                              context: context,
                                                              builder:
                                                                  (builder) =>
                                                                  AlertDialog(
                                                                    title: Align(
                                                                      alignment: Alignment.topRight,
                                                                      child: IconButton(
                                                                          onPressed: (){
                                                                            Navigator.pop(context);
                                                                          },
                                                                          icon:Icon(Icons.close)
                                                                      ),
                                                                    ),
                                                                    content:
                                                                    Container(
                                                                        height:
                                                                        200,
                                                                        child:
                                                                        Column(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 200,
                                                                                  child: ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStateProperty.all(Color(0xFF0F5CA0)),
                                                                                    ),
                                                                                    child: Text(
                                                                                      'Edit an order',
                                                                                      style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      showModalBottomSheet(context: context, builder: (builder) => bottomSheet());
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 200,
                                                                                  child: ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStateProperty.all(Color(0xFF0F5CA0)),
                                                                                    ),
                                                                                    child: Text(
                                                                                      'Edit list of passengers',
                                                                                      style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      coursesController.importFromExcel().then((value) {
                                                                                        widget.record.passengersDetails=null;
                                                                                      });
                                                                                      coursesController.passagersConroller.text=coursesController.passengerCarDetails.length.toString();
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 200,
                                                                                  child: ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStateProperty.all(Color(0xFF0F5CA0)),
                                                                                    ),
                                                                                    child: Text(
                                                                                      'Edit check car list',
                                                                                      style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      showDialog(

                                                                                          barrierDismissible: false,
                                                                                          context: context,
                                                                                          builder: (builder)=>checkListDialog()

                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              width: 150,
                                                                              child: ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all(Color(0xFF000000).withOpacity(0.61)),
                                                                                ),
                                                                                child: Text(
                                                                                  'Next',
                                                                                  style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
                                                                                ),
                                                                                onPressed: () {
                                                                                  if (coursesController.image.value != "" || coursesController.passengerDetails.value != []) {
                                                                                    Navigator.pop(context);
                                                                                  } else {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text(
                                                                                            'choose an order picture and a passengers list'
                                                                                        ),
                                                                                        duration: Duration(seconds: 2),
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                    ),
                                                                  )
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    // IconButton(
                                                    //   icon: Icon(Icons.remove_red_eye,size:20,color: Colors.white,),
                                                    //   onPressed: (){
                                                    //     if(coursesController.passengerCarDetails.value!=null)
                                                    //     Get.dialog(
                                                    //       AlertDialog(
                                                    //         content: Container(
                                                    //           width: MediaQuery.of(context).size.width*0.75,
                                                    //           height: MediaQuery.of(context).size.height*0.5,
                                                    //           child:Column(
                                                    //             children: [
                                                    //               Container(
                                                    //                 color:Colors.blue.withOpacity(0.2),
                                                    //                 height:MediaQuery.of(context).size.height*0.1,
                                                    //                 width: MediaQuery.of(context).size.width*0.6,
                                                    //                 child:
                                                    //                 coursesController.image.value!="" && coursesController.image.value!.split('/')!.last.endsWith('.pdf')
                                                    //                     ?Padding(
                                                    //                     padding: EdgeInsets.all(
                                                    //                         10
                                                    //                     ),
                                                    //                     child: Column(
                                                    //                       children: [
                                                    //                         Icon(Icons.file_open),
                                                    //                         Text(
                                                    //                           coursesController.image.value!.split('/')!.last,
                                                    //                           style: TextStyle(
                                                    //                             fontSize: 8,
                                                    //                           ),
                                                    //                         )
                                                    //                       ],
                                                    //                     ))
                                                    //                     :coursesController.image.value!=""
                                                    //                     ?Padding(
                                                    //                   padding: const EdgeInsets.all(3.0),
                                                    //                   child: Image.file(File(
                                                    //                     coursesController.image.value!),
                                                    //                     width: MediaQuery.of(context).size.width*0.6,
                                                    //                     fit: BoxFit.fill,
                                                    //                   ),
                                                    //                 )
                                                    //                     :widget.record.orderUrl!.split('?').first.endsWith('.jpg')||
                                                    //                     widget.record.orderUrl!.split('?').first.endsWith('.jpeg')||
                                                    //                     widget.record.orderUrl!.split('?').first.endsWith('.png')
                                                    //                     ?Padding(
                                                    //                   padding: const EdgeInsets.all(3.0),
                                                    //                   child: Image.network(
                                                    //                     widget.record.orderUrl!,
                                                    //                     width: MediaQuery.of(context).size.width*0.6,
                                                    //                     fit: BoxFit.fill,
                                                    //                   ),
                                                    //                 )
                                                    //                     :Column(
                                                    //                   children: [
                                                    //                     Icon(Icons.file_open),
                                                    //                     Text('pdf File')
                                                    //                   ],
                                                    //                 ),
                                                    //               ),
                                                    //               Container(
                                                    //                 height: MediaQuery.of(context).size.height*0.4,
                                                    //                   child: SingleChildScrollView(
                                                    //                     scrollDirection: Axis.vertical,
                                                    //                     child: SingleChildScrollView(
                                                    //                       scrollDirection: Axis.horizontal,
                                                    //                       child: DataTable(
                                                    //                         columnSpacing: 5,
                                                    //                         dataRowHeight: 50,
                                                    //                         columns: const <DataColumn>[
                                                    //                           DataColumn(
                                                    //                             label: Expanded(
                                                    //                               child: Text(
                                                    //                                 'First Name',
                                                    //                                 style: TextStyle(fontStyle: FontStyle.italic),
                                                    //                               ),
                                                    //                             ),
                                                    //                           ),
                                                    //                           DataColumn(
                                                    //                             label: Expanded(
                                                    //                               child: Text(
                                                    //                                 'Last Name',
                                                    //                                 style: TextStyle(fontStyle: FontStyle.italic),
                                                    //                               ),
                                                    //                             ),
                                                    //                           ),
                                                    //                           DataColumn(
                                                    //                             label: Expanded(
                                                    //                               child: Text(
                                                    //                                 'Identity Number',
                                                    //                                 style: TextStyle(fontStyle: FontStyle.italic),
                                                    //                               ),
                                                    //                             ),
                                                    //                             numeric: true,
                                                    //                           ),
                                                    //                         ],
                                                    //                         rows: List<DataRow>.generate(coursesController.passengerCarDetails.length, (int index) =>
                                                    //                             DataRow(
                                                    //                                 cells:<DataCell>[
                                                    //                                   DataCell(Text(coursesController.passengerCarDetails[index].firstname)),
                                                    //                                   DataCell(Text(coursesController.passengerCarDetails[index].lastName)),
                                                    //                                   (coursesController.passengerCarDetails[index].identityNum.contains('.') && coursesController.passengerCarDetails[index].identityNum.endsWith('.0'))?
                                                    //                                   DataCell(Text(coursesController.passengerCarDetails[index].identityNum.substring(0, coursesController.passengerCarDetails[index].identityNum.indexOf('.'))))
                                                    //                                       :
                                                    //                                   DataCell(Text(coursesController.passengerCarDetails[index].identityNum)),
                                                    //
                                                    //                                 ]
                                                    //                             )
                                                    //                         ),
                                                    //                       ),
                                                    //                     ),
                                                    //                   )
                                                    //               ),
                                                    //
                                                    //             ],
                                                    //           ),
                                                    //         )
                                                    //       )
                                                    //     );
                                                    //   },
                                                    // ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height*0.13),
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                              GestureDetector(
                                onTap: ()async{
                                  errorList=[];
                                  // try {
                                    if (coursesController
                                        .pickUpLocationConroller.text ==
                                        "") errorList.add("pick-up location");
                                    if (coursesController
                                        .dropOffLocationConroller.text ==
                                        "") errorList.add("drop off location");
                                    if (coursesController.passagersConroller
                                        .text ==
                                        "") errorList.add("passengers number");
                                    if (coursesController.selectedItem
                                        .toLowerCase() ==
                                        "driver name") errorList.add(
                                        "driver name");
                                    if (coursesController
                                        .regNumberController.text ==
                                        "") errorList.add("reg number");
                                    if (coursesController
                                        .seatingCapacityController.text ==
                                        "") errorList.add("seating capacity");
                                    if(int.parse(coursesController.passagersConroller.text)>
                                    int.parse(coursesController.seatingCapacityController.text))
                                      errorList.add("check the seating capcity");

                                    if((int.tryParse(coursesController.collieController.text) ?? 0)<=0 || coursesController.collieController.text=="")
                                      errorList.add("Luggage capacity");

                                    if (errorList.isEmpty) {
                                      showDialog(context: context, builder: ((builder)=>Center(child:CircularProgressIndicator())));
                                      await coursesController.update_course(
                                          Course(
                                              adminId: widget.record.adminId,
                                              seen:widget.record.seen,
                                              finished: widget.record.finished,
                                              id:widget.record.id,
                                              pickUpLocation: coursesController.pickUpLocationConroller.text,
                                              dropOffLocation: coursesController.dropOffLocationConroller.text,
                                              pickUpDate: dateTimePickUp,
                                              dropOffDate:
                                              coursesController.isReturn.value == true
                                                  ? dateTimeDropOff
                                                  :null,
                                              driverName:  coursesController.selectedItem.value,
                                              identityNum: coursesController.selectedItemId.value,
                                              passengersNum: int.tryParse(coursesController.passagersConroller.text) ?? 0,
                                              seatingCapacity: int.tryParse(coursesController.seatingCapacityController.text) ?? 0,
                                              regNumber: coursesController.regNumberController.text,
                                              orderUrl: widget.record.orderUrl,
                                              carImage1URL: widget.record.carImage1URL,
                                              carImage2URL: widget.record.carImage2URL,
                                              carImage3URL: widget.record.carImage3URL,
                                              carImage4URL: widget.record.carImage4URL,
                                              check: coursesController.checkBox1.value == true
                                                  ?"passengers"
                                                  :  coursesController.checkBox2.value == true
                                                  ?"car"
                                                  :"",
                                              passengersDetails: widget.record.passengersDetails,
                                              // luggageBigSize: int.tryParse(coursesController.luggageBigSizeController.text) ?? 0,
                                              // luggageMediumSize: int.tryParse(coursesController.luggageMediumSizeController.text) ?? 0,
                                              collie: int.tryParse(coursesController.collieController.text) ?? 0,
                                              // usedLuggageBigSize: coursesController.usedLuggageBigSize.value,
                                              // usedLuggageMediumSize: coursesController.usedLuggageMediumSize.value,
                                              usedCollie: coursesController.usedCollie.value??0
                                          )
                                      ).then((value){
                                        coursesController.fetchCourses();
                                        Navigator.pop(context);
                                    });
                                    }
                                    else {
                                      showDialog(
                                          context: context,
                                          builder: ((builder) =>
                                              AlertDialog(
                                                content: Container(
                                                  height: 110,
                                                  width: 100,
                                                  child: Column(
                                                    children: [
                                                      const Icon(
                                                          IconData(0xe6cb,
                                                              fontFamily:
                                                              'MaterialIcons')),
                                                      Text(
                                                          'verify your data :\n' +
                                                              errorList.join(
                                                                  ",")),
                                                    ],
                                                  ),
                                                ),
                                              )));
                                    }

                                  // }catch(e){
                                  //   print(e.toString());
                                  // }
                                },
                                child: Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFF1A8FDD)
                                  ),
                                  child: Center(
                                      child:
    // widget.record.type.toLowerCase().trim()!="car hire"
                                          // ? Text('Next',style: TextStyle(color: Colors.white),)
                                          // :
                                        Text('Edit',style: TextStyle(color: Colors.white),))
                                  ,
                                ),
                              )
                            ],
                          ),
                        )
                      )
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height* .04,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: NetworkImage(loginController.adminImageUrl.value),
                        fit: BoxFit.cover
                    ),
                  ),
                  child: GestureDetector(
                    onTap: ()=>Get.offAll(()=>HomeScreen()),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  Widget bottomSheet(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: "Georgia"
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: getImageOrder,
                child: Container(
                  child: Row(
                    children: [
                      Text('Camera'),
                      Icon(Icons.camera)
                    ],
                  ),
                ),
              ) ,
              InkWell(
                onTap:() {
                  coursesController.pickOrderFile();
                },
                child: Container(
                  child: Row(
                    children: [
                      Text('Gallery'),
                      Icon(Icons.image)
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future getImageOrder() async {
    pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        coursesController.image.value = pickedFile!.path;
      } else {
        print('No image selected.');
      }
  }

  Widget checkListDialog(){
    return AlertDialog(
      title: Align(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: (){
              Navigator.pop(context);
              coursesController.checkList.value=false;
            },
            icon:Icon(Icons.close)
        ),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height*0.7,
        child: SingleChildScrollView(
          child: Obx(()=>Column(
            children: [
              Row(
                children: [
                  Container(
                    width:120,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child: Text('legend')),
                  ),
                  // Column(
                  //   children: [
                  //     Container(
                  //       width:100,
                  //       height: 30,
                  //       decoration: BoxDecoration(
                  //           color: Color(0xFF0F5CA0).withOpacity(0.8),
                  //           borderRadius: BorderRadius.circular(5)
                  //       ),
                  //
                  //       child: Center(child: Text('condtion')),
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Container(
                  //           width:35,
                  //           height: 30,
                  //           decoration: BoxDecoration(
                  //               color: Color(0xFF0F5CA0).withOpacity(0.6),
                  //               borderRadius: BorderRadius.only(
                  //                   topLeft: Radius.circular(5),
                  //                   bottomLeft: Radius.circular(5),
                  //
                  //               )
                  //           ),
                  //           child: Center(child: Text('100%')),
                  //         ),
                  //         SizedBox(width: 2,),
                  //         Container(
                  //           width:35,
                  //           height: 30,
                  //           decoration: BoxDecoration(
                  //               color: Color(0xFF0F5CA0).withOpacity(0.6),
                  //           ),
                  //
                  //           child: Center(child: Text('50%')),
                  //         ),
                  //         SizedBox(width: 2,),
                  //         Container(
                  //           width:35,
                  //           height: 30,
                  //           decoration: BoxDecoration(
                  //               color: Color(0xFF0F5CA0).withOpacity(0.6),
                  //               borderRadius: BorderRadius.only(
                  //                   topRight: Radius.circular(5),
                  //                   bottomRight: Radius.circular(5)
                  //               )
                  //           ),
                  //
                  //           child: Center(child: Text('0%')),
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // )

                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child: Text('Deep Scratches')),
                  ),
                  GFCheckbox(
                      size: 30,
                      onChanged: (val){
                        coursesController.checkList1.value=!coursesController.checkList1.value;
                      },
                      value: coursesController.checkList1.value
                  )
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child: Text('Light Scratches')),
                  ),
                  GFCheckbox(
                      size: 30,
                      onChanged: (val){
                        coursesController.checkList2.value=!coursesController.checkList2.value;

                      },
                      value: coursesController.checkList2.value
                  )
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child: Text('Body Rast')),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList3.value=!coursesController.checkList3.value;
                  },
                      size: 30,
                      value: coursesController.checkList3.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Cracked Windshield',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList4.value=!coursesController.checkList4.value;
                  },
                      size: 30,
                      value: coursesController.checkList4.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Cracked headlight',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList5.value=!coursesController.checkList5.value;
                  },size: 30,
                      value: coursesController.checkList5.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Tire Pressure',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList6.value=!coursesController.checkList6.value;
                  },size: 30,
                      value: coursesController.checkList6.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Battery Condition',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList7.value=!coursesController.checkList7.value;
                  },
                      size: 30,
                      value: coursesController.checkList7.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Oil/Water/fluid levels',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList8.value=!coursesController.checkList8.value;
                  },
                      size: 30,
                      value: coursesController.checkList8.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Brake Noise/feel',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList9.value=!coursesController.checkList9.value;
                  },
                      size: 30,
                      value: coursesController.checkList9.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Condition/Temperature',
                      style: TextStyle(
                          fontSize: 10
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList10.value=!coursesController.checkList10.value;
                  },
                      size: 30,
                      value: coursesController.checkList10.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Weel Damage',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList11.value=!coursesController.checkList11.value;
                  },
                      size: 30,
                      value: coursesController.checkList11.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Nearside front',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList12.value=!coursesController.checkList12.value;
                  },
                      size: 30,
                      value: coursesController.checkList12.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'offside front',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList13.value=!coursesController.checkList13.value;
                  },
                      size: 30,
                      value: coursesController.checkList13.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'offside rear',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList14.value=!coursesController.checkList14.value;
                  },
                      size: 30,
                      value: coursesController.checkList14.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Nearside rear',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList15.value=!coursesController.checkList15.value;
                  },
                      size: 30,
                      value: coursesController.checkList15.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Container(
                    width:120,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F5CA0).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)
                    ),

                    child: Center(child:
                    Text(
                      'Soare',
                      style: TextStyle(
                          fontSize: 12
                      ),
                    )
                    ),
                  ),
                  GFCheckbox(onChanged: (val){
                    coursesController.checkList16.value=!coursesController.checkList16.value;
                  },
                      size: 30,
                      value: coursesController.checkList16.value)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      width:MediaQuery.of(context).size.width*0.27,
                      height:MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                          color: Color(0xFF0F5CA0).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5)

                      ),
                      child:coursesController.imageCar1.value==""
                          ?Center(child: FaIcon(FontAwesomeIcons.image))
                          :Image.file(
                        File(coursesController.imageCar1.value),
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (builder)=>bottomSheetCar1()
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (builder)=>bottomSheetCar2()
                      );
                    },
                    child: Container(
                      width:MediaQuery.of(context).size.width*0.27,
                      height:MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                          color: Color(0xFF0F5CA0).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: coursesController.imageCar2.value==""
                          ?Center(child: FaIcon(FontAwesomeIcons.image))
                          :Image.file(
                        File(coursesController.imageCar2.value),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (builder)=>bottomSheetCar3()
                      );
                    },
                    child: Container(
                      width:MediaQuery.of(context).size.width*0.27,
                      height:MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                          color: Color(0xFF0F5CA0).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5)

                      ),
                      child: coursesController.imageCar3.value==""
                          ?Center(child: FaIcon(FontAwesomeIcons.image))
                          :Image.file(
                        File(coursesController.imageCar3.value),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (builder)=>bottomSheetCar4()
                      );
                    },
                    child: Container(
                      width:MediaQuery.of(context).size.width*0.27,
                      height:MediaQuery.of(context).size.height*0.05,
                      decoration: BoxDecoration(
                          color: Color(0xFF0F5CA0).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: coursesController.imageCar4.value==""
                          ?Center(child: FaIcon(FontAwesomeIcons.image))
                          :Image.file(
                        File(coursesController.imageCar4.value),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),
              ElevatedButton(onPressed: (){
                coursesController.checkList.value=true;
                coursesController.checkListTable.value=[
                  checklistData(name: "Deep Scratches", state: coursesController.checkList1.value),
                  checklistData(name: "Light Scratches", state: coursesController.checkList2.value),
                  checklistData(name: "Body Rast", state: coursesController.checkList3.value),
                  checklistData(name: "Cracked Windshield", state: coursesController.checkList4.value),
                  checklistData(name: "Cracked headlight", state: coursesController.checkList5.value),
                  checklistData(name: "Tire Pressure", state: coursesController.checkList6.value),
                  checklistData(name: "Battery Condition", state: coursesController.checkList7.value),
                  checklistData(name: "Oil/Water/fluid levels", state: coursesController.checkList8.value),
                  checklistData(name: "Brake Noise/feel", state: coursesController.checkList9.value),
                  checklistData(name: "Condition/Temperature", state: coursesController.checkList10.value),
                  checklistData(name: "Weel Damage", state: coursesController.checkList11.value),
                  checklistData(name: "Nearside front", state: coursesController.checkList12.value),
                  checklistData(name: "offside front", state: coursesController.checkList13.value),
                  checklistData(name: "offside rear", state: coursesController.checkList14.value),
                  checklistData(name: "Nearside rear", state: coursesController.checkList15.value),
                  checklistData(name: "soare", state: coursesController.checkList16.value),
                ];
                Navigator.pop(context);
              },
                  child: Text('Next'))

            ],
          )),
        ),
      ),
    );
  }

  Widget bottomSheetCar1() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Choose car photo",
            style: TextStyle(fontSize: 20.0, fontFamily: "Georgia"),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap:()async=> coursesController.imageCar1.value=await getImage(),
                child: Container(
                  child: Row(
                    children: [Text('Camera'), Icon(Icons.camera)],
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  coursesController.imageCar1.value=await getImageFromGallery();
                },
                child: Container(
                  child: Row(
                    children: [Text('Gallery'), Icon(Icons.image)],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Widget bottomSheetCar2() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Choose car photo",
            style: TextStyle(fontSize: 20.0, fontFamily: "Georgia"),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap:()async=> coursesController.imageCar2.value=await getImage(),
                child: Container(
                  child: Row(
                    children: [Text('Camera'), Icon(Icons.camera)],
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  coursesController.imageCar2.value=await getImageFromGallery();
                },
                child: Container(
                  child: Row(
                    children: [Text('Gallery'), Icon(Icons.image)],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Widget bottomSheetCar3() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Choose car photo",
            style: TextStyle(fontSize: 20.0, fontFamily: "Georgia"),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap:()async=> coursesController.imageCar3.value=await getImage(),
                child: Container(
                  child: Row(
                    children: [Text('Camera'), Icon(Icons.camera)],
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  coursesController.imageCar3.value=await getImageFromGallery();
                },
                child: Container(
                  child: Row(
                    children: [Text('Gallery'), Icon(Icons.image)],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Widget bottomSheetCar4() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Choose car photo",
            style: TextStyle(fontSize: 20.0, fontFamily: "Georgia"),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap:()async=> coursesController.imageCar4.value=await getImage(),
                child: Container(
                  child: Row(
                    children: [Text('Camera'), Icon(Icons.camera)],
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  coursesController.imageCar4.value=await getImageFromGallery();
                  print('lsdmfhnnnnnnnnnnnn');
                  print(coursesController.imageCar4.value);
                },
                child: Container(
                  child: Row(
                    children: [Text('Gallery'), Icon(Icons.image)],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<String> getImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile!.path;
      } else {
        print('No image selected.');
      }
    });
    return image;
    // Navigator.pop(context);
  }

  Future<String> getImageFromGallery() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = pickedFile!.path;
      } else {
        print('No image selected.');
      }
    });
    return image;
  }
  Widget checkCarDialog(){
    return AlertDialog(
      title: Align(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:Icon(Icons.close)
        ),
      ),
      content:
      Container(
          height:
          200,
          child:
          Obx(()=>Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF0F5CA0)),
                      ),
                      child: Text(
                        'Add an order',
                        style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
                      ),
                      onPressed: () {
                        showModalBottomSheet(context: context, builder: (builder) => bottomSheet());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF0F5CA0)),
                      ),
                      child: Text(
                        'Add list of passengers',
                        style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
                      ),
                      onPressed: () async{
                        await coursesController.importFromExcel().then((value) {
                          widget.record.passengersDetails=null;
                        });
                        coursesController.passagersConroller.text=coursesController.passengerCarDetails.length.toString();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GFCheckbox(
                        inactiveBgColor:
                        Colors.transparent,
                        size: 20,
                        activeBgColor:
                        Colors.transparent,
                        inactiveBorderColor:
                        Colors.black,
                        type: GFCheckboxType.square,
                        onChanged: (value) {
                          if (coursesController.checkList.value == false)
                          {
                            showDialog(

                                barrierDismissible: false,
                                context: context,
                                builder: (builder)=>checkListDialog()
                            );
                          }
                          else {
                            coursesController
                                .checkList.value =
                            !coursesController
                                .checkList.value;
                          }
                        },
                        value: coursesController
                            .checkList.value,
                        inactiveIcon: null,
                      ),
                      Text(
                        'Check car list',
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFF000000).withOpacity(0.61)),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontFamily: 'Georgia'),
                  ),
                  onPressed: () {
                    if (coursesController.image.value != "" && coursesController.passengerCarDetails.value != []) {
                      if (coursesController.checkBox1.value == true) {
                        coursesController.checkBox1.value = !coursesController.checkBox1.value;
                        coursesController.checkBox2.value = !coursesController.checkBox2.value;
                      } else {
                        coursesController.checkBox2.value = !coursesController.checkBox2.value;
                      }
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'choose an order picture and a passengers list'
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ))
      ),
    );
  }

}
