
import 'dart:io';

import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/course_model.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/courses_list/add_course_xl.dart';
import 'package:admin_citygo/view/courses_list/edit_course_xl.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../controllers/driver_list/drivers_controller.dart';
import 'package:getwidget/getwidget.dart';


class EditCourseScreen extends StatefulWidget {
   EditCourseScreen({
    Key? key,
    required this.record,
  }) : super(key: key);

  CourseModel record;

  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {

  DriversController driversController = Get.put(DriversController());

  CoursesController coursesController =Get.put(CoursesController());
  LoginController loginController =Get.put(LoginController());


  XFile? pickedFile;
  final picker = ImagePicker();
  bool isChecked = true;

  List<String> errorList =[];


  void initState() {
    // TODO: implement initState
    super.initState();
    driversController.fetchDrivers();
    coursesController.pickUpLocationConroller.text =widget.record.pickUpLocation ;
    coursesController.dropOffLocationConroller.text =widget.record.dropOffLocation!;
    coursesController.passagersConroller.text =widget.record.passengersNum.toString();
    coursesController.selectedItem.value=widget.record.driverName;
    coursesController.selectedItemId.value=widget.record.identityNum!;
    dateTimePickUp = DateTime(
      widget.record.pickUpDate.year,
      widget.record.pickUpDate.month,
      widget.record.pickUpDate.day,
      widget.record.pickUpDate.hour,
      widget.record.pickUpDate.minute,
    );
    coursesController.image.value="";
    widget.record.dropOffLocation==""? isChecked=true:isChecked=false;
    print(widget.record.orderUrl);
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
      firstDate: DateTime(1900),
      lastDate: DateTime(2100)
  );
  Future<TimeOfDay?> pickTime()=>showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTimePickUp.hour, minute: dateTimePickUp.minute)
  );
  ////////////////drop off///////////////////////////
  DateTime dateTimeDropOff = DateTime.now().add(Duration(days: 2, hours: 2));

  Future<DateTime?> dropDate()=> showDatePicker(
      context: context,
      initialDate: dateTimeDropOff,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100)
  );
  Future<TimeOfDay?> dropTime()=>showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTimeDropOff.hour, minute: dateTimeDropOff.minute)
  );
  ///////////////////////////////////////////
  @override
  Widget build(BuildContext context) {

    final hours = dateTimePickUp.hour.toString().padLeft(2,'0');
    final minutes = dateTimePickUp.minute.toString().padLeft(2,'0');

    final hoursDrop = dateTimeDropOff.hour.toString().padLeft(2,'0');
    final minutesDrop = dateTimeDropOff.minute.toString().padLeft(2,'0');

    return Scaffold(
      // resizeToAvoidBottomInset:false,
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
                              widget.record.type.toLowerCase().trim()=="rides airport transfers"
                              ?Container(
                                decoration: BoxDecoration(
                                    color:coursesController.formNum.value==2
                                        ? Colors.white.withOpacity(0.3)
                                        : Color(0xFF0F5CA0).withOpacity(0.7),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )
                                ),
                                height: 85,
                                width: MediaQuery.of(context).size.width*0.9,
                                child: Center(
                                    child: Text(
                                        '\t\t\t\t\t\t\t\t\t\tRides\n Airport transfers',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Georgia"
                                        ))),
                              )
                              :Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF0F5CA0).withOpacity(0.7),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )
                                ),
                                height: 85,
                                width: MediaQuery.of(context).size.width*0.9,
                                child: Center(
                                    child:
                                    Text('Car hire',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Georgia"
                                      ),

                                    )),
                              ),

                              if(widget.record.type.toLowerCase().trim()=="rides airport transfers")
                                Container(
                                  color: Color(0xFF0F5CA0).withOpacity(0.8),
                                  height: MediaQuery.of(context).size.height*0.525,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Form(
                                      key: coursesController.formKey,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 40,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.75,
                                            color: Colors.white.withOpacity(0.7),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:20.0),
                                              child: TextFormField(
                                                controller: coursesController.pickUpLocationConroller,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Pick-up location',
                                                    hintStyle: TextStyle(
                                                        fontFamily: 'Georgia',
                                                        color: Color(0xFF0F5CA0))
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 25,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.75,
                                            decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.7),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:20.0),
                                              child: TextFormField(
                                                controller: coursesController.dropOffLocationConroller,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Drop off location',
                                                    hintStyle: TextStyle(
                                                        fontFamily: 'Georgia',
                                                        color: Color(0xFF0F5CA0))
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 25,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.75,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    pickDateTime();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width*0.75,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.7),
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(5),
                                                          topLeft: Radius.circular(5),
                                                        )
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Pick-up Date",
                                                          style: TextStyle(
                                                              fontFamily: 'Georgia',
                                                              fontSize:18,
                                                              color: Color(0xFF0F5CA0)),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Text('${dateTimePickUp.year}/${dateTimePickUp.month}/${dateTimePickUp.day}'),
                                                            Text('$hours:$minutes'),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,)
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 25,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.75,
                                            decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.7),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Passengers',style: TextStyle(
                                                      fontFamily: 'Georgia',
                                                      color: Color(0xFF0F5CA0)),),
                                                  TextFormField(
                                                    controller: coursesController.passagersConroller,
                                                    keyboardType:TextInputType.number ,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(Icons.person),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 25,),

                                          Container(
                                            width: MediaQuery.of(context).size.width*0.75,
                                            decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.7),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                )
                                            ),
                                            child: DropdownButton<DriverModel>(
                                              dropdownColor: Color(0xFF0F5CA0),
                                              // value: _selectedItem,
                                              hint: Padding(
                                                padding: const EdgeInsets.only(left: 18.0),
                                                child: Text(coursesController.selectedItem.value,style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Georgia',
                                                    color: Color(0xFF0F5CA0)),),
                                              ),
                                              elevation: 16,
                                              items: driversController.driverList.map((DriverModel item) {
                                                return DropdownMenuItem<DriverModel>(
                                                  value: item,
                                                  child: Text(item.firstName+" "+item.lastName,style: TextStyle(color: Colors.white),),
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              onChanged: (DriverModel? newValue) {
                                                if (newValue != null)
                                                  coursesController.selectedItem!.value = newValue!.firstName+" "+newValue!.lastName;
                                                print(newValue?.id);
                                                print(newValue?.identityNumber);
                                                coursesController.selectedItemId!.value = newValue!.identityNumber;
                                                print(coursesController.selectedItem!.value);
                                                print(coursesController.selectedItemId!.value);
                                              },
                                            ),
                                          ),

                                        ],
                                      )
                                  ),
                                ),
                              if(widget.record.type.toLowerCase().trim()=="car hire")
                                Container(
                                  color: Color(0xFF0F5CA0).withOpacity(0.8),
                                  height: MediaQuery.of(context).size.height*0.525,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Form(
                                      key: coursesController.formKey,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 40,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.75,
                                            color: Colors.white.withOpacity(0.7),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:20.0),
                                              child: TextFormField(
                                                controller: coursesController.pickUpLocationConroller,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Pick-up location',
                                                    hintStyle: TextStyle(
                                                        fontFamily: 'Georgia',
                                                        color: Color(0xFF0F5CA0))
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left:20.0),
                                            child: Row(
                                              children: [
                                                GFCheckbox(
                                                  inactiveBgColor:Colors.transparent,
                                                  size: GFSize.SMALL,
                                                  activeBgColor: Colors.transparent,
                                                  inactiveBorderColor: Colors.white,
                                                  type: GFCheckboxType.square,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      isChecked = value;
                                                      coursesController.dropOffLocationConroller.text='';
                                                    });
                                                  },
                                                  value: isChecked,
                                                  inactiveIcon: null,
                                                ),
                                                Text('Return car to the same location'
                                                  ,style: TextStyle(color: Colors.white),),
                                              ],
                                            ),
                                          ),
                                          if(isChecked==false)
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.75,
                                              decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.7),
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(5),
                                                    topLeft: Radius.circular(5),
                                                  )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:20.0),
                                                child: TextFormField(
                                                  controller: coursesController.dropOffLocationConroller,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: 'Drop off location',
                                                      hintStyle: TextStyle(
                                                          fontFamily: 'Georgia',
                                                          color: Color(0xFF0F5CA0))
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(height: 15,),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: ()async{
                                                    DateTime? date = await pickDate();
                                                    if(date== null )return;
                                                    final dateTime = DateTime(
                                                        date.year,
                                                        date.month,
                                                        date.day,
                                                        dateTimePickUp.hour,
                                                        dateTimePickUp.minute

                                                    );
                                                    setState(() {
                                                      this.dateTimePickUp =dateTime;
                                                    });
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Pick-Up Date",
                                                        style: TextStyle(
                                                            fontFamily: 'Georgia',
                                                            fontSize:12,
                                                            color: Colors.white),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width*0.3,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.7),
                                                            borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(5),
                                                              topLeft: Radius.circular(5),
                                                            )
                                                        ),
                                                        child:
                                                        Center(
                                                          child: Text('${dateTimePickUp.year}/${dateTimePickUp.month}/${dateTimePickUp.day}',
                                                            style: TextStyle(color: Color(0xFF0F5CA0)),
                                                          ),
                                                        ),

                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: ()async{
                                                    TimeOfDay? time = await pickTime();
                                                    if(time==null)return;
                                                    final dateTime = DateTime(
                                                        dateTimePickUp.year,
                                                        dateTimePickUp.month,
                                                        dateTimePickUp.day,
                                                        time.hour,
                                                        time.minute
                                                    );
                                                    setState(() {
                                                      this.dateTimePickUp =dateTime;
                                                    });
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Time",
                                                        style: TextStyle(
                                                            fontFamily: 'Georgia',
                                                            fontSize:12,
                                                            color: Colors.white),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width*0.3,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.7),
                                                            borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(5),
                                                              topLeft: Radius.circular(5),
                                                            )
                                                        ),
                                                        child:
                                                        Center(
                                                          child: Text('$hours:$minutes',
                                                            style: TextStyle(color: Color(0xFF0F5CA0)),
                                                          ),
                                                        ),

                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 30,
                                              right: 30,
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: ()async{
                                                    DateTime? date = await dropDate();
                                                    if(date== null )return;
                                                    final dateTime = DateTime(
                                                        date.year,
                                                        date.month,
                                                        date.day,
                                                        dateTimeDropOff.hour,
                                                        dateTimeDropOff.minute

                                                    );
                                                    setState(() {
                                                      this.dateTimeDropOff =dateTime;
                                                    });
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Drop off Date",
                                                        style: TextStyle(
                                                            fontFamily: 'Georgia',
                                                            fontSize:12,
                                                            color: Colors.white),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width*0.3,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.7),
                                                            borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(5),
                                                              topLeft: Radius.circular(5),
                                                            )
                                                        ),
                                                        child:
                                                        Center(
                                                          child: Text('${dateTimeDropOff.year}/${dateTimeDropOff.month}/${dateTimeDropOff.day}',
                                                            style: TextStyle(color: Color(0xFF0F5CA0)),
                                                          ),
                                                        ),

                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: ()async{
                                                    TimeOfDay? time = await dropTime();
                                                    if(time==null)return;

                                                    final dateTime = DateTime(
                                                        dateTimeDropOff.year,
                                                        dateTimeDropOff.month,
                                                        dateTimeDropOff.day,
                                                        time.hour,
                                                        time.minute
                                                    );
                                                    setState(() {
                                                      this.dateTimeDropOff =dateTime;
                                                    });
                                                    print(dateTimeDropOff.hour);
                                                    print(dateTimeDropOff.minute);
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Time",
                                                        style: TextStyle(
                                                            fontFamily: 'Georgia',
                                                            fontSize:12,
                                                            color: Colors.white),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width*0.3,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.7),
                                                            borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(5),
                                                              topLeft: Radius.circular(5),
                                                            )
                                                        ),
                                                        child:
                                                        Center(
                                                          child: Text('$hoursDrop:$minutesDrop',
                                                            style: TextStyle(color: Color(0xFF0F5CA0)),
                                                          ),
                                                        ),

                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.75,
                                            decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.7),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                )
                                            ),
                                            child: DropdownButton<DriverModel>(
                                              dropdownColor: Color(0xFF0F5CA0),
                                              // value: _selectedItem,
                                              hint: Padding(
                                                padding: const EdgeInsets.only(left: 18.0),
                                                child: Text(coursesController.selectedItem.value,style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Georgia',
                                                    color: Color(0xFF0F5CA0)),),
                                              ),
                                              elevation: 16,
                                              items: driversController.driverList.map((DriverModel item) {
                                                return DropdownMenuItem<DriverModel>(
                                                  value: item,
                                                  child: Text(item.firstName+" "+item.lastName,style: TextStyle(color: Colors.white),),
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              onChanged: (DriverModel? newValue) {
                                                if (newValue != null)
                                                  coursesController.selectedItem!.value = newValue!.firstName+" "+newValue!.lastName;
                                                print(newValue?.id);
                                                print(newValue?.identityNumber);
                                                coursesController.selectedItemId!.value = newValue!.identityNumber;
                                                print(coursesController.selectedItem!.value);
                                                print(coursesController.selectedItemId!.value);
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 15,),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.75,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.7),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left:20.0,
                                                right:10.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  coursesController.image.value ==""  && widget.record.orderUrl!.split('?').first.endsWith('.pdf')
                                                 ? Text(
                                                    "pdf file"
                                                    ,style: TextStyle(
                                                      fontFamily: 'Georgia',
                                                      color: Color(0xFF0F5CA0)),
                                                  )
                                                  :coursesController.image.value ==""  && widget.record.orderUrl!.split('?').first.endsWith('.png')
                                                  || coursesController.image.value ==""  && widget.record.orderUrl!.split('?').first.endsWith('.jpg')
                                                  || coursesController.image.value ==""  && widget.record.orderUrl!.split('?').first.endsWith('.jpeg')
                                                  ?Text(
                                                    "image file"
                                                    ,style: TextStyle(
                                                      fontFamily: 'Georgia',
                                                      color: Color(0xFF0F5CA0)),
                                                  )
                                                      :Text(
                                                    coursesController.image.value.split('/').last
                                                    ,style: TextStyle(
                                                      fontFamily: 'Georgia',
                                                      color: Color(0xFF0F5CA0)),),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        icon:Icon(Icons.remove_red_eye),
                                                        onPressed: ()
                                                          {
                                                            if(coursesController.image.value!="" && coursesController.image.value!.split('/')!.last.endsWith('.pdf'))
                                                            {
                                                              // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (
                                                                          (builder)=>AlertDialog(
                                                                        content: Container(
                                                                          height: 500,
                                                                          width: 2500,
                                                                          child: SfPdfViewer.file(File(coursesController.image.value!)),
                                                                        ),
                                                                      )
                                                                  )
                                                              );
                                                            }
                                                            else if(coursesController.image.value!="")
                                                              showDialog(
                                                                  context: context,
                                                                  builder: ((builder)=>
                                                                      AlertDialog(
                                                                        content: Stack(
                                                                          children: [
                                                                            Container(
                                                                              height:250,
                                                                              width: 1800,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                  top:20.0,
                                                                                ),
                                                                                child: Image.file(
                                                                                  File(coursesController.image.value!),
                                                                                  width:1300,
                                                                                  height: 100,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Positioned(
                                                                                top: -15,
                                                                                right: -10,
                                                                                child: IconButton(
                                                                                  onPressed:(){Navigator.pop(context);},
                                                                                  icon:Icon(Icons.close,size: 30,),
                                                                                )
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                  )
                                                              );
                                                            else if(widget.record.orderUrl!.split('?').first.endsWith('.jpg')||
                                                                widget.record.orderUrl!.split('?').first.endsWith('.jpeg')||
                                                                widget.record.orderUrl!.split('?').first.endsWith('.png')
                                                            )
                                                              showDialog(
                                                                  context: context,
                                                                  builder: ((builder)=>
                                                                      AlertDialog(
                                                                        content: Stack(
                                                                          children: [
                                                                            Container(
                                                                              height:250,
                                                                              width: 1800,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                  top:20.0,
                                                                                ),
                                                                                child: Image.network(
                                                                                  widget.record.orderUrl!,
                                                                                  width:1300,
                                                                                  height: 100,
                                                                                  fit: BoxFit.fill,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Positioned(
                                                                                top: -15,
                                                                                right: -10,
                                                                                child: IconButton(
                                                                                  onPressed:(){Navigator.pop(context);},
                                                                                  icon:Icon(Icons.close,size: 30,),
                                                                                )
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                  )
                                                              );
                                                            else {
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (
                                                                          (builder)=>AlertDialog(
                                                                        content: Container(
                                                                          height: 500,
                                                                          width: 2500,
                                                                          child: SfPdfViewer.network(widget.record.orderUrl!,),
                                                                        ),
                                                                      )
                                                                  )
                                                              );
                                                            }



                                                          }
                                                        ,
                                                      ),
                                                      IconButton(
                                                        icon:Icon(Icons.edit),
                                                        onPressed: (){
                                                          showModalBottomSheet(
                                                              context: context,
                                                              builder: ((builder)=>bottomSheet())
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              SizedBox(height: 30,),
                              GestureDetector(
                                onTap: ()async{
                                  errorList=[];
                                  if(widget.record.type.toLowerCase().trim()=="rides airport transfers"){
                                    try{
                                      if(coursesController.pickUpLocationConroller.text=="")
                                        errorList.add("pick-up location");
                                      if(coursesController.dropOffLocationConroller.text=="")
                                        errorList.add("drop off location");
                                      if(coursesController.passagersConroller.text=="" )
                                        errorList.add("passengers number");

                                      if(errorList.isEmpty){
                                      Get.to(()=>EditCourseXl(
                                      course: CourseModel(
                                          id: widget.record.id,
                                          type: "Rides Airport transfers",
                                          pickUpLocation: coursesController.pickUpLocationConroller.text,
                                          dropOffLocation: coursesController.dropOffLocationConroller.text,
                                          pickUpDate: dateTimePickUp,
                                          passengersNum: int.tryParse(coursesController.passagersConroller.text) ?? 0,
                                          driverName: coursesController.selectedItem.value,
                                          identityNum: coursesController.selectedItemId.value,
                                          passengersDetails: widget.record.passengersDetails
                                      ),
                                    ));
                                      }
                                      else showDialog(
                                          context: context,
                                          builder: ((builder)=>AlertDialog(
                                            content: Container(
                                              height:70,
                                              width: 100,
                                              child: Column(
                                                children: [
                                                  const Icon(IconData(0xe6cb, fontFamily: 'MaterialIcons')),
                                                  Text('verify your data :\n'+errorList.join(",")),
                                                ],
                                              ),
                                            ),
                                          ))
                                      );

                                    }catch(e){
                                      print(e.toString());
                                    }

                                  }
                                  else if(widget.record.type.toLowerCase().trim()=="car hire"){
                                    try {
                                      if(coursesController.pickUpLocationConroller.text=="")
                                        errorList.add("pick-up location");

                                      if(coursesController.dropOffLocationConroller.text=="")
                                        errorList.add("drop off location");


;

                                      if(errorList.isEmpty) {
                                        if (coursesController.image.value != "") {
                                          final orderImageURL;
                                          final driverUploadTask = FirebaseStorage
                                              .instance.ref(
                                              'order/' + DateTime
                                                  .now()
                                                  .difference(
                                                  DateTime(2022, 1, 1))
                                                  .inSeconds
                                                  .toString() +
                                                  '${coursesController.image.value
                                                      ?.split('/')
                                                      .last}')
                                              .putFile(File(
                                              coursesController.image.value));
                                          final driverSnapshot = await driverUploadTask
                                              .whenComplete(() => null);
                                          orderImageURL = await driverSnapshot.ref
                                              .getDownloadURL();
                                          coursesController.update_course(
                                              CourseModel(
                                                id:widget.record.id,
                                                  type: "car hire",
                                                  pickUpLocation: coursesController
                                                      .pickUpLocationConroller
                                                      .text,
                                                  dropOffLocation: !isChecked ?
                                                  coursesController.dropOffLocationConroller.text
                                                      : "",
                                                  pickUpDate: dateTimePickUp,
                                                  dropOffDate: dateTimeDropOff,
                                                  driverName: coursesController
                                                      .selectedItem.value,
                                                  orderUrl: orderImageURL,
                                                identityNum: coursesController.selectedItemId.value
                                              )
                                          );
                                          coursesController.init();
                                          Get.back();
                                        }
                                        else{
                                          coursesController.update_course(
                                              CourseModel(
                                                id:widget.record.id,
                                                  type: "car hire",
                                                  pickUpLocation: coursesController.pickUpLocationConroller.text,
                                                  dropOffLocation: !isChecked ?
                                                  coursesController.dropOffLocationConroller.text : "",
                                                  pickUpDate: dateTimePickUp,
                                                  dropOffDate: dateTimeDropOff,
                                                  driverName: coursesController.selectedItem.value,
                                                  orderUrl: widget.record.orderUrl,
                                                identityNum: coursesController.selectedItemId.value
                                              )
                                          );
                                          coursesController.init();
                                          Get.back();
                                        }
                                      }
                                      else showDialog(
                                          context: context,
                                          builder: ((builder)=>AlertDialog(
                                            content: Container(
                                              height:70,
                                              width: 100,
                                              child: Column(
                                                children: [
                                                  const Icon(IconData(0xe6cb, fontFamily: 'MaterialIcons')),
                                                  Text('verify your data :\n'+errorList.join(",")),
                                                ],
                                              ),
                                            ),
                                          ))
                                      );

                                    }catch(e){
                                      print(e.toString());
                                    }
                                  }
                                },
                                child: Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFF1A8FDD)
                                  ),
                                  child: Center(
                                      child:widget.record.type.toLowerCase().trim()!="car hire"
                                          ? Text('Next',style: TextStyle(color: Colors.white),)
                                          : Text('Edit',style: TextStyle(color: Colors.white),))
                                  ,
                                ),
                              )
                            ],
                          ),)
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
                onTap: getImage,
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

  Future getImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        coursesController.image.value = pickedFile!.path;
      } else {
        print('No image selected.');
      }
    });
    // Navigator.pop(context);
  }


}
