import 'dart:io';

import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/driver_list/drivers_controller.dart';
import 'package:getwidget/getwidget.dart';

import '../../models/driver_model.dart';


class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({Key? key}) : super(key: key);

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  DriversController driversController = Get.put(DriversController());

  CoursesController coursesController =Get.put(CoursesController());

  LoginController loginController =Get.put(LoginController());

  XFile? pickedFile;
  final picker = ImagePicker();

  List<String> errorList =[];

 void initState() {
    // TODO: implement initState
    super.initState();
    driversController.fetchDrivers();
    coursesController.pickUpLocationConroller.text ="" ;
    coursesController.dropOffLocationConroller.text ="" ;
    coursesController.passagersConroller.text ="" ;
    coursesController.selectedItem.value="Driver name";

  coursesController.init();
  }
/////////////////pick up date //////////////////////
   DateTime dateTimePickUp = DateTime(
     DateTime.now().year,
     DateTime.now().month,
     DateTime.now().day,
     DateTime.now().hour,
     DateTime.now().minute,
   );

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
  Future dropDateTime()async{
    DateTime? date = await dropDate();
    if(date== null )return;

    TimeOfDay? time = await dropTime();
    if(time==null)return;

    final dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute
    );
    setState(() {
      this.dateTimeDropOff =dateTime;
    });

  }
  ///////////////////////////////////////////


  @override
  Widget build(BuildContext context) {
    final hours = dateTimePickUp.hour.toString().padLeft(2,'0');
    final minutes = dateTimePickUp.minute.toString().padLeft(2,'0');

    final hoursDrop = dateTimeDropOff.hour.toString().padLeft(2,'0');
    final minutesDrop = dateTimeDropOff.minute.toString().padLeft(2,'0');


    return  Scaffold(
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
            child: Text("Add course",style: TextStyle(
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
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Center(
                        child: Obx(()=>Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF0F5CA0).withOpacity(0.8),
                                  borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                )
                              ),
                              height: MediaQuery.of(context).size.height*0.72,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Form(
                                key: coursesController.formKey,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.85,
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
                                      SizedBox(height: 13),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.85,
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
                                      SizedBox(height: 13),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.85,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    pickDateTime();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    height: 60,
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
                                                InkWell(
                                                  onTap: (){
                                                    if(coursesController.isReturn.value==false){
                                                      coursesController.checkBox1.value=true;
                                                      coursesController.isReturn.value=true;
                                                    }

                                                    if(coursesController.isReturn.value)
                                                      dropDateTime();
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width*0.4,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.7),
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(5),
                                                          topLeft: Radius.circular(5),
                                                        )
                                                    ),
                                                    child: coursesController.isReturn.value
                                                    ?Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Drop off Date",
                                                          style: TextStyle(
                                                              fontFamily: 'Georgia',
                                                              fontSize:18,
                                                              color: Color(0xFF0F5CA0)),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Text('${dateTimeDropOff.year}/${dateTimeDropOff.month}/${dateTimeDropOff.day}'),
                                                            Text('$hoursDrop:$minutesDrop'),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10,)
                                                      ],
                                                    )
                                                    :Container(
                                                        height: 60,
                                                        width:100,
                                                        child: Center(
                                                            child: Text(
                                                                'Return Date',
                                                              style: TextStyle(
                                                                color: Color(0xFF0F5CA0),
                                                                fontSize: 15,
                                                                fontFamily: 'Georgia',

                                                              ),
                                                            ))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if(coursesController.isReturn.value)
                                            SizedBox(
                                              height:20,
                                              width:100,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.transparent)
                                                ),
                                                onPressed: (){
                                                  coursesController.isReturn.value=false;
                                                  coursesController.checkBox1.value=false;
                                                },
                                                child: Container(
                                                    child: Text('cancel',style:TextStyle(color:Colors.white))),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 13),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.85,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.7),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              topLeft: Radius.circular(5),
                                            )
                                        ),
                                        child: TextFormField(
                                          controller: coursesController.passagersConroller,
                                          keyboardType:TextInputType.number,
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
                                      SizedBox(height: 13),
                                      // Container(
                                      //   width: MediaQuery.of(context).size.width*0.85,
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.white.withOpacity(0.7),
                                      //       borderRadius: BorderRadius.only(
                                      //         topRight: Radius.circular(5),
                                      //         topLeft: Radius.circular(5),
                                      //       )
                                      //   ),
                                      //   child: TextFormField(
                                      //     controller: coursesController.luggageConroller,
                                      //     keyboardType:TextInputType.number ,
                                      //     decoration: InputDecoration(
                                      //       labelStyle: TextStyle(
                                      //           fontFamily: 'Georgia',
                                      //           color: Color(0xFF0F5CA0)),
                                      //       labelText: 'Luggage',
                                      //       prefixIcon: Icon(Icons.luggage),
                                      //       border: InputBorder.none,
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.85,
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
                                      SizedBox(height: 13),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.85,
                                        height: 65,
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
                                            controller: coursesController.regNumberController,
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
                                      SizedBox(height: 13),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.85,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.7),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              topLeft: Radius.circular(5),
                                            )
                                        ),
                                        child: TextFormField(
                                          controller: coursesController.seatingCapacityController,
                                          keyboardType:TextInputType.number,
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              GFCheckbox(
                                                inactiveBgColor:Colors.transparent,
                                                size: 20,
                                                activeBgColor: Colors.transparent,
                                                inactiveBorderColor: Colors.white,
                                                type: GFCheckboxType.square,
                                                onChanged: (value) {
                                                  if(coursesController.checkBox2.value==true){
                                                    coursesController.checkBox1.value=!coursesController.checkBox1.value;
                                                    coursesController.checkBox2.value=!coursesController.checkBox2.value;
                                                    }
                                                  else{
                                                    coursesController.checkBox1.value=!coursesController.checkBox1.value;
                                                  }
                                                },
                                                value: coursesController.checkBox1.value,
                                                inactiveIcon: null,
                                              ),
                                              Text('Check passengers'
                                                ,style: TextStyle(color: Colors.white),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GFCheckbox(
                                                inactiveBgColor:Colors.transparent,
                                                size: 20,
                                                activeBgColor: Colors.transparent,
                                                inactiveBorderColor: Colors.white,
                                                type: GFCheckboxType.square,
                                                onChanged: (value) {
                                                  if(coursesController.checkBox1.value==true){
                                                    coursesController.checkBox1.value=!coursesController.checkBox1.value;
                                                    coursesController.checkBox2.value=!coursesController.checkBox2.value;
                                                }
                                                  else{
                                                    coursesController.checkBox2.value=!coursesController.checkBox2.value;

                                                  }
                                                },
                                                value: coursesController.checkBox2.value,
                                                inactiveIcon: null,
                                              ),
                                              Text('Check car'
                                                ,style: TextStyle(color: Colors.white),),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 13),
                                      if(coursesController.checkBox1.value && !coursesController.checkBox2.value )
                                        Padding(
                                          padding: const EdgeInsets.only(right:8.0),
                                          child: ElevatedButton(
                                              style:ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.9))
                                              ),
                                              onPressed: (){
                                                coursesController.importFromExcelForPassenger();
                                              },
                                              child: Text('Check passengers',
                                                style: TextStyle(
                                                    color: Color(0xFF0F5CA0).withOpacity(0.8)
                                                ),)

                                          ),
                                        ),
                                      if(coursesController.checkBox2.value && !coursesController.checkBox1.value)
                                        Padding(
                                          padding: const EdgeInsets.only(right:8.0),
                                          child: ElevatedButton(
                                              style:ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.9))
                                              ),
                                              onPressed: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (builder)=>AlertDialog(
                                                      content: Container(
                                                          height: 200,
                                                          child:Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              SizedBox(
                                                                width:200,
                                                                child: ElevatedButton(
                                                                  style:ButtonStyle(
                                                                    backgroundColor:
                                                                    MaterialStateProperty.all(Color(0xFF0F5CA0)),
                                                                  ),
                                                                  child: Text(
                                                                    'Add an order',
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontFamily: 'Georgia'
                                                                    ),
                                                                  ),
                                                                  onPressed: (){
                                                                    showModalBottomSheet(
                                                                        context: context,
                                                                        builder: (builder)=>bottomSheet()
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:200,
                                                                child: ElevatedButton(
                                                                  style:ButtonStyle(
                                                                    backgroundColor:
                                                                    MaterialStateProperty.all(Color(0xFF0F5CA0)),
                                                                  ),
                                                                  child: Text(
                                                                    'Add list of passengers',
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontFamily: 'Georgia'
                                                                    ),
                                                                  ),
                                                                  onPressed: (){
                                                                    coursesController.importFromExcel();
                                                                  },
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width:150,
                                                                child: ElevatedButton(
                                                                  style:ButtonStyle(
                                                                    backgroundColor:
                                                                    MaterialStateProperty.all(Color(0xFF000000).withOpacity(0.61)),
                                                                  ),
                                                                  child: Text(
                                                                    'Next',
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontFamily: 'Georgia'
                                                                    ),
                                                                  ),
                                                                  onPressed: (){

                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                      ),
                                                    )
                                                );
                                              },
                                              child: Text('Check car',
                                                style: TextStyle(
                                                    color: Color(0xFF0F5CA0).withOpacity(0.8)
                                                ),)

                                          ),
                                        )
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: ()async{
                                errorList=[];
                                print('///////////////////////////////////');

                                print(dateTimePickUp);


                                print('///////////////////////////////////');

                                  if(coursesController.pickUpLocationConroller.text=="")
                                    errorList.add("pick-up location");
                                  if(coursesController.dropOffLocationConroller.text=="")
                                    errorList.add("drop off location");
                                  if(coursesController.passagersConroller.text=="" )
                                    errorList.add("passengers number");
                                  if(coursesController.selectedItem.toLowerCase()=="driver name")
                                    errorList.add("driver name");
                                  if(coursesController.regNumberController.text=="" )
                                    errorList.add("reg number");
                                  if(coursesController.seatingCapacityController.text=="" )
                                    errorList.add("seating capacity");

                                  if(errorList.isEmpty) {
                                  if (coursesController.checkBox1.value == true){
                                    if(coursesController.passengerDetails.value.isNotEmpty){
                                    //   coursesController.courses.add({
                                    //   "pickUpLocation": coursesController
                                    //       .pickUpLocationConroller.text,
                                    //   "dropOffLocation": coursesController
                                    //       .dropOffLocationConroller.text,
                                    //   "pickUpDate": Timestamp.fromDate(
                                    //       dateTimePickUp),
                                    //   if(coursesController.isReturn.value ==
                                    //       true)"dropOffDate": Timestamp
                                    //       .fromDate(dateTimeDropOff),
                                    //   "driverName": coursesController.selectedItem.value,
                                    //   "identityNum": coursesController.selectedItemId.value,
                                    //   if(coursesController.image.value != "")"orderUrl": coursesController.image.value,
                                    //   "passengersNum": int.tryParse(coursesController.passagersConroller.text) ?? 0,
                                    //   "passengersDetails": coursesController.passengerDetails.value?.map((
                                    //       passenger) => passenger.toJson()).toList(),
                                    //   "regNumber": coursesController.regNumberController.text,
                                    //   "seatingCapacity": int.tryParse(coursesController.seatingCapacityController.text) ?? 0,
                                    //     "check":"passengers"
                                    // }).then(
                                    //           (value) {
                                    //             coursesController.init();
                                    //             Get.back();
                                    //           }
                                    //   );
                                    }else
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("add the excel file of details passenger"),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                  }
                                  else if (coursesController.checkBox2.value == true) {
                                    if(coursesController.image.value!=""){
                                      if(coursesController.passengerCarDetails.value.isNotEmpty){
                                    // final orderImageURL;
                                    // final driverUploadTask = FirebaseStorage
                                    //     .instance.ref(
                                    //     'order/' + DateTime
                                    //         .now()
                                    //         .difference(
                                    //         DateTime(2022, 1, 1))
                                    //         .inSeconds
                                    //         .toString() +
                                    //         '${coursesController.image.value
                                    //             ?.split('/')
                                    //             .last}').putFile(
                                    //     File(coursesController.image.value));
                                    // final driverSnapshot = await driverUploadTask.whenComplete(() => null);
                                    // orderImageURL = await driverSnapshot.ref.getDownloadURL();
                                    // coursesController.courses.add( {
                                    //   "pickUpLocation": coursesController.pickUpLocationConroller.text,
                                    //   "dropOffLocation": coursesController.dropOffLocationConroller.text,
                                    //   "pickUpDate": Timestamp.fromDate(
                                    //       dateTimePickUp),
                                    //   "driverName": coursesController.selectedItem.value,
                                    //   "identityNum": coursesController.selectedItemId.value,
                                    //   "orderUrl": orderImageURL,
                                    //   "passengersNum": int.tryParse(coursesController.passagersConroller.text) ?? 0,
                                    //   "passengersDetails": coursesController.passengerCarDetails.value?.map((
                                    //       passenger) => passenger.toJson()).toList(),
                                    //   "regNumber": coursesController.regNumberController.text,
                                    //   "seatingCapacity": int.tryParse(coursesController.seatingCapacityController.text) ?? 0,
                                    //   "check":"car"
                                    // }).then((value) {
                                    //   coursesController.init();
                                    //   Get.back();
                                    // });
                                  }
                                    else
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("add the excel file of details passenger"),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                    }
                                    else
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("add the order"),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );

                                  }
                                  else
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("select a check type"),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );

                                }
                                  else {
                                      showDialog(
                                        context: context,
                                        builder: ((builder)=>AlertDialog(
                                          content: Container(
                                            height:110,
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
                                    }

                              },
                              child: Container(
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFF1A8FDD)
                                ),
                                child: Center(child:Text('Add',style: TextStyle(color: Colors.white),)),
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
