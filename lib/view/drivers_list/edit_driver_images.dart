import 'dart:io';
import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class EditDriverImagesScreen extends StatefulWidget {
  EditDriverImagesScreen({Key? key, required this.record, this.imageUrl})
      : super(key: key);
  DriverModel record;
  String? imageUrl;

  @override
  State<EditDriverImagesScreen> createState() => _EditDriverImagesScreenState();
}

class _EditDriverImagesScreenState extends State<EditDriverImagesScreen> {
  UploadTask? uploadTask;

  final DriversController controller = Get.put(DriversController());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    print('/////////////////////////////////////');
    print(widget.imageUrl);
    print('/////////////////////////////////////');
  }

  @override
  Widget build(BuildContext context) {
    print('/////////////////////////////////////');
    print(widget.imageUrl);
    print('/////////////////////////////////////');

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
                controller.init();
                Get.back();
              },
            ),
          ),
          backgroundColor: Color(0xFF0F5CA0),
          title: Padding(
            padding: EdgeInsets.only(top: 30, left: 0),
            child: Text(
              "Edit driver",
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80),
                      ),
                      color: Color(0xFF0F5CA0)),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  // margin: EdgeInsets.only(left: 50),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  // height: MediaQuery.of(context).size.height*0.787,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFffffff).withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text('Upload Identity',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text('*',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Obx(() => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, bottom: 2),
                                    child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.365,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                width: 2)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (controller
                                                            .selectedIdentityFace1
                                                            .value !=
                                                        null &&
                                                    controller
                                                        .selectedIdentityFace1
                                                        .value!
                                                        .path
                                                        .split('/')!
                                                        .last
                                                        .endsWith(
                                                            '.pdf')) {
                                                  // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          ((builder) =>
                                                              AlertDialog(
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                                content:
                                                                    Container(
                                                                  // height:
                                                                  //     500,
                                                                      width: MediaQuery.of(context).size.width,
                                                                  child: SfPdfViewer.file(controller
                                                                      .selectedIdentityFace1
                                                                      .value!),
                                                                ),
                                                              )));
                                                } else if (controller
                                                        .selectedIdentityFace1
                                                        .value !=
                                                    null)
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          ((builder) =>
                                                              AlertDialog(
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                                content:
                                                                    Stack(
                                                                  children: [
                                                                    Container(
                                                                      // height:
                                                                      //     250,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                          top: 20.0,
                                                                        ),
                                                                        child: PhotoView(
                                                                          imageProvider: FileImage(
                                                                            controller.selectedIdentityFace1.value!,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                        top: -15,
                                                                        right: -10,
                                                                        child: IconButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.close,
                                                                            size: 30,
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ),
                                                              )));
                                                else if (widget.record
                                                        .identityCardImageFace1
                                                        .split('?')
                                                        .first
                                                        .endsWith(
                                                            '.jpg') ||
                                                    widget.record
                                                        .identityCardImageFace1
                                                        .split('?')
                                                        .first
                                                        .endsWith(
                                                            '.jpeg') ||
                                                    widget.record
                                                        .identityCardImageFace1
                                                        .split('?')
                                                        .first
                                                        .endsWith('.png'))
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          ((builder) =>
                                                              AlertDialog(
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                                content:
                                                                    Stack(
                                                                  children: [
                                                                    Container(
                                                                      // height:
                                                                      //     250,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                          top: 20.0,
                                                                        ),
                                                                        child: PhotoView(
                                                                          imageProvider: NetworkImage(
                                                                            widget.record.identityCardImageFace1,
                                                                            // width: 1300,
                                                                            // height: 100,
                                                                            // fit: BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                        top: -15,
                                                                        right: -10,
                                                                        child: IconButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.close,
                                                                            size: 30,
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ),
                                                              )));
                                                else {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          ((builder) =>
                                                              AlertDialog(
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                                content:
                                                                    Container(
                                                                  // height:
                                                                  //     500,
                                                                      width: MediaQuery.of(context).size.width,
                                                                  child: SfPdfViewer
                                                                      .network(
                                                                    widget
                                                                        .record
                                                                        .identityCardImageFace1,
                                                                  ),
                                                                ),
                                                              )));
                                                }
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    child: controller.selectedIdentityFace1.value != null &&
                                                            controller
                                                                .selectedIdentityFace1
                                                                .value!
                                                                .path
                                                                .split('/')!
                                                                .last
                                                                .endsWith(
                                                                    '.pdf')
                                                        ? Padding(
                                                            padding: EdgeInsets.all(
                                                                10),
                                                            child: Column(
                                                              children: [
                                                                Icon(Icons
                                                                    .file_open),
                                                                Text(
                                                                  controller
                                                                      .selectedIdentityFace1
                                                                      .value!
                                                                      .path
                                                                      .split(
                                                                          '/')!
                                                                      .last,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        8,
                                                                  ),
                                                                )
                                                              ],
                                                            ))
                                                        : controller.selectedIdentityFace1.value !=
                                                                null
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                child: Image
                                                                    .file(
                                                                  controller
                                                                      .selectedIdentityFace1
                                                                      .value!,
                                                                  width: 100,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              )
                                                            : widget.record
                                                                    .identityCardImageFace1
                                                                    .split('?')
                                                                    .first
                                                                    .endsWith('.jpg')
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                    child: Image
                                                                        .network(
                                                                      widget
                                                                          .record
                                                                          .identityCardImageFace1,
                                                                      width:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  )
                                                                : widget.record.identityCardImageFace1.split('?').first.endsWith('.jpeg')
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                        child:
                                                                            Image.network(
                                                                          widget.record.identityCardImageFace1,
                                                                          width:
                                                                              100,
                                                                          fit:
                                                                              BoxFit.fill,
                                                                        ),
                                                                      )
                                                                    : widget.record.identityCardImageFace1.split('?').first.endsWith('.png')
                                                                        ? Padding(
                                                                            padding: const EdgeInsets.all(3.0),
                                                                            child: Image.network(
                                                                              widget.record.identityCardImageFace1,
                                                                              width: 100,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          )
                                                                        : Column(
                                                                            children: [
                                                                              Icon(Icons.file_open),
                                                                              Text('pdf File')
                                                                            ],
                                                                          ),
                                                  ),
                                                  Positioned(
                                                      left: 0,
                                                      right: 0,
                                                      top: 0,
                                                      bottom: 0,
                                                      child: Icon(Icons.remove_red_eye_sharp))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [
                                                  // GestureDetector(
                                                  //     onTap: () {
                                                  //       if (controller
                                                  //                   .selectedIdentityFace1
                                                  //                   .value !=
                                                  //               null &&
                                                  //           controller
                                                  //               .selectedIdentityFace1
                                                  //               .value!
                                                  //               .path
                                                  //               .split(
                                                  //                   '/')!
                                                  //               .last
                                                  //               .endsWith(
                                                  //                   '.pdf')) {
                                                  //         // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                                  //         showDialog(
                                                  //             context:
                                                  //                 context,
                                                  //             builder:
                                                  //                 ((builder) =>
                                                  //                     AlertDialog(
                                                  //                       content: Container(
                                                  // //                         height: 500,
                                                  //                         width: 2500,
                                                  //                         child: SfPdfViewer.file(controller.selectedIdentityFace1.value!),
                                                  //                       ),
                                                  //                     )));
                                                  //       } else if (controller
                                                  //               .selectedIdentityFace1
                                                  //               .value !=
                                                  //           null)
                                                  //         showDialog(
                                                  //             context:
                                                  //                 context,
                                                  //             builder:
                                                  //                 ((builder) =>
                                                  //                     AlertDialog(
                                                  //                       content: Stack(
                                                  //                         children: [
                                                  //                           Container(
                                                  // //                             height: 250,
                                                  //                             width: 1800,
                                                  //                             child: Padding(
                                                  //                               padding: const EdgeInsets.only(
                                                  //                                 top: 20.0,
                                                  //                               ),
                                                  //                               child: Image.file(
                                                  //                                 controller.selectedIdentityFace1.value!,
                                                  //                                 width: 1300,
                                                  //                                 height: 100,
                                                  //                                 fit: BoxFit.cover,
                                                  //                               ),
                                                  //                             ),
                                                  //                           ),
                                                  //                           Positioned(
                                                  //                               top: -15,
                                                  //                               right: -10,
                                                  //                               child: IconButton(
                                                  //                                 onPressed: () {
                                                  //                                   Navigator.pop(context);
                                                  //                                 },
                                                  //                                 icon: Icon(
                                                  //                                   Icons.close,
                                                  //                                   size: 30,
                                                  //                                 ),
                                                  //                               ))
                                                  //                         ],
                                                  //                       ),
                                                  //                     )));
                                                  //       else if (widget
                                                  //               .record
                                                  //               .identityCardImageFace1
                                                  //               .split(
                                                  //                   '?')
                                                  //               .first
                                                  //               .endsWith(
                                                  //                   '.jpg') ||
                                                  //           widget.record
                                                  //               .identityCardImageFace1
                                                  //               .split(
                                                  //                   '?')
                                                  //               .first
                                                  //               .endsWith(
                                                  //                   '.jpeg') ||
                                                  //           widget.record
                                                  //               .identityCardImageFace1
                                                  //               .split(
                                                  //                   '?')
                                                  //               .first
                                                  //               .endsWith(
                                                  //                   '.png'))
                                                  //         showDialog(
                                                  //             context:
                                                  //                 context,
                                                  //             builder:
                                                  //                 ((builder) =>
                                                  //                     AlertDialog(
                                                  //                       content: Stack(
                                                  //                         children: [
                                                  //                           Container(
                                                  // //                             height: 250,
                                                  //                             width: 1800,
                                                  //                             child: Padding(
                                                  //                               padding: const EdgeInsets.only(
                                                  //                                 top: 20.0,
                                                  //                               ),
                                                  //                               child: Image.network(
                                                  //                                 widget.record.identityCardImageFace1,
                                                  //                                 width: 1300,
                                                  //                                 height: 100,
                                                  //                                 fit: BoxFit.fill,
                                                  //                               ),
                                                  //                             ),
                                                  //                           ),
                                                  //                           Positioned(
                                                  //                               top: -15,
                                                  //                               right: -10,
                                                  //                               child: IconButton(
                                                  //                                 onPressed: () {
                                                  //                                   Navigator.pop(context);
                                                  //                                 },
                                                  //                                 icon: Icon(
                                                  //                                   Icons.close,
                                                  //                                   size: 30,
                                                  //                                 ),
                                                  //                               ))
                                                  //                         ],
                                                  //                       ),
                                                  //                     )));
                                                  //       else {
                                                  //         showDialog(
                                                  //             context:
                                                  //                 context,
                                                  //             builder:
                                                  //                 ((builder) =>
                                                  //                     AlertDialog(
                                                  //                       content: Container(
                                                  // //                         height: 500,
                                                  //                         width: 2500,
                                                  //                         child: SfPdfViewer.network(
                                                  //                           widget.record.identityCardImageFace1,
                                                  //                         ),
                                                  //                       ),
                                                  //                     )));
                                                  //       }
                                                  //     },
                                                  //     child: Icon(
                                                  //       Icons
                                                  //           .remove_red_eye_sharp,
                                                  //       size: 20,
                                                  //     )),
                                                  // SizedBox(
                                                  //   height: 20,
                                                  // ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .pickIdentityFileFace1();
                                                      },
                                                      child: Icon(
                                                          Icons.edit,
                                                          size: 20)),
                                                ],
                                              ),
                                            )
                                          ],
                                        )

                                        // ? Text(controller.selectedFile.value!.path.split('/').last)

                                        ),
                                  )),
                              Obx(() => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, bottom: 2),
                                    child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.365,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                width: 2)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (controller
                                                            .selectedIdentityFace2
                                                            .value !=
                                                        null &&
                                                    controller
                                                        .selectedIdentityFace2
                                                        .value!
                                                        .path
                                                        .split('/')!
                                                        .last
                                                        .endsWith(
                                                            '.pdf')) {
                                                  // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          ((builder) =>
                                                              AlertDialog(
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                                content:
                                                                    Container(
                                                                  // height:
                                                                  //     500,
                                                                      width: MediaQuery.of(context).size.width,
                                                                  child: SfPdfViewer.file(controller
                                                                      .selectedIdentityFace2
                                                                      .value!),
                                                                ),
                                                              )));
                                                } else if (controller
                                                        .selectedIdentityFace2
                                                        .value !=
                                                    null)
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          ((builder) =>
                                                              AlertDialog(
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                                content:
                                                                    Stack(
                                                                  children: [
                                                                    Container(
                                                                      // height:
                                                                      //     250,
                                                                       width: MediaQuery.of(context).size.width,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                          top: 20.0,
                                                                        ),
                                                                        child: PhotoView(
                                                                          imageProvider: FileImage(
                                                                            controller.selectedIdentityFace2.value!,
                                                                            // width: 1300,
                                                                            // height: 100,
                                                                            // fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                        top: -15,
                                                                        right: -10,
                                                                        child: IconButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.close,
                                                                            size: 30,
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ),
                                                              )));
                                                else if (widget.record
                                                        .identityCardImageFace2
                                                        .split('?')
                                                        .first
                                                        .endsWith(
                                                            '.jpg') ||
                                                    widget.record
                                                        .identityCardImageFace2
                                                        .split('?')
                                                        .first
                                                        .endsWith(
                                                            '.jpeg') ||
                                                    widget.record
                                                        .identityCardImageFace2
                                                        .split('?')
                                                        .first
                                                        .endsWith('.png'))
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          ((builder) =>
                                                              AlertDialog(
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                                content:
                                                                    Stack(
                                                                  children: [
                                                                    Container(
                                                                      // height:
                                                                      //     250,
                                                                      width: MediaQuery.of(context).size.width,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                          top: 20.0,
                                                                        ),
                                                                        child: PhotoView(
                                                                          imageProvider: NetworkImage(
                                                                            widget.record.identityCardImageFace2,
                                                                            // width: 1300,
                                                                            // height: 100,
                                                                            // fit: BoxFit.fill,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                        top: -15,
                                                                        right: -10,
                                                                        child: IconButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          icon: Icon(
                                                                            Icons.close,
                                                                            size: 30,
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ),
                                                              )));
                                                else {
                                                  // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          ((builder) =>
                                                              AlertDialog(
                                                                contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                                content:
                                                                    Container(
                                                                  // height:
                                                                  //     500,
                                                                      width: MediaQuery.of(context).size.width,
                                                                  child: SfPdfViewer
                                                                      .network(
                                                                    widget
                                                                        .record
                                                                        .identityCardImageFace2,
                                                                  ),
                                                                ),
                                                              )));
                                                }
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    child: controller.selectedIdentityFace2.value != null &&
                                                            controller
                                                                .selectedIdentityFace2
                                                                .value!
                                                                .path
                                                                .split('/')!
                                                                .last
                                                                .endsWith(
                                                                    '.pdf')
                                                        ? Padding(
                                                            padding: EdgeInsets.all(
                                                                10),
                                                            child: Column(
                                                              children: [
                                                                Icon(Icons
                                                                    .file_open),
                                                                Text(
                                                                  controller
                                                                      .selectedIdentityFace2
                                                                      .value!
                                                                      .path
                                                                      .split(
                                                                          '/')!
                                                                      .last,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        8,
                                                                  ),
                                                                )
                                                              ],
                                                            ))
                                                        : controller.selectedIdentityFace2.value !=
                                                                null
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                child: Image
                                                                    .file(
                                                                  controller
                                                                      .selectedIdentityFace2
                                                                      .value!,
                                                                  width: 100,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              )
                                                            : widget.record
                                                                    .identityCardImageFace2
                                                                    .split('?')
                                                                    .first
                                                                    .endsWith('.jpg')
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                    child: Image
                                                                        .network(
                                                                      widget
                                                                          .record
                                                                          .identityCardImageFace2,
                                                                      width:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  )
                                                                : widget.record.identityCardImageFace2.split('?').first.endsWith('.jpeg')
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                        child:
                                                                            Image.network(
                                                                          widget.record.identityCardImageFace2,
                                                                          width:
                                                                              100,
                                                                          fit:
                                                                              BoxFit.fill,
                                                                        ),
                                                                      )
                                                                    : widget.record.identityCardImageFace2.split('?').first.endsWith('.png')
                                                                        ? Padding(
                                                                            padding: const EdgeInsets.all(3.0),
                                                                            child: Image.network(
                                                                              widget.record.identityCardImageFace2,
                                                                              width: 100,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          )
                                                                        : Column(
                                                                            children: [
                                                                              Icon(Icons.file_open),
                                                                              Text('pdf File')
                                                                            ],
                                                                          ),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                      bottom: 0,
                                                      left: 0,
                                                      right: 0,
                                                      child: Icon(Icons.remove_red_eye_sharp,))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .pickIdentityFileFace2();
                                                      },
                                                      child: Icon(
                                                          Icons.edit,
                                                          size: 20)),
                                                ],
                                              ),
                                            )
                                          ],
                                        )

                                        // ? Text(controller.selectedFile.value!.path.split('/').last)

                                        ),
                                  )),
                            ],
                          ),
                          Text(
                            'Allowed file types .pdf,.png',
                            style: TextStyle(
                                fontSize: 8, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text('Upload Licence',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text('*',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Obx(() => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, bottom: 2),
                                    child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.365,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                width: 2)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (controller
                                                    .selectedLicenceFace1
                                                    .value !=
                                                    null &&
                                                    controller
                                                        .selectedLicenceFace1
                                                        .value!
                                                        .path
                                                        .split(
                                                        '/')!
                                                        .last
                                                        .endsWith(
                                                        '.pdf')) {
                                                  // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                      ((builder) =>
                                                          AlertDialog(
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                            content: Container(
                                                              // height: 500,
                                                              width: MediaQuery.of(context).size.width,
                                                              child: SfPdfViewer.file(controller.selectedLicenceFace1.value!),
                                                            ),
                                                          )));
                                                } else if (controller
                                                    .selectedLicenceFace1
                                                    .value !=
                                                    null)
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                      ((builder) =>
                                                          AlertDialog(
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                            content: Stack(
                                                              children: [
                                                                Container(
                                                                  // height: 250,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(
                                                                      top: 20.0,
                                                                    ),
                                                                    child: PhotoView(
                                                                      imageProvider: FileImage(
                                                                        controller.selectedLicenceFace1.value!,
                                                                        // width: 1300,
                                                                        // height: 100,
                                                                        // fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    top: -15,
                                                                    right: -10,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                      icon: Icon(
                                                                        Icons.close,
                                                                        size: 30,
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          )));
                                                else if (widget
                                                    .record
                                                    .licenceImageFace1
                                                    .split(
                                                    '?')
                                                    .first
                                                    .endsWith(
                                                    '.jpg') ||
                                                    widget.record
                                                        .licenceImageFace1
                                                        .split(
                                                        '?')
                                                        .first
                                                        .endsWith(
                                                        '.jpeg') ||
                                                    widget.record
                                                        .licenceImageFace1
                                                        .split(
                                                        '?')
                                                        .first
                                                        .endsWith(
                                                        '.png'))
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                      ((builder) =>
                                                          AlertDialog(
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                            content: Stack(
                                                              children: [
                                                                Container(
                                                                  // height: 250,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(
                                                                      top: 20.0,
                                                                    ),
                                                                    child: PhotoView(
                                                                      imageProvider: NetworkImage(
                                                                        widget.record.licenceImageFace1,
                                                                        // width: 1300,
                                                                        // height: 100,
                                                                        // fit: BoxFit.fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    top: -15,
                                                                    right: -10,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                      icon: Icon(
                                                                        Icons.close,
                                                                        size: 30,
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          )));
                                                else {
                                                  // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                      ((builder) =>
                                                          AlertDialog(
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                            content: Container(
                                                              // height: 500,
                                                              width: MediaQuery.of(context).size.width,
                                                              child: SfPdfViewer.network(
                                                                widget.record.licenceImageFace1,
                                                              ),
                                                            ),
                                                          )));
                                                }
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    child: controller
                                                                    .selectedLicenceFace1
                                                                    .value !=
                                                                null &&
                                                            controller
                                                                .selectedLicenceFace1
                                                                .value!
                                                                .path
                                                                .split('/')!
                                                                .last
                                                                .endsWith(
                                                                    '.pdf')
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Column(
                                                              children: [
                                                                Icon(Icons
                                                                    .file_open),
                                                                Text(
                                                                  controller
                                                                      .selectedLicenceFace1
                                                                      .value!
                                                                      .path
                                                                      .split(
                                                                          '/')!
                                                                      .last,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 8,
                                                                  ),
                                                                )
                                                              ],
                                                            ))
                                                        : controller.selectedLicenceFace1.value !=
                                                                null
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                child:
                                                                    Image.file(
                                                                  controller
                                                                      .selectedLicenceFace1
                                                                      .value!,
                                                                  width: 100,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              )
                                                            : widget.record
                                                                    .licenceImageFace1
                                                                    .split('?')
                                                                    .first
                                                                    .endsWith('.jpg')
                                                                ? Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                    child: Image
                                                                        .network(
                                                                      widget
                                                                          .record
                                                                          .licenceImageFace1,
                                                                      width:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  )
                                                                : widget.record.licenceImageFace1.split('?').first.endsWith('.jpeg')
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                        child: Image
                                                                            .network(
                                                                          widget
                                                                              .record
                                                                              .licenceImageFace1,
                                                                          width:
                                                                              100,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      )
                                                                    : widget.record.licenceImageFace1.split('?').first.endsWith('.png')
                                                                        ? Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(3.0),
                                                                            child:
                                                                                Image.network(
                                                                              widget.record.licenceImageFace1,
                                                                              width: 100,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          )
                                                                        : Column(
                                                                            children: [
                                                                              Icon(Icons.file_open),
                                                                              Text('pdf File')
                                                                            ],
                                                                          ),
                                                  ),
                                                  Positioned(
                                                      top: 0,
                                                      bottom: 0,
                                                      left:0,
                                                      right: 0,
                                                      child: Icon(Icons.remove_red_eye_sharp,))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [

                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .pickLicenceFileFace1();
                                                      },
                                                      child: Icon(
                                                          Icons.edit,
                                                          size: 20)),
                                                ],
                                              ),
                                            )
                                          ],
                                        )

                                        // ? Text(controller.selectedFile.value!.path.split('/').last)

                                        ),
                                  )),
                              Obx(() => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, bottom: 2),
                                    child: Container(
                                        height: 70,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.365,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                width: 2)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (controller
                                                    .selectedLicenceFace2
                                                    .value !=
                                                    null &&
                                                    controller
                                                        .selectedLicenceFace2
                                                        .value!
                                                        .path
                                                        .split(
                                                        '/')!
                                                        .last
                                                        .endsWith(
                                                        '.pdf')) {
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                      ((builder) =>
                                                          AlertDialog(
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                            content: Container(
                                                              // height: 500,
                                                              width: MediaQuery.of(context).size.width,
                                                              child: SfPdfViewer.file(controller.selectedLicenceFace2.value!),
                                                            ),
                                                          )));
                                                } else if (controller
                                                    .selectedLicenceFace2
                                                    .value !=
                                                    null)
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                      ((builder) =>
                                                          AlertDialog(
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                            content: Stack(
                                                              children: [
                                                                Container(
                                                                  // height: 250,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(
                                                                      top: 20.0,
                                                                    ),
                                                                    child: PhotoView(
                                                                      imageProvider: FileImage(
                                                                        controller.selectedLicenceFace2.value!,
                                                                        // width: 1300,
                                                                        // height: 100,
                                                                        // fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    top: -15,
                                                                    right: -10,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                      icon: Icon(
                                                                        Icons.close,
                                                                        size: 30,
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          )));
                                                else if (widget
                                                    .record
                                                    .licenceImageFace2
                                                    .split(
                                                    '?')
                                                    .first
                                                    .endsWith(
                                                    '.jpg') ||
                                                    widget.record
                                                        .licenceImageFace2
                                                        .split(
                                                        '?')
                                                        .first
                                                        .endsWith(
                                                        '.jpeg') ||
                                                    widget.record
                                                        .licenceImageFace2
                                                        .split(
                                                        '?')
                                                        .first
                                                        .endsWith(
                                                        '.png'))
                                                  showDialog(

                                                      context:
                                                      context,
                                                      builder:
                                                      ((builder) =>
                                                          AlertDialog(
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                            content: Stack(
                                                              children: [
                                                                Container(
                                                                  // // height: 250,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  // padding: EdgeInsets.symmetric(vertical: 32),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.only(
                                                                      top: 20.0,
                                                                    ),
                                                                    child: PhotoView(
                                                                      imageProvider: NetworkImage(
                                                                        widget.record.licenceImageFace2,
                                                                        // width: 1300,
                                                                        // height: 100,
                                                                        // fit: BoxFit.fill,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    top: -15,
                                                                    right: -10,
                                                                    child: IconButton(
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                      icon: Icon(
                                                                        Icons.close,
                                                                        size: 30,
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          )));
                                                else {
                                                  showDialog(
                                                      context:
                                                      context,
                                                      builder:
                                                      ((builder) =>
                                                          AlertDialog(
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                            content: Container(
                                                              // height: 500,
                                                              width: MediaQuery.of(context).size.width,
                                                              child: SfPdfViewer.network(
                                                                widget.record.licenceImageFace2,
                                                              ),
                                                            ),
                                                          )));
                                                }
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    child: controller
                                                                    .selectedLicenceFace2
                                                                    .value !=
                                                                null &&
                                                            controller
                                                                .selectedLicenceFace2
                                                                .value!
                                                                .path
                                                                .split('/')!
                                                                .last
                                                                .endsWith(
                                                                    '.pdf')
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Column(
                                                              children: [
                                                                Icon(Icons
                                                                    .file_open),
                                                                Text(
                                                                  controller
                                                                      .selectedLicenceFace2
                                                                      .value!
                                                                      .path
                                                                      .split(
                                                                          '/')!
                                                                      .last,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize: 8,
                                                                  ),
                                                                )
                                                              ],
                                                            ))
                                                        : controller.selectedLicenceFace2.value !=
                                                                null
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        3.0),
                                                                child:
                                                                    Image.file(
                                                                  controller
                                                                      .selectedLicenceFace2
                                                                      .value!,
                                                                  width: 100,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              )
                                                            : widget.record
                                                                    .licenceImageFace2
                                                                    .split('?')
                                                                    .first
                                                                    .endsWith('.jpg')
                                                                ? Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                    child: Image
                                                                        .network(
                                                                      widget
                                                                          .record
                                                                          .licenceImageFace2,
                                                                      width:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  )
                                                                : widget.record.licenceImageFace2.split('?').first.endsWith('.jpeg')
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                        child: Image
                                                                            .network(
                                                                          widget
                                                                              .record
                                                                              .licenceImageFace2,
                                                                          width:
                                                                              100,
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                      )
                                                                    : widget.record.licenceImageFace2.split('?').first.endsWith('.png')
                                                                        ? Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(3.0),
                                                                            child:
                                                                                Image.network(
                                                                              widget.record.licenceImageFace2,
                                                                              width: 100,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          )
                                                                        : Column(
                                                                            children: [
                                                                              Icon(Icons.file_open),
                                                                              Text('pdf File')
                                                                            ],
                                                                          ),
                                                  ),
                                                  const Positioned(
                                                      top: 0,
                                                      bottom: 0,
                                                      left:0,
                                                      right: 0,
                                                      child: Icon(Icons.remove_red_eye_sharp,))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [

                                                  GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .pickLicenceFileFace2();
                                                      },
                                                      child: Icon(
                                                          Icons.edit,
                                                          size: 20)),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  )),
                            ],
                          ),
                          Text(
                            'Allowed file types .pdf,.png',
                            style: TextStyle(
                                fontSize: 8, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          if (widget.record.moreImage1 != "")
                            moreWidget1(),
                          if (widget.record.moreImage2 != "")
                            moreWidget2(),
                          if (widget.record.moreImage3 != "")
                            moreWidget3(),
                        ],
                      ),
                      Positioned
                      (
                        bottom: 20,
                        right: 10,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.init();
                                Get.back();
                              },
                              child: Center(
                                child: Container(
                                  width: 120,
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    'Back',
                                    style: TextStyle(color: Colors.black),
                                  )),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20),
                                      color: Color(0xFFFFFFFF)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: ((builder) => Center(
                                        child:
                                            CircularProgressIndicator())));

                                final driverImageURL;
                                if (
                                    // widget.record.driverImage!.split('/').last.endsWith('.jpg')||
                                    //     widget.record.driverImage!.split('/').last.endsWith('.jpeg')||
                                    //     widget.record.driverImage!.split('/').last.endsWith('.png')
                                    widget.imageUrl != null) {
                                  final driverUploadTask = FirebaseStorage
                                      .instance
                                      .ref('drivers/' +
                                          DateTime.now()
                                              .difference(
                                                  DateTime(2022, 1, 1))
                                              .inSeconds
                                              .toString() +
                                          '${widget.record.driverImage?.split('/').last}')
                                      .putFile(File(
                                          widget.record.driverImage!));
                                  final driverSnapshot =
                                      await driverUploadTask
                                          .whenComplete(() => null);
                                  driverImageURL = await driverSnapshot
                                      .ref
                                      .getDownloadURL();
                                  if (widget.imageUrl != "")
                                    FirebaseStorage.instance
                                        .refFromURL(widget.imageUrl!)
                                        .delete();
                                } else {
                                  driverImageURL =
                                      widget.record.driverImage!;
                                }

                                final identity1ImageURL;
                                if (controller
                                        .selectedIdentityFace1.value !=
                                    null) {
                                  FirebaseStorage.instance
                                      .refFromURL(widget
                                          .record.identityCardImageFace1)
                                      .delete();
                                  final driverUploadTask = FirebaseStorage
                                      .instance
                                      .ref('drivers/' +
                                          DateTime.now()
                                              .difference(
                                                  DateTime(2022, 1, 1))
                                              .inSeconds
                                              .toString() +
                                          '${controller.selectedIdentityFace1.value!.path.split('/').last}')
                                      .putFile(controller
                                          .selectedIdentityFace1.value!);
                                  final driverSnapshot =
                                      await driverUploadTask
                                          .whenComplete(() => null);
                                  identity1ImageURL = await driverSnapshot
                                      .ref
                                      .getDownloadURL();
                                  FirebaseStorage.instance
                                      .refFromURL(widget
                                          .record.identityCardImageFace1)
                                      .delete();
                                } else {
                                  identity1ImageURL = widget
                                      .record.identityCardImageFace1;
                                }

                                final identity2ImageURL;
                                if (controller
                                        .selectedIdentityFace2.value !=
                                    null) {
                                  FirebaseStorage.instance
                                      .refFromURL(widget
                                          .record.identityCardImageFace2)
                                      .delete();
                                  final driverUploadTask = FirebaseStorage
                                      .instance
                                      .ref('drivers/' +
                                          DateTime.now()
                                              .difference(
                                                  DateTime(2022, 1, 1))
                                              .inSeconds
                                              .toString() +
                                          '${controller.selectedIdentityFace2.value!.path.split('/').last}')
                                      .putFile(controller
                                          .selectedIdentityFace2.value!);
                                  final driverSnapshot =
                                      await driverUploadTask
                                          .whenComplete(() => null);
                                  identity2ImageURL = await driverSnapshot
                                      .ref
                                      .getDownloadURL();
                                  FirebaseStorage.instance
                                      .refFromURL(widget
                                          .record.identityCardImageFace2)
                                      .delete();
                                } else {
                                  identity2ImageURL = widget
                                      .record.identityCardImageFace2;
                                }

                                final licence1ImageURL;
                                if (controller
                                        .selectedLicenceFace1.value !=
                                    null) {
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.licenceImageFace1)
                                      .delete();
                                  final driverUploadTask = FirebaseStorage
                                      .instance
                                      .ref('drivers/' +
                                          DateTime.now()
                                              .difference(
                                                  DateTime(2022, 1, 1))
                                              .inSeconds
                                              .toString() +
                                          '${controller.selectedLicenceFace1.value!.path.split('/').last}')
                                      .putFile(controller
                                          .selectedLicenceFace1.value!);
                                  final driverSnapshot =
                                      await driverUploadTask
                                          .whenComplete(() => null);
                                  licence1ImageURL = await driverSnapshot
                                      .ref
                                      .getDownloadURL();
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.licenceImageFace1)
                                      .delete();
                                } else {
                                  licence1ImageURL =
                                      widget.record.licenceImageFace1;
                                }

                                final licence2ImageURL;
                                if (controller
                                        .selectedLicenceFace2.value !=
                                    null) {
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.licenceImageFace2)
                                      .delete();
                                  final driverUploadTask = FirebaseStorage
                                      .instance
                                      .ref('drivers/' +
                                          DateTime.now()
                                              .difference(
                                                  DateTime(2022, 1, 1))
                                              .inSeconds
                                              .toString() +
                                          '${controller.selectedLicenceFace2.value!.path.split('/').last}')
                                      .putFile(controller
                                          .selectedLicenceFace2.value!);
                                  final driverSnapshot =
                                      await driverUploadTask
                                          .whenComplete(() => null);
                                  licence2ImageURL = await driverSnapshot
                                      .ref
                                      .getDownloadURL();
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.licenceImageFace2)
                                      .delete();
                                } else {
                                  licence2ImageURL =
                                      widget.record.licenceImageFace2;
                                }
                                final more1ImageUrl;
                                if (controller.selectedMore1.value !=
                                    null) {
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.moreImage1!)
                                      .delete();
                                  final driverUploadTask = FirebaseStorage
                                      .instance
                                      .ref('drivers/' +
                                          DateTime.now()
                                              .difference(
                                                  DateTime(2022, 1, 1))
                                              .inSeconds
                                              .toString() +
                                          '${controller.selectedMore1.value!.path.split('/').last}')
                                      .putFile(controller
                                          .selectedMore1.value!);
                                  final driverSnapshot =
                                      await driverUploadTask
                                          .whenComplete(() => null);
                                  more1ImageUrl = await driverSnapshot.ref
                                      .getDownloadURL();
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.moreImage1!)
                                      .delete();
                                } else {
                                  more1ImageUrl =
                                      widget.record.moreImage1;
                                }

                                final more2ImageUrl;
                                if (controller.selectedMore2.value !=
                                    null) {
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.moreImage2!)
                                      .delete();
                                  final driverUploadTask = FirebaseStorage
                                      .instance
                                      .ref('drivers/' +
                                          DateTime.now()
                                              .difference(
                                                  DateTime(2022, 1, 1))
                                              .inSeconds
                                              .toString() +
                                          '${controller.selectedMore2.value!.path.split('/').last}')
                                      .putFile(controller
                                          .selectedMore2.value!);
                                  final driverSnapshot =
                                      await driverUploadTask
                                          .whenComplete(() => null);
                                  more2ImageUrl = await driverSnapshot.ref
                                      .getDownloadURL();
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.moreImage2!)
                                      .delete();
                                } else {
                                  more2ImageUrl =
                                      widget.record.moreImage2;
                                }

                                final more3ImageUrl;
                                if (controller.selectedMore3.value !=
                                    null) {
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.moreImage3!)
                                      .delete();
                                  final driverUploadTask = FirebaseStorage
                                      .instance
                                      .ref('drivers/' +
                                          DateTime.now()
                                              .difference(
                                                  DateTime(2022, 1, 1))
                                              .inSeconds
                                              .toString() +
                                          '${controller.selectedMore3.value!.path.split('/').last}')
                                      .putFile(controller
                                          .selectedMore3.value!);
                                  final driverSnapshot =
                                      await driverUploadTask
                                          .whenComplete(() => null);
                                  more3ImageUrl = await driverSnapshot.ref
                                      .getDownloadURL();
                                  FirebaseStorage.instance
                                      .refFromURL(
                                          widget.record.moreImage3!)
                                      .delete();
                                } else {
                                  more3ImageUrl =
                                      widget.record.moreImage3;
                                }

                                try {
                                  controller
                                      .update_driver(DriverModel(
                                    id: widget.record.id,
                                    driverImage: driverImageURL,
                                    firstName: widget.record.firstName,
                                    lastName: widget.record.lastName,
                                    birthDate: widget.record.birthDate,
                                    identityNumber:
                                        widget.record.identityNumber,
                                    identityCardImageFace1:
                                        identity1ImageURL,
                                    identityCardImageFace2:
                                        identity2ImageURL,
                                    phoneNumber:
                                        widget.record.phoneNumber,
                                    licenceType:
                                        widget.record.licenceType,
                                    licenceImageFace1: licence1ImageURL,
                                    licenceImageFace2: licence2ImageURL,
                                    email: widget.record.email,
                                    contractType:
                                        widget.record.contractType,
                                    password: widget.record.password,
                                    moreImage1: more1ImageUrl,
                                    moreImage2: more2ImageUrl,
                                    moreImage3: more3ImageUrl,
                                  ))
                                      .then((value) {
                                    Navigator.pop(context);
                                    controller.init();
                                    Get.offAll(() => HomeScreen());
                                    // Get.back();
                                    // Get.back();
                                  });

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Driver updated succeffuly"),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                } catch (e) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text("there is an error" +
                                          e.toString()),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                }
                              },
                              child: Center(
                                child: Container(
                                  width: 120,
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    'Confirm',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20),
                                      color: Color(0xFF333333)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget moreWidget1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        Obx(() => Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 2),
              child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.4), width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: controller.selectedMore1.value != null &&
                                controller.selectedMore1.value!.path
                                    .split('/')!
                                    .last
                                    .endsWith('.pdf')
                            ? Container(
                                padding: EdgeInsets.only(
                                  top: 15,
                                ),
                                width: 200,
                                child: Column(
                                  children: [
                                    Icon(Icons.file_open),
                                    Text(
                                      controller.selectedMore1.value!.path
                                          .split('/')!
                                          .last,
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : controller.selectedMore1.value != null
                                ? Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.file(
                                      controller.selectedMore1.value!,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : widget.record.moreImage1!
                                        .split('?')
                                        .first
                                        .endsWith('.jpg')
                                    ? Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.network(
                                          widget.record.moreImage1!,
                                          width: 200,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : widget.record.moreImage1!
                                            .split('?')
                                            .first
                                            .endsWith('.jpeg')
                                        ? Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image.network(
                                              widget.record.moreImage1!,
                                              width: 200,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : widget.record.moreImage1!
                                                .split('?')
                                                .first
                                                .endsWith('.png')
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Image.network(
                                                  widget.record.moreImage1!,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                width: 200,
                                                child: Column(
                                                  children: [
                                                    Icon(Icons.file_open),
                                                    Text('pdf File')
                                                  ],
                                                ),
                                              ),
                      ),
                      SizedBox(
                        width: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (controller.selectedMore1.value != null &&
                                      controller.selectedMore1.value!.path
                                          .split('/')!
                                          .last
                                          .endsWith('.pdf')) {
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Container(
                                                // height: 500,
                                                width: MediaQuery.of(context).size.width,
                                                child: SfPdfViewer.file(
                                                    controller
                                                        .selectedMore1.value!),
                                              ),
                                            )));
                                  } else if (controller.selectedMore1.value !=
                                      null)
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Stack(
                                                children: [
                                                  Container(
                                                    // height: 250,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20.0,
                                                      ),
                                                      child: Image.file(
                                                        controller.selectedMore1
                                                            .value!,
                                                        width: 1300,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: -15,
                                                      right: -10,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          size: 30,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )));
                                  else if (widget.record.moreImage1!
                                          .split('?')
                                          .first
                                          .endsWith('.jpg') ||
                                      widget.record.moreImage1!
                                          .split('?')
                                          .first
                                          .endsWith('.jpeg') ||
                                      widget.record.moreImage1!
                                          .split('?')
                                          .first
                                          .endsWith('.png'))
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Stack(
                                                children: [
                                                  Container(
                                                    // height: 250,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20.0,
                                                      ),
                                                      child: Image.network(
                                                        widget
                                                            .record.moreImage1!,
                                                        width: 1300,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: -15,
                                                      right: -10,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          size: 30,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )));
                                  else {
                                    // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Container(
                                                // height: 500,
                                                width: MediaQuery.of(context).size.width,
                                                child: SfPdfViewer.network(
                                                  widget.record.moreImage1!,
                                                ),
                                              ),
                                            )));
                                  }
                                },
                                child: Icon(
                                  Icons.remove_red_eye_sharp,
                                  size: 20,
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  controller.pickMore1File();
                                },
                                child: Icon(Icons.edit, size: 20)),
                          ],
                        ),
                      )
                    ],
                  )),
            )),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        Text(
          'Allowed file types .pdf,.png',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        // InkWell(
        //   onTap: (){
        //     controller.selectedMore1.value=null;
        //   },
        //   child: Text('cancel',style: TextStyle(color: Colors.red,fontSize: 15),),
        // )
        //   ],
        // ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget moreWidget2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        Obx(() => Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 2),
              child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.4), width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: controller.selectedMore2.value != null &&
                                controller.selectedMore2.value!.path
                                    .split('/')!
                                    .last
                                    .endsWith('.pdf')
                            ? Container(
                                padding: EdgeInsets.only(
                                  top: 15,
                                ),
                                width: 200,
                                child: Column(
                                  children: [
                                    Icon(Icons.file_open),
                                    Text(
                                      controller.selectedMore2.value!.path
                                          .split('/')!
                                          .last,
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : controller.selectedMore2.value != null
                                ? Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.file(
                                      controller.selectedMore2.value!,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : widget.record.moreImage2!
                                        .split('?')
                                        .first
                                        .endsWith('.jpg')
                                    ? Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.network(
                                          widget.record.moreImage2!,
                                          width: 200,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : widget.record.moreImage2!
                                            .split('?')
                                            .first
                                            .endsWith('.jpeg')
                                        ? Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image.network(
                                              widget.record.moreImage2!,
                                              width: 200,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : widget.record.moreImage2!
                                                .split('?')
                                                .first
                                                .endsWith('.png')
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Image.network(
                                                  widget.record.moreImage2!,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                width: 200,
                                                child: Column(
                                                  children: [
                                                    Icon(Icons.file_open),
                                                    Text('pdf File')
                                                  ],
                                                ),
                                              ),
                      ),
                      SizedBox(
                        width: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (controller.selectedMore2.value != null &&
                                      controller.selectedMore2.value!.path
                                          .split('/')!
                                          .last
                                          .endsWith('.pdf')) {
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Container(
                                                // height: 500,
                                                width: MediaQuery.of(context).size.width,
                                                child: SfPdfViewer.file(
                                                    controller
                                                        .selectedMore2.value!),
                                              ),
                                            )));
                                  } else if (controller.selectedMore2.value !=
                                      null)
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Stack(
                                                children: [
                                                  Container(
                                                    // height: 250,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20.0,
                                                      ),
                                                      child: Image.file(
                                                        controller.selectedMore2
                                                            .value!,
                                                        width: 1300,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: -15,
                                                      right: -10,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          size: 30,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )));
                                  else if (widget.record.moreImage2!
                                          .split('?')
                                          .first
                                          .endsWith('.jpg') ||
                                      widget.record.moreImage2!
                                          .split('?')
                                          .first
                                          .endsWith('.jpeg') ||
                                      widget.record.moreImage2!
                                          .split('?')
                                          .first
                                          .endsWith('.png'))
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Stack(
                                                children: [
                                                  Container(
                                                    // height: 250,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20.0,
                                                      ),
                                                      child: Image.network(
                                                        widget
                                                            .record.moreImage2!,
                                                        width: 1300,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: -15,
                                                      right: -10,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          size: 30,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )));
                                  else {
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Container(
                                                // height: 500,
                                                width: MediaQuery.of(context).size.width,
                                                child: SfPdfViewer.network(
                                                  widget.record.moreImage2!,
                                                ),
                                              ),
                                            )));
                                  }
                                },
                                child: Icon(
                                  Icons.remove_red_eye_sharp,
                                  size: 20,
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  controller.pickMore2File();
                                },
                                child: Icon(Icons.edit, size: 20)),
                          ],
                        ),
                      )
                    ],
                  )),
            )),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        Text(
          'Allowed file types .pdf,.png',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        //     InkWell(
        //       onTap: (){
        //         controller.selectedMore1.value=null;
        //       },
        //       child: Text('cancel',style: TextStyle(color: Colors.red,fontSize: 15),),
        //     )
        //   ],
        // ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget moreWidget3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        Obx(() => Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 2),
              child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.4), width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: controller.selectedMore3.value != null &&
                                controller.selectedMore3.value!.path
                                    .split('/')!
                                    .last
                                    .endsWith('.pdf')
                            ? Container(
                                padding: EdgeInsets.only(
                                  top: 15,
                                ),
                                width: 200,
                                child: Column(
                                  children: [
                                    Icon(Icons.file_open),
                                    Text(
                                      controller.selectedMore3.value!.path
                                          .split('/')!
                                          .last,
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : controller.selectedMore3.value != null
                                ? Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.file(
                                      controller.selectedMore3.value!,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : widget.record.moreImage3!
                                        .split('?')
                                        .first
                                        .endsWith('.jpg')
                                    ? Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.network(
                                          widget.record.moreImage3!,
                                          width: 200,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : widget.record.moreImage3!
                                            .split('?')
                                            .first
                                            .endsWith('.jpeg')
                                        ? Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image.network(
                                              widget.record.moreImage3!,
                                              width: 200,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : widget.record.moreImage3!
                                                .split('?')
                                                .first
                                                .endsWith('.png')
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Image.network(
                                                  widget.record.moreImage3!,
                                                  width: 200,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                width: 200,
                                                child: Column(
                                                  children: [
                                                    Icon(Icons.file_open),
                                                    Text('pdf File')
                                                  ],
                                                ),
                                              ),
                      ),
                      SizedBox(
                        width: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  if (controller.selectedMore3.value != null &&
                                      controller.selectedMore3.value!.path
                                          .split('/')!
                                          .last
                                          .endsWith('.pdf')) {
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Container(
                                                // height: 500,
                                                width: MediaQuery.of(context).size.width,
                                                child: SfPdfViewer.file(
                                                    controller
                                                        .selectedMore3.value!),
                                              ),
                                            )));
                                  } else if (controller.selectedMore3.value !=
                                      null)
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Stack(
                                                children: [
                                                  Container(
                                                    // height: 250,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20.0,
                                                      ),
                                                      child: Image.file(
                                                        controller.selectedMore3
                                                            .value!,
                                                        width: 1300,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: -15,
                                                      right: -10,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          size: 30,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )));
                                  else if (widget.record.moreImage3!
                                          .split('?')
                                          .first
                                          .endsWith('.jpg') ||
                                      widget.record.moreImage3!
                                          .split('?')
                                          .first
                                          .endsWith('.jpeg') ||
                                      widget.record.moreImage3!
                                          .split('?')
                                          .first
                                          .endsWith('.png'))
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Stack(
                                                children: [
                                                  Container(
                                                    // height: 250,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20.0,
                                                      ),
                                                      child: Image.network(
                                                        widget
                                                            .record.moreImage3!,
                                                        width: 1300,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: -15,
                                                      right: -10,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          size: 30,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )));
                                  else {
                                    showDialog(
                                        context: context,
                                        builder: ((builder) => AlertDialog(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                              content: Container(
                                                // height: 500,
                                                width: MediaQuery.of(context).size.width,
                                                child: SfPdfViewer.network(
                                                  widget.record.moreImage3!,
                                                ),
                                              ),
                                            )));
                                  }
                                },
                                child: Icon(
                                  Icons.remove_red_eye_sharp,
                                  size: 20,
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  controller.pickMore3File();
                                },
                                child: Icon(Icons.edit, size: 20)),
                          ],
                        ),
                      )
                    ],
                  )),
            )),
        Text(
          'Allowed file types .pdf,.png',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}
