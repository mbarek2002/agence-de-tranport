import 'package:admin_citygo/controllers/courses/courses_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/course.dart';
import 'package:admin_citygo/models/rowData.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/courses_list/courses_list_screen.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoursePassengerDetail extends StatefulWidget {
  CoursePassengerDetail({Key? key, required this.course}) : super(key: key);

  Course course;

  @override
  State<CoursePassengerDetail> createState() => _CoursePassengerDetailState();
}

class _CoursePassengerDetailState extends State<CoursePassengerDetail> {
  CoursesController coursesController = Get.put(CoursesController());
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: IconButton(
            iconSize: 35,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: Color(0xFF0F5CA0),
        title: Padding(
          padding: EdgeInsets.only(top: 30, left: 0),
          child: Text(
            "Passengers List",
            style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Georgia"),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(tHomebackground))),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                  color: Color(0xFF0F5CA0)),
            ),
            SizedBox(
              height: size.height*.05,
            ),
            Flexible(
              child: Container(
                // margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF0F5CA0).withOpacity(0.6),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                  // height: MediaQuery.of(context).size.height * 0.75,
                  // height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width*0.95,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:
                      Column(
                        children: [
                          Container(
                            // height: MediaQuery.of(context).size.height * 0.68,
                            child: DataTable(
                              columnSpacing: 5,
                              dataRowHeight: 50,
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        'First Name',
                                        style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        'Last Name',
                                        style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        'Phone Number',
                                        style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  numeric: true,
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        'State',
                                        style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  numeric: true,
                                ),
                              ],
                              rows: List<DataRow>.generate(
                                  widget.course.passengersDetails!.length,
                                      (int index) => DataRow(cells: <DataCell>[
                                    DataCell(GestureDetector(
                                      onTap: (){
                                        print("//////////////");
                                        print(widget.course.passengersDetails![index].passengersNumber.toString());
                                        print(widget.course.passengersDetails![index].collieNumber.toString());
                                        print("//////////////");
                                        return;
                                        showDialog(
                                            context: context,
                                            builder: (builder)=>AlertDialog(
                                              content:Container(
                                                height: MediaQuery.of(context).size.height*0.35,
                                                color: Color(0xFF0F5CA0).withOpacity(0.6),
                                                child: Column(
                                                  children: [
                                                      Padding(
                                                      padding:EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:MediaQuery.of(context).size.height*0.01
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.6),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('First Name : '),
                                                            Text(widget.course.passengersDetails![index].firstname)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                      Padding(
                                                      padding:EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:MediaQuery.of(context).size.height*0.01
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.6),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('Last Name : '),
                                                            Text(widget.course.passengersDetails![index].lastName)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                      Padding(
                                                      padding:EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:MediaQuery.of(context).size.height*0.01
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.6),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('Phone Number : '),
                                                            Text((widget.course.passengersDetails![index].phoneNum
                                                                .contains('.') &&
                                                                widget.course.passengersDetails![index].phoneNum
                                                                    .endsWith('.0'))
                                                            ?widget.course
                                                                .passengersDetails![index].phoneNum
                                                                .substring(
                                                                0,
                                                                widget.course.passengersDetails![index]
                                                                    .phoneNum
                                                                    .indexOf('.'))
                                                                :widget.course.passengersDetails![index].phoneNum

                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                      Padding(
                                                      padding:EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:MediaQuery.of(context).size.height*0.01
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.6),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('passengers Number : '),
                                                            Text(widget.course.passengersDetails![index].passengersNumber.toString())
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                      top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:  MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('Luggage Number : '),
                                                              Text(widget.course.passengersDetails![index].collieNumber.toString())
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                  ],
                                                ),
                                              ),
                                            )
                                        );
                                      },
                                      child: Center(
                                        child: Text(
                                            widget.course.passengersDetails![index].firstname),
                                      ),
                                    )),




                                    DataCell(GestureDetector(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (builder)=>AlertDialog(
                                              content:Container(
                                                height: MediaQuery.of(context).size.height*0.35,
                                                color: Color(0xFF0F5CA0).withOpacity(0.6),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:MediaQuery.of(context).size.height*0.01
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.6),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('First Name : '),
                                                            Text(widget.course.passengersDetails![index].firstname)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:MediaQuery.of(context).size.height*0.01
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.6),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('Last Name : '),
                                                            Text(widget.course.passengersDetails![index].lastName)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:MediaQuery.of(context).size.height*0.01
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.6),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('Phone Number : '),
                                                            Text((widget.course.passengersDetails![index].phoneNum
                                                                .contains('.') &&
                                                                widget.course.passengersDetails![index].phoneNum
                                                                    .endsWith('.0'))
                                                                ?widget.course
                                                                .passengersDetails![index].phoneNum
                                                                .substring(
                                                                0,
                                                                widget.course.passengersDetails![index]
                                                                    .phoneNum
                                                                    .indexOf('.'))
                                                                :widget.course.passengersDetails![index].phoneNum

                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:MediaQuery.of(context).size.height*0.01
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.6),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('passengers Number : '),
                                                            Text(widget.course.passengersDetails![index].passengersNumber.toString())
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:EdgeInsets.only(
                                                          top: MediaQuery.of(context).size.height*0.01,
                                                          bottom:  MediaQuery.of(context).size.height*0.01
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.55,
                                                        height: MediaQuery.of(context).size.height*0.05,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white.withOpacity(0.6),
                                                            borderRadius: BorderRadius.all(Radius.circular(10))
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Text('Luggage Number : '),
                                                            Text(widget.course.passengersDetails![index].collieNumber.toString())
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            )
                                        );
                                      },
                                      child: Center(
                                        child: Text(
                                            widget.course.passengersDetails![index].lastName),
                                      ),
                                    )),


                                    (widget.course.passengersDetails![index].phoneNum
                                        .contains('.') &&
                                        widget.course.passengersDetails![index].phoneNum
                                            .endsWith('.0'))
                                        ?
                                      DataCell(GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (builder)=>AlertDialog(
                                                content:Container(
                                                  height: MediaQuery.of(context).size.height*0.35,
                                                  color: Color(0xFF0F5CA0).withOpacity(0.6),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('First Name : '),
                                                              Text(widget.course.passengersDetails![index].firstname)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('Last Name : '),
                                                              Text(widget.course.passengersDetails![index].lastName)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('Phone Number : '),
                                                              Text((widget.course.passengersDetails![index].phoneNum
                                                                  .contains('.') &&
                                                                  widget.course.passengersDetails![index].phoneNum
                                                                      .endsWith('.0'))
                                                                  ?widget.course
                                                                  .passengersDetails![index].phoneNum
                                                                  .substring(
                                                                  0,
                                                                  widget.course.passengersDetails![index]
                                                                      .phoneNum
                                                                      .indexOf('.'))
                                                                  :widget.course.passengersDetails![index].phoneNum

                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('passengers Number : '),
                                                              Text(widget.course.passengersDetails![index].passengersNumber.toString())
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:  MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('Luggage Number : '),
                                                              Text(widget.course.passengersDetails![index].collieNumber.toString())
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              )
                                          );
                                        },
                                        child: Center(
                                        child: Text(widget.course
                                            .passengersDetails![index].phoneNum
                                            .substring(
                                            0,
                                            widget.course.passengersDetails![index]
                                                .phoneNum
                                                .indexOf('.'))),
                                    ),
                                      ))
                                        :
                                    DataCell(GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (builder)=>AlertDialog(
                                                content:Container(
                                                  height: MediaQuery.of(context).size.height*0.35,
                                                  color: Color(0xFF0F5CA0).withOpacity(0.6),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('First Name : '),
                                                              Text(widget.course.passengersDetails![index].firstname)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('Last Name : '),
                                                              Text(widget.course.passengersDetails![index].lastName)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('Phone Number : '),
                                                              Text((widget.course.passengersDetails![index].phoneNum
                                                                  .contains('.') &&
                                                                  widget.course.passengersDetails![index].phoneNum
                                                                      .endsWith('.0'))
                                                                  ?widget.course
                                                                  .passengersDetails![index].phoneNum
                                                                  .substring(
                                                                  0,
                                                                  widget.course.passengersDetails![index]
                                                                      .phoneNum
                                                                      .indexOf('.'))
                                                                  :widget.course.passengersDetails![index].phoneNum

                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('passengers Number : '),
                                                              Text(widget.course.passengersDetails![index].passengersNumber.toString())
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:EdgeInsets.only(
                                                            top: MediaQuery.of(context).size.height*0.01,
                                                            bottom:  MediaQuery.of(context).size.height*0.01
                                                        ),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width*0.55,
                                                          height: MediaQuery.of(context).size.height*0.05,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.6),
                                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Text('Luggage Number : '),
                                                              Text(widget.course.passengersDetails![index].collieNumber.toString())
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              )
                                          );
                                        },
                                        child: Center(child: Text(widget.course.passengersDetails![index].phoneNum.toString())))),
                                    DataCell(
                              Checkbox(
                            value: widget.course.passengersDetails![index].state,
                            onChanged: (bool? value) {
                              setState(() {
                                widget.course.passengersDetails![index].state
                                =!widget.course.passengersDetails![index].state;
                              });
                            },
                              )
                                    )
                                  ])),
                            ),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(
                                bottom:MediaQuery.of(context).size.height*0.01
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    coursesController.firstNameController.text="";
                                    coursesController.lastNameController.text="";
                                    coursesController.phoneNumberController.text="";
                                    coursesController.collieNumberController.text="";
                                    coursesController.passengersNumberController.text="";
                                    showDialog(
                                        context: context,
                                        builder: (builder)=>AlertDialog(
                                          content: Container(
                                            // height: MediaQuery.of(context).size.height*0.48,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF0F5CA0)
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  SizedBox(height:  MediaQuery.of(context).size.height *
                                                      0.01,
                                                  ),
                                                  Container(
                                                    width:
                                                    MediaQuery.of(context).size.width *
                                                        0.6,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Colors.white.withOpacity(0.7),
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(5),
                                                          topLeft: Radius.circular(5),
                                                        )),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.width *
                                                            0.1,
                                                      ),
                                                      child: TextFormField(
                                                        controller: coursesController
                                                            .firstNameController,
                                                        decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: 'First Name',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Georgia',
                                                                color: Color(0xFF0F5CA0))),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:  MediaQuery.of(context).size.height *
                                                      0.02,
                                                  ),
                                                  Container(
                                                    width:
                                                    MediaQuery.of(context).size.width *
                                                        0.6,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Colors.white.withOpacity(0.7),
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(5),
                                                          topLeft: Radius.circular(5),
                                                        )),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.width *
                                                            0.1,
                                                      ),
                                                      child: TextFormField(
                                                        controller: coursesController
                                                            .lastNameController,
                                                        decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: 'Last Name',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Georgia',
                                                                color: Color(0xFF0F5CA0))),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:  MediaQuery.of(context).size.height *
                                                      0.02,
                                                  ),
                                                  Container(
                                                    width:
                                                    MediaQuery.of(context).size.width *
                                                        0.6,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Colors.white.withOpacity(0.7),
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(5),
                                                          topLeft: Radius.circular(5),
                                                        )),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.width *
                                                            0.1,
                                                      ),
                                                      child: TextFormField(
                                                        controller: coursesController
                                                            .phoneNumberController,
                                                        keyboardType:TextInputType.number,
                                                        decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: 'Phone Number',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Georgia',
                                                                color: Color(0xFF0F5CA0))),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:  MediaQuery.of(context).size.height *
                                                      0.02,
                                                  ),
                                                  Container(
                                                    width:
                                                    MediaQuery.of(context).size.width *
                                                        0.6,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Colors.white.withOpacity(0.7),
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(5),
                                                          topLeft: Radius.circular(5),
                                                        )),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.width *
                                                            0.1,
                                                      ),
                                                      child: TextFormField(
                                                        controller: coursesController
                                                            .collieNumberController,
                                                        keyboardType:TextInputType.number,
                                                        decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: 'Luggage Number',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Georgia',
                                                                color: Color(0xFF0F5CA0))),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:  MediaQuery.of(context).size.height *
                                                      0.02,
                                                  ),
                                                  Container(
                                                    width:
                                                    MediaQuery.of(context).size.width *
                                                        0.6,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Colors.white.withOpacity(0.7),
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(5),
                                                          topLeft: Radius.circular(5),
                                                        )),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                        left: MediaQuery.of(context).size.width *
                                                            0.1,
                                                      ),
                                                      child: TextFormField(
                                                        controller: coursesController
                                                            .passengersNumberController,
                                                        keyboardType:TextInputType.number,
                                                        decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: 'Passengers Number',
                                                            hintStyle: TextStyle(
                                                                fontFamily: 'Georgia',
                                                                color: Color(0xFF0F5CA0))),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:  MediaQuery.of(context).size.height *
                                                      0.02,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: (){

                                                        var errorList=<String>[];
                                                        if(coursesController.firstNameController.text.trim().isEmpty)
                                                          errorList.add("first Name");

                                                        if(coursesController.lastNameController.text.trim().isEmpty)
                                                          errorList.add("last Name");

                                                        // if(coursesController.lastNameController.text.trim().isEmpty)
                                                        //   errorList.add("phone Number");

                                                        // else if(coursesController.lastNameController.text.length==8)
                                                        //   errorList.add("Invalid phone Number");

                                                        if(coursesController.collieNumberController.text.trim().isEmpty)
                                                          errorList.add("Collie Number");

                                                        else if(int.parse(coursesController.collieNumberController.text.trim())>
                                                            (widget.course.collie!-widget.course.usedCollie!))
                                                          errorList.add('check Collie Capacity');

                                                        if(coursesController.passengersNumberController.text.trim().isEmpty)
                                                          errorList.add("passengers Number");
                                                        else if(int.parse(coursesController.passengersNumberController.text.trim())>
                                                            (widget.course.seatingCapacity-widget.course.passengersNum))
                                                          errorList.add('check passengers Capacity');

                                                        if(errorList.isEmpty){
                                                          widget.course.passengersDetails?.add(
                                                              rowdata(
                                                                firstname: coursesController.firstNameController.text,
                                                                lastName: coursesController.lastNameController.text,
                                                                phoneNum: coursesController.phoneNumberController.text,
                                                                state: false,
                                                                collieNumber: int.parse(coursesController.collieNumberController.text),
                                                                passengersNumber: int.parse(coursesController.passengersNumberController.text),

                                                              )
                                                          );

                                                          coursesController.courses.doc(widget.course.id).update(
                                                              {
                                                                "passengersDetails":
                                                                widget.course.passengersDetails
                                                                    ?.map((passenger) => passenger.toJson())
                                                                    .toList(),
                                                                "passengersNum":widget.course.passengersNum
                                                                    +int.parse(coursesController.passengersNumberController.text),
                                                                "usedCollie":widget.course.usedCollie!
                                                                    +int.parse(coursesController.collieNumberController.text),
                                                              }
                                                          ).then((value) {
                                                            coursesController.fetchCourses();
                                                            Navigator.pop(context);
                                                            Get.back();
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

                                                      },
                                                      child: Text("Add",style: TextStyle(
                                                          color: Color(0xFF0F5CA0)
                                                      ),)
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                    );
                                  },
                                  child: Text('Add passenger',style: TextStyle(
                                      color: Color(0xFF0F5CA0)
                                  )),
                                ),
                                SizedBox(width: 16,),
                                ElevatedButton(
                                  onPressed: () {
                                    coursesController.courses.doc(widget.course.id).update(
                                        {
                                          "passengersDetails":
                                          widget.course.passengersDetails
                                              ?.map((passenger) => passenger.toJson())
                                              .toList(),
                                        }
                                    ).then((value) => Get.back());
                                  },
                                  child: Text('Confirm',style: TextStyle(
                                      color: Color(0xFF0F5CA0)
                                  )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),

          ],
        ),
      ),
    );

  }
}
