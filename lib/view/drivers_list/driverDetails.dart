import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:admin_citygo/view/notification_new_driver_screen/consult_notification_new_driver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DriverDetails extends StatefulWidget {
   DriverDetails({
    Key? key,required this.record
  }) : super(key: key);

  DriverModel record;
  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {

  final DriversController controller = Get.put(DriversController());

  String? identityFace1ImageUrl;
  String? identityFace2ImageUrl;
  String? licenceFace1ImageUrl;
  String? licenceFace2ImageUrl;
  String? more1ImageUrl;
  String? more2ImageUrl;
  String? more3ImageUrl;

  void initState() {
    super.initState();
    identityFace1ImageUrl=widget.record.identityCardImageFace1;
    identityFace2ImageUrl=widget.record.identityCardImageFace2;
    licenceFace1ImageUrl=widget.record.licenceImageFace1;
    licenceFace2ImageUrl=widget.record.licenceImageFace1;
    more1ImageUrl=widget.record.moreImage1;
    more2ImageUrl=widget.record.moreImage2;
    more3ImageUrl=widget.record.moreImage3;
  }

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
            child: Text("driver Details",style: TextStyle(
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.03,
                        ),
                        Center(
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
                        Padding(
                          padding: const EdgeInsets.only(left:18.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     SizedBox(height: 20,),
                            //     Text("Driver Register",
                            //       style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold,
                            //           fontFamily: "Georgia"),
                            //     ),
                            //     SizedBox(height: 12,),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left:110),
                            //       child: Container(
                            //         height: 100,
                            //         width: 100,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(50),
                            //           image: DecorationImage(
                            //               image: NetworkImage(widget.record.driverImage),
                            //               fit: BoxFit.cover
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(height: 25,),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left:10.0),
                            //       child: Column(
                            //         children: [
                            //           Row(
                            //             crossAxisAlignment: CrossAxisAlignment.start,
                            //             children: [
                            //               Column(
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 mainAxisAlignment: MainAxisAlignment.center,
                            //                 children: [
                            //                   Text("First Name".capitalize.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text("Last Name".capitalize.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text("Birth Date".capitalize.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text("Identity Card".capitalize.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text("Phone Number ".capitalize.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text("Licence type".capitalize.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text("Email".capitalize.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                 ],
                            //               ),
                            //               SizedBox(width: 5,),
                            //               Column(
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 mainAxisAlignment: MainAxisAlignment.center,
                            //                 children: [
                            //                   Text(':'),
                            //                   SizedBox(height: 25,),
                            //                   Text(':'),
                            //                   SizedBox(height: 25,),
                            //                   Text(':'),
                            //                   SizedBox(height: 28,),
                            //                   Text(':'),
                            //                   SizedBox(height: 28,),
                            //                   Text(':'),
                            //                   SizedBox(height: 28,),
                            //                   Text(':'),
                            //                   SizedBox(height: 22,),
                            //                   Text(':'),
                            //                 ],
                            //               ),
                            //               SizedBox(width: 10,),
                            //               Column(
                            //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text(widget.record.firstName.capitalize.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text(widget.record.lastName.capitalize.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text(widget.record.birthDate,style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text(widget.record.identityNumber.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text("+216 "+widget.record.phoneNumber.toString(),style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text(widget.record.licenceType,style: TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //                   SizedBox(height: 25,),
                            //                   Text(widget.record.email.capitalize.toString(),style: TextStyle(
                            //                       fontSize: 13,
                            //                       color: Colors.grey,
                            //                       fontWeight: FontWeight.bold,
                            //                       fontFamily: "Georgia"),),
                            //
                            //
                            //
                            //                 ],
                            //               ),
                            //             ],
                            //           ),
                            //           SizedBox(height: 25,),
                            //           Row(
                            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //             children: [
                            //               Text("Contract type".capitalize.toString(),style: TextStyle(
                            //                   fontSize: 8,
                            //                   color: Colors.grey,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontFamily: "Georgia"),
                            //               ),
                            //               // Row(
                            //               //   children: [
                            //               //     Text("seasonal",style: TextStyle(fontSize: 10),),
                            //               //     Checkbox(value: checkBox1, onChanged: (value){
                            //               //       if(checkBox2==true){
                            //               //         setState(() {
                            //               //           checkBox1=!checkBox1;
                            //               //           checkBox2=!checkBox2;
                            //               //         });}
                            //               //       else{
                            //               //         setState(() {
                            //               //           checkBox1=!checkBox1;
                            //               //         });
                            //               //       }
                            //               //     }),
                            //               //   ],
                            //               // ),
                            //
                            //               // Row(
                            //               //   children: [
                            //               //     Text("Full Time Contract",style: TextStyle(fontSize: 10),),
                            //               //     Checkbox(value: checkBox2, onChanged: (value){
                            //               //       if(checkBox1==true){
                            //               //         setState(() {
                            //               //           checkBox1=!checkBox1;
                            //               //           checkBox2=!checkBox2;
                            //               //         });}
                            //               //       else{
                            //               //         setState(() {
                            //               //           checkBox2=!checkBox2;
                            //               //
                            //               //         });
                            //               //       }
                            //               //     }),
                            //               //   ],
                            //               // ),
                            //
                            //             ],
                            //           ),
                            //           // const Divider(
                            //           //   height: 10,
                            //           //   thickness: 2,
                            //           //   indent: 0,
                            //           //   endIndent: 20,
                            //           //   color: Colors.black,
                            //           // ),
                            //           SizedBox(height: 50,),
                            //           Center(
                            //             child: GestureDetector(
                            //               onTap: (){
                            //                 // if(checkBox1 || checkBox2){
                            //                 //   String contract="";
                            //                 //   if(checkBox1)
                            //                 //     contract="seasonal" ;
                            //                 //   else contract= "Full Time Contract";
                            //                 //   // Get.to(()=>ConsultNotiNewDriversImages(record: widget.record , contract: contract));
                            //                 //
                            //                 //   // driversController.add_driver(
                            //                 //   //     DriverModel(
                            //                 //   //         driverImage: widget.record.driverImage,
                            //                 //   //         firstName: widget.record.firstName.capitalize.toString(),
                            //                 //   //         lastName: widget.record.lastName.capitalize.toString(),
                            //                 //   //         birthDate: widget.record.birthDate,
                            //                 //   //         identityNumber: widget.record.identityNumber,
                            //                 //   //         identityCardImageFace1: widget.record.identityCardImage,
                            //                 //   //         identityCardImageFace2: widget.record.identityCardImage,
                            //                 //   //         phoneNumber: widget.record.phoneNumber,
                            //                 //   //         licenceType: widget.record.licenceType,
                            //                 //   //         licenceImageFace1: widget.record.licenceImage,
                            //                 //   //         licenceImageFace2: widget.record.licenceImage,
                            //                 //   //         email: widget.record.email,
                            //                 //   //         contractType: contract,
                            //                 //   //         password:widget.record.password
                            //                 //   //     )
                            //                 //   // );
                            //                 //   // notificationNewDriverController.notiDrivers.doc(widget.record.id).update({"valid":true});
                            //                 //
                            //                 // }
                            //                 // else{
                            //                 //   ScaffoldMessenger.of(context).showSnackBar(
                            //                 //     SnackBar(
                            //                 //       content: Text("Please select contract type"),
                            //                 //       duration: Duration(seconds: 5),
                            //                 //     ),
                            //                 //   );
                            //                 // }
                            //               },
                            //               child: Container(
                            //                 width: 120,
                            //                 height: 40,
                            //                 decoration: BoxDecoration(
                            //                     color: Color(0xFF0F5CA0),
                            //                     borderRadius: BorderRadius.circular(10)
                            //                 ),
                            //                 child: Center(
                            //                   child: Text('Next',
                            //                     style: TextStyle(
                            //                         fontWeight: FontWeight.bold,
                            //                         fontFamily: 'Georgia',
                            //                         color: Colors.white
                            //                     ),),
                            //                 ),
                            //               ),
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //     )
                            //   ],
                            // ),
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
                                  DataRow(cells: <DataCell>[
                                    DataCell(Text("contract type")),
                                    DataCell(Text(':')),
                                    DataCell(Text(widget.record.contractType)),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                        ),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context){
                                  return Container(
                                    height: MediaQuery.of(context).size.height*0.7,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 20,),
                                          Text('Driver Identity',style:TextStyle(fontWeight: FontWeight.bold)),
                                          SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top:2.0,
                                                    bottom:2
                                                ),
                                                child: Container(
                                                    height: 70,
                                                    width: MediaQuery.of(context).size.width*0.365,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.2),
                                                        border: Border.all(
                                                            color: Colors.grey.withOpacity(0.4),
                                                            width: 2
                                                        )
                                                    ),
                                                    child:
                                                    Row(
                                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Container(
                                                          child:
                                                          widget.record.identityCardImageFace1.split('?').first.endsWith('.jpg')
                                                              ?Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Image.network(
                                                              widget.record.identityCardImageFace1,
                                                              width: 100,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                              :widget.record.identityCardImageFace1.split('?').first.endsWith('.jpeg')
                                                              ?Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Image.network(
                                                              widget.record.identityCardImageFace1,
                                                              width: 100,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                              : widget.record.identityCardImageFace1.split('?').first.endsWith('.png')
                                                              ?Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Image.network(
                                                              widget.record.identityCardImageFace1,
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
                                                        Center(
                                                          child: SizedBox(
                                                            width: 20,
                                                            child: GestureDetector(
                                                                onTap:(){
                                                                  if(widget.record.identityCardImageFace1.split('?').first.endsWith('.jpg')||
                                                                      widget.record.identityCardImageFace1.split('?').first.endsWith('.jpeg')||
                                                                      widget.record.identityCardImageFace1.split('?').first.endsWith('.png')
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
                                                                                        widget.record.identityCardImageFace1,
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
                                                                                child: SfPdfViewer.network(widget.record.identityCardImageFace1,),
                                                                              ),
                                                                            )
                                                                        )
                                                                    );
                                                                  }



                                                                },child: Icon(Icons.remove_red_eye_sharp,size: 20,)),
                                                          ),
                                                        )
                                                      ],
                                                    )

                                                  // ? Text(controller.selectedFile.value!.path.split('/').last)

                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top:2.0,
                                                    bottom:2
                                                ),
                                                child: Container(
                                                    height: 70,
                                                    width: MediaQuery.of(context).size.width*0.365,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.2),
                                                        border: Border.all(
                                                            color: Colors.grey.withOpacity(0.4),
                                                            width: 2
                                                        )
                                                    ),
                                                    child:
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Container(
                                                          child:
                                                          widget.record.identityCardImageFace2.split('?').first.endsWith('.jpg')
                                                              ?Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Image.network(
                                                              widget.record.identityCardImageFace2,
                                                              width: 100,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                              :widget.record.identityCardImageFace2.split('?').first.endsWith('.jpeg')
                                                              ?Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Image.network(
                                                              widget.record.identityCardImageFace2,
                                                              width: 100,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                              : widget.record.identityCardImageFace2.split('?').first.endsWith('.png')
                                                              ?Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Image.network(
                                                              widget.record.identityCardImageFace2,
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
                                                        Center(
                                                          child: SizedBox(
                                                            width: 20,
                                                            child: GestureDetector(
                                                                onTap:(){
                                                                  if(controller.selectedIdentityFace2.value!=null && controller.selectedIdentityFace2.value!.path.split('/')!.last.endsWith('.pdf'))
                                                                  {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (
                                                                                (builder)=>AlertDialog(
                                                                              content: Container(
                                                                                height: 500,
                                                                                width: 2500,
                                                                                child: SfPdfViewer.file(controller.selectedIdentityFace2.value!),
                                                                              ),
                                                                            )
                                                                        )
                                                                    );
                                                                  }
                                                                  else if(controller.selectedIdentityFace2.value!=null)
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
                                                                                        controller.selectedIdentityFace2.value!,
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
                                                                  else if(widget.record.identityCardImageFace2.split('?').first.endsWith('.jpg')||
                                                                      widget.record.identityCardImageFace2.split('?').first.endsWith('.jpeg')||
                                                                      widget.record.identityCardImageFace2.split('?').first.endsWith('.png')
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
                                                                                        widget.record.identityCardImageFace2,
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
                                                                    // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (
                                                                                (builder)=>AlertDialog(
                                                                              content: Container(
                                                                                height: 500,
                                                                                width: 2500,
                                                                                child: SfPdfViewer.network(widget.record.identityCardImageFace2,),
                                                                              ),
                                                                            )
                                                                        )
                                                                    );
                                                                  }



                                                                },child: Icon(Icons.remove_red_eye_sharp,size: 20,)),
                                                          ),
                                                        )
                                                      ],
                                                    )

                                                  // ? Text(controller.selectedFile.value!.path.split('/').last)

                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12,),
                                          Text('Driver Licence',style:TextStyle(fontWeight: FontWeight.bold)),
                                          SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top:2.0,
                                                    bottom:2
                                                ),
                                                child: Container(
                                                    height: 70,
                                                    width: MediaQuery.of(context).size.width*0.365,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.2),
                                                        border: Border.all(
                                                            color: Colors.grey.withOpacity(0.4),
                                                            width: 2
                                                        )
                                                    ),
                                                    child:
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Container(
                                                          child:
                                                          widget.record.licenceImageFace1.split('?').first.endsWith('.jpg')
                                                              ||widget.record.licenceImageFace1.split('?').first.endsWith('.jpeg')
                                                          ||widget.record.licenceImageFace1.split('?').first.endsWith('.png')
                                                              ?Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Image.network(
                                                              widget.record.licenceImageFace1,
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
                                                        Center(
                                                          child: SizedBox(
                                                            width: 20,
                                                            child: GestureDetector(
                                                                onTap:(){
                                                                  if(controller.selectedLicenceFace1.value!=null && controller.selectedLicenceFace1.value!.path.split('/')!.last.endsWith('.pdf'))
                                                                  {
                                                                    showDialog(
                                                                        context: context,
                                                                        builder: (
                                                                                (builder)=>AlertDialog(
                                                                              content: Container(
                                                                                height: 500,
                                                                                width: 2500,
                                                                                child: SfPdfViewer.file(controller.selectedLicenceFace1.value!),
                                                                              ),
                                                                            )
                                                                        )
                                                                    );
                                                                  }
                                                                  else if(controller.selectedLicenceFace1.value!=null)
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
                                                                                        controller.selectedLicenceFace1.value!,
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
                                                                  else if(widget.record.licenceImageFace1.split('?').first.endsWith('.jpg')||
                                                                      widget.record.licenceImageFace1.split('?').first.endsWith('.jpeg')||
                                                                      widget.record.licenceImageFace1.split('?').first.endsWith('.png')
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
                                                                                        widget.record.licenceImageFace1,
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
                                                                                child: SfPdfViewer.network(widget.record.licenceImageFace1,),
                                                                              ),
                                                                            )
                                                                        )
                                                                    );
                                                                  }
                                                                },
                                                                child: Icon(Icons.remove_red_eye_sharp,size: 20,)),
                                                          ),
                                                        )
                                                      ],
                                                    )

                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top:2.0,
                                                    bottom:2
                                                ),
                                                child: Container(
                                                    height: 70,
                                                    width: MediaQuery.of(context).size.width*0.365,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.2),
                                                        border: Border.all(
                                                            color: Colors.grey.withOpacity(0.4),
                                                            width: 2
                                                        )
                                                    ),
                                                    child:
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Container(
                                                          child:
                                                          widget.record.licenceImageFace2.split('?').first.endsWith('.jpg')
                                                              ||widget.record.licenceImageFace2.split('?').first.endsWith('.jpeg')
                                                              ||widget.record.licenceImageFace2.split('?').first.endsWith('.png')
                                                              ?Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Image.network(
                                                              widget.record.licenceImageFace2,
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
                                                        Center(
                                                          child: SizedBox(
                                                            width: 20,
                                                            child: GestureDetector(
                                                                onTap:(){
                                                                  if(widget.record.licenceImageFace2.split('?').first.endsWith('.jpg')||
                                                                      widget.record.licenceImageFace2.split('?').first.endsWith('.jpeg')||
                                                                      widget.record.licenceImageFace2.split('?').first.endsWith('.png')
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
                                                                                        widget.record.licenceImageFace2,
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
                                                                                child: SfPdfViewer.network(widget.record.licenceImageFace2,),
                                                                              ),
                                                                            )
                                                                        )
                                                                    );
                                                                  }
                                                                },child: Icon(Icons.remove_red_eye_sharp,size: 20,)),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12,),

                                          if(widget.record.moreImage1!="")moreWidget1(),
                                          if(widget.record.moreImage2!="")moreWidget2(),
                                          if(widget.record.moreImage3!="")moreWidget3(),


                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
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
                      ],
                    ),
                  )
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
            )
          ],
        )


    );
  }
  Widget moreWidget1(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.only(
              top:2.0,
              bottom:2
          ),
          child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                      width: 2
                  )
              ),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child:
                    widget.record.moreImage1!.split('?').first.endsWith('.jpg')
                       ||widget.record.moreImage1!.split('?').first.endsWith('.jpeg')
                        ||widget.record.moreImage1!.split('?').first.endsWith('.png')
                        ?Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.network(
                        widget.record.moreImage1!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        :Container(
                      padding: EdgeInsets.only(top: 15),
                      width: 200,
                      child: Column(
                        children: [
                          Icon(Icons.file_open),
                          Text('pdf File')
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 20,
                      child: GestureDetector(
                          onTap:(){
                            if(widget.record.moreImage1!.split('?').first.endsWith('.jpg')||
                                widget.record.moreImage1!.split('?').first.endsWith('.jpeg')||
                                widget.record.moreImage1!.split('?').first.endsWith('.png')
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
                                                  widget.record.moreImage1!,
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
                                          child: SfPdfViewer.network(widget.record.moreImage1!,),
                                        ),
                                      )
                                  )
                              );
                            }
                          },child: Icon(Icons.remove_red_eye_sharp,size: 20,)),
                    ),
                  )
                ],
              )


          ),
        ),
        SizedBox(height: 8,),
      ],
    );
  }
  Widget moreWidget2(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.only(
              top:2.0,
              bottom:2
          ),
          child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                      width: 2
                  )
              ),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child:
                    widget.record.moreImage2!.split('?').first.endsWith('.jpg')
                        ||widget.record.moreImage2!.split('?').first.endsWith('.jpeg')
                        ||widget.record.moreImage2!.split('?').first.endsWith('.png')
                        ?Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.network(
                        widget.record.moreImage2!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        :Container(
                      padding: EdgeInsets.only(top: 15),
                      width: 200,
                      child: Column(
                        children: [
                          Icon(Icons.file_open),
                          Text('pdf File')
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 20,
                      child: GestureDetector(
                          onTap:(){
                            if(controller.selectedMore2.value!=null && controller.selectedMore2.value!.path.split('/')!.last.endsWith('.pdf'))
                            {
                              showDialog(
                                  context: context,
                                  builder: (
                                          (builder)=>AlertDialog(
                                        content: Container(
                                          height: 500,
                                          width: 2500,
                                          child: SfPdfViewer.file(controller.selectedMore2.value!),
                                        ),
                                      )
                                  )
                              );
                            }
                            else if(controller.selectedMore2.value!=null)
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
                                                  controller.selectedMore2.value!,
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
                            else if(widget.record.moreImage2!.split('?').first.endsWith('.jpg')||
                                widget.record.moreImage2!.split('?').first.endsWith('.jpeg')||
                                widget.record.moreImage2!.split('?').first.endsWith('.png')
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
                                                  widget.record.moreImage2!,
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
                                          child: SfPdfViewer.network(widget.record.moreImage2!,),
                                        ),
                                      )
                                  )
                              );
                            }
                          },child: Icon(Icons.remove_red_eye_sharp,size: 20,)),
                    ),
                  )
                ],
              )


          ),
        ),
        SizedBox(height: 5,),
      ],
    );
  }
  Widget moreWidget3(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.only(
              top:2.0,
              bottom:2
          ),
          child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                      width: 2
                  )
              ),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child:
                    controller.selectedMore3.value!=null && controller.selectedMore3.value!.path.split('/')!.last.endsWith('.pdf')
                        ?Container(
                      padding: EdgeInsets.only(
                        top: 15,
                      ),
                      width: 200,
                      child: Column(
                        children: [
                          Icon(Icons.file_open),
                          Text(
                            controller.selectedMore3.value!.path.split('/')!.last,
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          )
                        ],
                      ),
                    )
                        :controller.selectedMore3.value!=null
                        ?Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.file(
                        controller.selectedMore3.value!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        :widget.record.moreImage3!.split('?').first.endsWith('.jpg')
                        || widget.record.moreImage3!.split('?').first.endsWith('.jpeg')
                        || widget.record.moreImage3!.split('?').first.endsWith('.png')
                        ?Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.network(
                        widget.record.moreImage3!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        :Container(
                      padding: EdgeInsets.only(top: 15),
                      width: 200,
                      child: Column(
                        children: [
                          Icon(Icons.file_open),
                          Text('pdf File')
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 20,
                      child: GestureDetector(
                          onTap:(){
                            if(controller.selectedMore3.value!=null && controller.selectedMore3.value!.path.split('/')!.last.endsWith('.pdf'))
                            {
                              showDialog(
                                  context: context,
                                  builder: (
                                          (builder)=>AlertDialog(
                                        content: Container(
                                          height: 500,
                                          width: 2500,
                                          child: SfPdfViewer.file(controller.selectedMore3.value!),
                                        ),
                                      )
                                  )
                              );
                            }
                            else if(controller.selectedMore3.value!=null)
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
                                                  controller.selectedMore3.value!,
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
                            else if(widget.record.moreImage3!.split('?').first.endsWith('.jpg')||
                                widget.record.moreImage3!.split('?').first.endsWith('.jpeg')||
                                widget.record.moreImage3!.split('?').first.endsWith('.png')
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
                                                  widget.record.moreImage3!,
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
                                          child: SfPdfViewer.network(widget.record.moreImage3!,),
                                        ),
                                      )
                                  )
                              );
                            }


                          },child: Icon(Icons.remove_red_eye_sharp,size: 20,)),
                    ),
                  )
                ],
              )
          ),
        ),
      ],
    );
  }
}
