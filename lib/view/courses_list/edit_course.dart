
import 'dart:io';

import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/course.dart';
import 'package:admin_citygo/models/course_model.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
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


  void initState() {
    // TODO: implement initState
    super.initState();
    coursesController.init();
    driversController.fetchDrivers();
    coursesController.pickUpLocationConroller.text =widget.record.pickUpLocation ;
    coursesController.dropOffLocationConroller.text =widget.record.dropOffLocation!;
    coursesController.passagersConroller.text =widget.record.passengersNum.toString();
    coursesController.regNumberController.text =widget.record.regNumber.toString();
    coursesController.seatingCapacityController.text =widget.record.seatingCapacity.toString();
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
    if(widget.record.check=="car") {
      coursesController.checkBox2.value = true;
      coursesController.passengerCarDetails.value = widget.record.passengersDetails!;
    }
    if(widget.record.check=="passengers"){
    coursesController.passengerDetails.value = widget.record.passengersDetails!;
    coursesController.checkBox1.value=true;
    }

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
                              Container(
                                  color: Color(0xFF0F5CA0).withOpacity(0.8),
                                  height: MediaQuery.of(context).size.height*0.735,
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Form(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
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
                                          SizedBox(height: 15),
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
                                          SizedBox(height: 13),
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
                                                print(newValue?.id);
                                                print(newValue?.identityNumber);
                                                coursesController
                                                    .selectedItemId!.value =
                                                    newValue!.identityNumber;
                                                print(coursesController
                                                    .selectedItem!.value);
                                                print(coursesController
                                                    .selectedItemId!.value);
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
                                          SizedBox(height: 12),
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
                                                          if (coursesController
                                                              .checkBox1.value ==
                                                              false) {
                                                            coursesController
                                                                .importFromExcelForPassenger()
                                                                .then((value) {
                                                              {
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
                                                            coursesController
                                                                .checkBox1.value =
                                                            !coursesController
                                                                .checkBox1.value;
                                                            coursesController
                                                                .passengerDetails
                                                                .value = [];
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
                                                          coursesController.importFromExcelForPassenger();
                                                        },
                                                      ),
                                                      IconButton(
                                                        icon: Icon(Icons.remove_red_eye,size:20,color: Colors.white,),
                                                        onPressed: (){
                                                          if(coursesController.passengerDetails.value!=null)
                                                          Get.dialog(
                                                            AlertDialog(
                                                              content:  Container(
                                                                  width: MediaQuery.of(context).size.width*0.75,
                                                                  height: MediaQuery.of(context).size.height*0.53,
                                                                  child: SingleChildScrollView(
                                                                    scrollDirection: Axis.vertical,
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.horizontal,
                                                                      child: DataTable(
                                                                        columnSpacing: 5,
                                                                        dataRowHeight: 50,
                                                                        columns: const <DataColumn>[
                                                                          DataColumn(
                                                                            label: Expanded(
                                                                              child: Text(
                                                                                'First Name',
                                                                                style: TextStyle(fontStyle: FontStyle.italic),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataColumn(
                                                                            label: Expanded(
                                                                              child: Text(
                                                                                'Last Name',
                                                                                style: TextStyle(fontStyle: FontStyle.italic),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataColumn(
                                                                            label: Expanded(
                                                                              child: Text(
                                                                                'Identity Number',
                                                                                style: TextStyle(fontStyle: FontStyle.italic),
                                                                              ),
                                                                            ),
                                                                            numeric: true,
                                                                          ),
                                                                        ],
                                                                      
                                                                        rows: List<DataRow>.generate(coursesController.passengerDetails.length, (int index) =>
                                                                            DataRow(
                                                                                cells:<DataCell>[
                                                                                  DataCell(Text(coursesController.passengerDetails[index].firstname)),
                                                                                  DataCell(Text(coursesController.passengerDetails[index].lastName)),
                                                                                  (coursesController.passengerDetails[index].identityNum.contains('.') && coursesController.passengerDetails[index].identityNum.endsWith('.0'))?
                                                                                  DataCell(Text(coursesController.passengerDetails[index].identityNum.substring(0, coursesController.passengerDetails[index].identityNum.indexOf('.'))))
                                                                                      :
                                                                                  DataCell(Text(coursesController.passengerDetails[index].identityNum)),

                                                                                ]
                                                                            )
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                              ),
                                                            )
                                                          );
                                                        },
                                                      ),
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
                                                                      // actions: <Widget>[
                                                                      //   TextButton(
                                                                      //     child: const Text('Approve'),
                                                                      //     onPressed: () {
                                                                      //       Navigator.of(context).pop();
                                                                      //     },
                                                                      //   ),
                                                                      // ],
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
                                                                                      onPressed: () {
                                                                                        coursesController.importFromExcel();
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
                                                                                    if (coursesController.image.value != "" && coursesController.passengerDetails.value != []) {
                                                                                      if (coursesController.checkBox1.value == true) {
                                                                                        coursesController.checkBox1.value = !coursesController.checkBox1.value;
                                                                                        coursesController.checkBox2.value = !coursesController.checkBox2.value;
                                                                                      } else {
                                                                                        coursesController.checkBox2.value = !coursesController.checkBox2.value;
                                                                                      }
                                                                                      Navigator.pop(context);
                                                                                    } else {
                                                                                      print('errrororororo');
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
                                                                          )),
                                                                    ));
                                                            //     .then((value) {
                                                            //   if(coursesController.passengerDetails.value!=[]&& coursesController.image.value!=""){
                                                            //   if(coursesController.checkBox1.value==true){
                                                            //     coursesController.checkBox1.value=!coursesController.checkBox1.value;
                                                            //     coursesController.checkBox2.value=!coursesController.checkBox2.value;
                                                            //   }
                                                            //   else{
                                                            //     coursesController.checkBox2.value=!coursesController.checkBox2.value;
                                                            //   }
                                                            //   }
                                                            // }
                                                            // );
                                                          } else {
                                                            coursesController
                                                                .checkBox2.value =
                                                            !coursesController
                                                                .checkBox2.value;
                                                            coursesController
                                                                .image.value = "";
                                                            coursesController
                                                                .passengerDetails
                                                                .value = [];
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
                                                                                      onPressed: () {
                                                                                        coursesController.importFromExcel();
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
                                                      IconButton(
                                                        icon: Icon(Icons.remove_red_eye,size:20,color: Colors.white,),
                                                        onPressed: (){
                                                          if(coursesController.passengerCarDetails.value!=null)
                                                          Get.dialog(
                                                            AlertDialog(
                                                              content: Container(
                                                                width: MediaQuery.of(context).size.width*0.75,
                                                                height: MediaQuery.of(context).size.height*0.5,
                                                                child:Column(
                                                                  children: [
                                                                    Container(
                                                                      height:MediaQuery.of(context).size.height*0.1,
                                                                      width: MediaQuery.of(context).size.width*0.6,
                                                                      child:
                                                                      coursesController.image.value!="" && coursesController.image.value!.split('/')!.last.endsWith('.pdf')
                                                                          ?Padding(
                                                                          padding: EdgeInsets.all(
                                                                              10
                                                                          ),
                                                                          child: Column(
                                                                            children: [
                                                                              Icon(Icons.file_open),
                                                                              Text(
                                                                                coursesController.image.value!.split('/')!.last,
                                                                                style: TextStyle(
                                                                                  fontSize: 8,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ))
                                                                          :coursesController.image.value!=""
                                                                          ?Padding(
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: Image.file(File(
                                                                          coursesController.image.value!),
                                                                          width: 100,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      )
                                                                          :widget.record.orderUrl!.split('?').first.endsWith('.jpg')||
                                                                          widget.record.orderUrl!.split('?').first.endsWith('.jpeg')||
                                                                          widget.record.orderUrl!.split('?').first.endsWith('.png')
                                                                          ?Padding(
                                                                        padding: const EdgeInsets.all(3.0),
                                                                        child: Image.network(
                                                                          widget.record.orderUrl!,
                                                                          width: 100,
                                                                          fit: BoxFit.fill,
                                                                        ),
                                                                      )
                                                                          :Column(
                                                                        children: [
                                                                          Icon(Icons.file_open),
                                                                          Text('pdf File')
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height: MediaQuery.of(context).size.height*0.4,
                                                                        child: SingleChildScrollView(
                                                                          scrollDirection: Axis.vertical,
                                                                          child: SingleChildScrollView(
                                                                            scrollDirection: Axis.horizontal,
                                                                            child: DataTable(
                                                                              columnSpacing: 5,
                                                                              dataRowHeight: 50,
                                                                              columns: const <DataColumn>[
                                                                                DataColumn(
                                                                                  label: Expanded(
                                                                                    child: Text(
                                                                                      'First Name',
                                                                                      style: TextStyle(fontStyle: FontStyle.italic),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                DataColumn(
                                                                                  label: Expanded(
                                                                                    child: Text(
                                                                                      'Last Name',
                                                                                      style: TextStyle(fontStyle: FontStyle.italic),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                DataColumn(
                                                                                  label: Expanded(
                                                                                    child: Text(
                                                                                      'Identity Number',
                                                                                      style: TextStyle(fontStyle: FontStyle.italic),
                                                                                    ),
                                                                                  ),
                                                                                  numeric: true,
                                                                                ),
                                                                              ],
                                                                              // rows: const <DataRow>[
                                                                              //   DataRow(
                                                                              //     cells: <DataCell>[
                                                                              //       DataCell(Text('Sarah')),
                                                                              //       DataCell(Text('19')),
                                                                              //       DataCell(Text('Student')),
                                                                              //     ],
                                                                              //   ),
                                                                              //   DataRow(
                                                                              //     cells: <DataCell>[
                                                                              //       DataCell(Text('Janine')),
                                                                              //       DataCell(Text('43')),
                                                                              //       DataCell(Text('Professor')),
                                                                              //     ],
                                                                              //   ),
                                                                              //   DataRow(
                                                                              //     cells: <DataCell>[
                                                                              //       DataCell(Text('William')),
                                                                              //       DataCell(Text('27')),
                                                                              //       DataCell(Text('Associate Professor')),
                                                                              //     ],
                                                                              //   ),
                                                                              // ],
                                                                              rows: List<DataRow>.generate(coursesController.passengerCarDetails.length, (int index) =>
                                                                                  DataRow(
                                                                                      cells:<DataCell>[
                                                                                        DataCell(Text(coursesController.passengerCarDetails[index].firstname)),
                                                                                        DataCell(Text(coursesController.passengerCarDetails[index].lastName)),
                                                                                        (coursesController.passengerCarDetails[index].identityNum.contains('.') && coursesController.passengerCarDetails[index].identityNum.endsWith('.0'))?
                                                                                        DataCell(Text(coursesController.passengerCarDetails[index].identityNum.substring(0, coursesController.passengerCarDetails[index].identityNum.indexOf('.'))))
                                                                                            :
                                                                                        DataCell(Text(coursesController.passengerCarDetails[index].identityNum)),

                                                                                      ]
                                                                                  )
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            )
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),

                                        ],
                                      )
                                  ),
                                ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                onTap: ()async{
                                  errorList=[];

                                  try {
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

                                    if (errorList.isEmpty) {
                                      if (coursesController.checkBox1.value == true) {
                                        if(widget.record.adminId!=null)
                                        coursesController.courses.doc(
                                            widget.record.id).update(
                                            {
                                              "seen": widget.record.seen,
                                              "pickUpLocation": coursesController
                                                  .pickUpLocationConroller.text,
                                              "dropOffLocation": coursesController
                                                  .dropOffLocationConroller
                                                  .text,
                                              "pickUpDate": dateTimePickUp,
                                              if (coursesController.isReturn
                                                  .value ==
                                                  true)
                                                "dropOffDate": dateTimeDropOff,
                                              "driverName": coursesController
                                                  .selectedItem.value,
                                              "identityNum": coursesController
                                                  .selectedItemId.value,
                                              "passengersNum": int.tryParse(
                                                  coursesController
                                                      .passagersConroller
                                                      .text) ??
                                                  0,
                                              "passengersDetails": coursesController
                                                  .passengerDetails.value
                                                  ?.map((passenger) =>
                                                  passenger.toJson())
                                                  .toList(),
                                              "regNumber": coursesController
                                                  .regNumberController.text,
                                              "seatingCapacity": int.tryParse(
                                                  coursesController
                                                      .seatingCapacityController
                                                      .text) ?? 0,
                                              "check": "car",
                                              "idAdmin": widget.record.adminId
                                            }
                                        ).then((value) {
                                          coursesController.init();
                                          Get.back();
                                        });
                                        else
                                          coursesController.courses.doc(
                                              widget.record.id).update(
                                              {
                                                "pickUpLocation": coursesController
                                                    .pickUpLocationConroller.text,
                                                "dropOffLocation": coursesController
                                                    .dropOffLocationConroller
                                                    .text,
                                                "pickUpDate": dateTimePickUp,
                                                if (coursesController.isReturn
                                                    .value ==
                                                    true)
                                                  "dropOffDate": dateTimeDropOff,
                                                "driverName": coursesController
                                                    .selectedItem.value,
                                                "identityNum": coursesController
                                                    .selectedItemId.value,
                                                "passengersNum": int.tryParse(
                                                    coursesController
                                                        .passagersConroller
                                                        .text) ??
                                                    0,
                                                "passengersDetails": coursesController
                                                    .passengerDetails.value
                                                    ?.map((passenger) =>
                                                    passenger.toJson())
                                                    .toList(),
                                                "regNumber": coursesController
                                                    .regNumberController.text,
                                                "seatingCapacity": int.tryParse(
                                                    coursesController
                                                        .seatingCapacityController
                                                        .text) ?? 0,
                                                "check": "passenger",
                                              }
                                          ).then((value) {
                                            coursesController.init();
                                            Get.back();
                                          });
                                      }
                                      else
                                      if (coursesController.checkBox2.value == true) {
                                        if (coursesController.image.value != "") {
                                          final orderImageURL;
                                          final driverUploadTask = FirebaseStorage
                                              .instance
                                              .ref('order/' +
                                              DateTime
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
                                          final driverSnapshot =
                                          await driverUploadTask
                                              .whenComplete(() => null);
                                          orderImageURL =
                                          await driverSnapshot.ref
                                              .getDownloadURL();
                                          if(widget.record.adminId!=null)
                                          coursesController.courses.doc(
                                              widget.record.id).update(
                                              {
                                                "seen": widget.record.seen,
                                                "pickUpLocation": coursesController
                                                    .pickUpLocationConroller
                                                    .text,
                                                "dropOffLocation": coursesController
                                                    .dropOffLocationConroller
                                                    .text,
                                                "pickUpDate": dateTimePickUp,
                                                if (coursesController.isReturn
                                                    .value ==
                                                    true)
                                                  "dropOffDate": dateTimeDropOff,
                                                "driverName": coursesController
                                                    .selectedItem.value,
                                                "identityNum": coursesController
                                                    .selectedItemId.value,
                                                "orderUrl": orderImageURL,
                                                "passengersNum": int.tryParse(
                                                    coursesController
                                                        .passagersConroller
                                                        .text) ??
                                                    0,
                                                "passengersDetails": coursesController
                                                    .passengerCarDetails.value
                                                    ?.map((passenger) =>
                                                    passenger.toJson())
                                                    .toList(),
                                                "regNumber": coursesController
                                                    .regNumberController.text,
                                                "seatingCapacity": int.tryParse(
                                                    coursesController
                                                        .seatingCapacityController
                                                        .text) ??
                                                    0,
                                                "check": "passengers",
                                                "idAdmin": widget.record.adminId
                                              }
                                          ).then((value) {
                                            coursesController.init();
                                            Get.back();
                                          });
                                        else
                                            coursesController.courses.doc(
                                                widget.record.id).update(
                                                {
                                                  "pickUpLocation": coursesController
                                                      .pickUpLocationConroller
                                                      .text,
                                                  "dropOffLocation": coursesController
                                                      .dropOffLocationConroller
                                                      .text,
                                                  "pickUpDate": dateTimePickUp,
                                                  if (coursesController.isReturn
                                                      .value ==
                                                      true)
                                                    "dropOffDate": dateTimeDropOff,
                                                  "driverName": coursesController
                                                      .selectedItem.value,
                                                  "identityNum": coursesController
                                                      .selectedItemId.value,
                                                  "orderUrl": orderImageURL,
                                                  "passengersNum": int.tryParse(
                                                      coursesController
                                                          .passagersConroller
                                                          .text) ??
                                                      0,
                                                  "passengersDetails": coursesController
                                                      .passengerCarDetails.value
                                                      ?.map((passenger) =>
                                                      passenger.toJson())
                                                      .toList(),
                                                  "regNumber": coursesController
                                                      .regNumberController.text,
                                                  "seatingCapacity": int.tryParse(
                                                      coursesController
                                                          .seatingCapacityController
                                                          .text) ??
                                                      0,
                                                  "check": "passengers",
                                                }
                                            ).then((value) {
                                              coursesController.init();
                                              Get.back();
                                            });
                                        }
                                        else {
                                          if(widget.record.adminId!=null)
                                          coursesController.courses.doc(
                                              widget.record.id).update(
                                              {
                                                "seen": widget.record.seen,
                                                "pickUpLocation": coursesController
                                                    .pickUpLocationConroller
                                                    .text,
                                                "dropOffLocation": coursesController
                                                    .dropOffLocationConroller
                                                    .text,
                                                "pickUpDate": dateTimePickUp,
                                                if (coursesController.isReturn
                                                    .value ==
                                                    true)
                                                  "dropOffDate": dateTimeDropOff,
                                                "driverName": coursesController
                                                    .selectedItem.value,
                                                "identityNum": coursesController
                                                    .selectedItemId.value,
                                                "orderUrl": widget.record
                                                    .orderUrl,
                                                "passengersNum": int.tryParse(
                                                    coursesController
                                                        .passagersConroller
                                                        .text) ??
                                                    0,
                                                "passengersDetails": coursesController
                                                    .passengerCarDetails.value
                                                    ?.map((passenger) =>
                                                    passenger.toJson())
                                                    .toList(),
                                                "regNumber": coursesController
                                                    .regNumberController.text,
                                                "seatingCapacity": int.tryParse(
                                                    coursesController
                                                        .seatingCapacityController
                                                        .text) ??
                                                    0,
                                                "check": "passengers",
                                                "idAdmin": widget.record.adminId
                                              }
                                          ).then((value) {
                                            coursesController.init();
                                            Get.back();
                                          });
                                          else
                                            coursesController.courses.doc(
                                                widget.record.id).update(
                                                {
                                                  "pickUpLocation": coursesController
                                                      .pickUpLocationConroller
                                                      .text,
                                                  "dropOffLocation": coursesController
                                                      .dropOffLocationConroller
                                                      .text,
                                                  "pickUpDate": dateTimePickUp,
                                                  if (coursesController.isReturn
                                                      .value ==
                                                      true)
                                                    "dropOffDate": dateTimeDropOff,
                                                  "driverName": coursesController
                                                      .selectedItem.value,
                                                  "identityNum": coursesController
                                                      .selectedItemId.value,
                                                  "orderUrl": widget.record
                                                      .orderUrl,
                                                  "passengersNum": int.tryParse(
                                                      coursesController
                                                          .passagersConroller
                                                          .text) ??
                                                      0,
                                                  "passengersDetails": coursesController
                                                      .passengerCarDetails.value
                                                      ?.map((passenger) =>
                                                      passenger.toJson())
                                                      .toList(),
                                                  "regNumber": coursesController
                                                      .regNumberController.text,
                                                  "seatingCapacity": int.tryParse(
                                                      coursesController
                                                          .seatingCapacityController
                                                          .text) ??
                                                      0,
                                                  "check": "passengers",
                                                }
                                            ).then((value) {
                                              coursesController.init();
                                              Get.back();
                                            });
                                        }
                                      }
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
                                  }catch(e){
                                    print(e.toString());
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
