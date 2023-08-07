import 'dart:io';
import 'dart:typed_data';

import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/driver_list/drivers_controller.dart';
import 'package:flutter_excel/excel.dart';

import '../../models/course_model.dart';

class AddCourseXl extends StatefulWidget {
   AddCourseXl({
     Key? key,
     required this.course
   }) : super(key: key);

   CourseModel course;

  @override
  State<AddCourseXl> createState() => _AddCourseXlState();
}

class _AddCourseXlState extends State<AddCourseXl> {

  DriversController driversController = Get.put(DriversController());

  CoursesController coursesController =Get.put(CoursesController());
  LoginController loginController =Get.put(LoginController());


// DateTime dateTime = DateTime.now();
//   DateTime dateTime = DateTime(2022,12,24,5,30);
//
//   Future pickDateTime()async{
//     DateTime? date = await pickDate();
//     if(date== null )return;
//
//     TimeOfDay? time = await pickTime();
//     if(time==null)return;
//
//     final dateTime = DateTime(
//         date.year,
//         date.month,
//         date.day,
//         time.hour,
//         time.minute
//     );
//     setState(() {
//       this.dateTime =dateTime;
//     });
//
//   }

  //
  // Future<DateTime?> pickDate()=> showDatePicker(
  //     context: context,
  //     initialDate: dateTime,
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100)
  // );
  // Future<TimeOfDay?> pickTime()=>showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
  // );


  List<rowdata> rowdetail = [];

  String? file;
  _importFromExcel() async {

     rowdetail = [];

    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    // var file =
    //     "storage/emulated/0/Android/data/com.xxxx.xxxx/files/Download/Input.xlsx";
     file = pickedFile?.files.single.path;
    var bytes = File(file!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    var isFirstRow = true;
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (isFirstRow) {
          isFirstRow = false;
          continue; // Skip the first row (header row)
        }
        print("/////////////////////////////////////");
        print(row);
        // rowdetail.add(row[0]?.value);
        // print(row[0]?.value);
        // print(row[1]?.value);
        // print(row[2]!.value.toString());
        setState(() {
          rowdetail.add(
              rowdata(
                firstname: row[0]?.value ?? "",
                lastName: row[1]?.value ?? "",
                identityNum: row[2]?.value.toString() ?? "",
              ));
        });

        print("/////////////////////////////////////");

      }
    }
    print(rowdetail);

    // rowdetail.forEach((row) {
    //   print("First Name: ${row.firstname}");
    //   print("Last Name: ${row.lastName}");
    //   print("Identity Number: ${row.identityNum}");
    //   print("/////////////////////////////////////");
    // });

    // for (int j=0 ;j<excel.tables.keys.length){
    //   for (int k=0,k<excel.tables[table]!.rows.)
    // }
    // print(rowdetail);

    // for (int i=0;i<rowdetail.length;i++){
    //   print(rowdetail[2]);
    // }
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        resizeToAvoidBottomInset:false,
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
                  SizedBox(height: 40,),
                  Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      child: Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF0F5CA0).withOpacity(0.7),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )
                                ),
                                height: 85,
                                width: MediaQuery.of(context).size.width*0.8,
                                child: Center(
                                    child: Text(
                                        // '\t\t\t\t\t\t\t\t\t\tRides\n Airport transfers',
                                        'Rides Airport transfers',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Georgia"
                                        )
                                    )
                                ),
                              ),
                            ),
                            Container(
                              color: Color(0xFF0F5CA0).withOpacity(0.8),
                              height: MediaQuery.of(context).size.height*0.5,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Form(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 30,),
                                      GestureDetector(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*0.75,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.7),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                              )
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left:20.0,
                                                right:20.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  file==null
                                                  ?Text("Add file")
                                                  :Text(file!.split("/").last),
                                                  Icon(Icons.file_open)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: _importFromExcel,
                                      ),

                                      if(rowdetail.isNotEmpty)
                                    Container(
                                        width: MediaQuery.of(context).size.width*0.75,
                                        height: MediaQuery.of(context).size.height*0.3,
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
                                                rows: List<DataRow>.generate(rowdetail.length, (int index) =>
                                                    DataRow(
                                                        cells:<DataCell>[
                                                          DataCell(Text(rowdetail[index].firstname)),
                                                          DataCell(Text(rowdetail[index].lastName)),
                                                          (rowdetail[index].identityNum.contains('.') && rowdetail[index].identityNum.endsWith('.0'))?
                                                            DataCell(Text(rowdetail[index].identityNum.substring(0, rowdetail[index].identityNum.indexOf('.'))))
                                                          :
                                                            DataCell(Text(rowdetail[index].identityNum)),

    ]
                                                    )
                                                ),
                                              ),
                                            ),
                                          )
                                          )
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(height: 30,),
                            GestureDetector(
                              child: Container(
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xFF1A8FDD)
                                ),
                                child: Center(child: Text('Add',style: TextStyle(color: Colors.white),)),
                              ),
                              onTap: (){
                                print('adddd');
                                coursesController.add_course(
                                    CourseModel(
                                        type:widget.course.type,
                                        pickUpLocation: widget.course.pickUpLocation,
                                        dropOffLocation: widget.course.dropOffLocation,
                                        pickUpDate: widget.course.pickUpDate,
                                        passengersNum: widget.course.passengersNum,
                                        driverName: coursesController.selectedItem.value,
                                        passengersDetails: rowdetail,
                                        identityNum: coursesController.selectedItemId.value
                                    )

                                ).then((value) {
                                  Get.back();
                                  Get.back();
                                });
                              },
                            )
                          ],
                        ),
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
}
