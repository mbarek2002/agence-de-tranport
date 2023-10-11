import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/controllers/notication_new_driver/notication_new_driver_controller.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/models/notification_new_driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class ConsultNotiNewDriversImages extends StatefulWidget {
   ConsultNotiNewDriversImages({
    Key? key,
    required this.record,
    required this.contract
  }) : super(key: key);
   NotificationNewDriver record;
  String contract;

  @override
  State<ConsultNotiNewDriversImages> createState() => _ConsultNotiNewDriversImagesState();
}

class _ConsultNotiNewDriversImagesState extends State<ConsultNotiNewDriversImages> {

  UploadTask? uploadTask;

  final DriversController controller = Get.put(DriversController());
  NotificationNewDriverController notificationNewDriverController = Get.put(NotificationNewDriverController());
  LoginController loginController =Get.put(LoginController());


  String? identityFace1ImageUrl;
  String? identityFace2ImageUrl;
  String? licenceFace1ImageUrl;
  String? licenceFace2ImageUrl;
  String? more1ImageUrl;
  String? more2ImageUrl;
  String? more3ImageUrl;
  @override
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
                controller.init();
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
        body: Container(
          decoration:  BoxDecoration(
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
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80),
                      ),
                      color: Color(0xFF0F5CA0)
                  ),
                ),
              ),
              SizedBox(height: 38,),
              Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  // height: MediaQuery.of(context).size.height*0.787,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFffffff).withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)
                      )
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text('Driver Identity',style:TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 5,),
                            Row(
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
                                      GestureDetector(
                                        onTap:(){
                                          if(widget.record.identityCardImageFace1.split('?').first.endsWith('.jpg')||
                                              widget.record.identityCardImageFace1.split('?').first.endsWith('.jpeg')||
                                              widget.record.identityCardImageFace1.split('?').first.endsWith('.png')
                                          )
                                            showDialog(
                                                context: context,
                                                builder: ((builder)=>
                                                    AlertDialog(
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                      content: Stack(
                                                        children: [
                                                          Container(
                                                            // height:250,
                                                            width: MediaQuery.of(context).size.width,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(
                                                                top:20.0,
                                                              ),
                                                              child: PhotoView(
                                                                imageProvider: NetworkImage(
                                                                  widget.record.identityCardImageFace1,
                                                                  // width:1300,
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
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                      content: Container(

                                                        // height: 500,
                                                        width: 2500,
                                                        child: SfPdfViewer.network(widget.record.identityCardImageFace1,),
                                                      ),
                                                    )
                                                )
                                            );
                                          }



                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.365,
                                              child:
                                                widget.record.identityCardImageFace1.split('?').first.endsWith('.jpg')
                                                  ?Padding(
                                                padding: const EdgeInsets.all(4.0),
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
                                            Center(child: Icon(Icons.remove_red_eye_sharp,size: 20,))
                                          ],
                                        ),
                                      )

                                    // ? Text(controller.selectedFile.value!.path.split('/').last)

                                  ),
                                ),
                                SizedBox(width: 8,),
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
                                      GestureDetector(
                                        onTap:(){
                                          if(controller.selectedIdentityFace2.value!=null && controller.selectedIdentityFace2.value!.path.split('/')!.last.endsWith('.pdf'))
                                          {
                                            showDialog(
                                                context: context,
                                                builder: (
                                                        (builder)=>AlertDialog(
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
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
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                      content: Stack(
                                                        children: [
                                                          Container(
                                                            // height:250,
                                                            width: 1800,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(
                                                                top:20.0,
                                                              ),
                                                              child: PhotoView(
                                                                imageProvider: FileImage(
                                                                  controller.selectedIdentityFace2.value!,
                                                                  // width:1300,
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
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                      content: Stack(
                                                        children: [
                                                          Container(
                                                            // height:250,
                                                            width: 1800,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(
                                                                top:20.0,
                                                              ),
                                                              child: PhotoView(
                                                                imageProvider : NetworkImage(
                                                                  widget.record.identityCardImageFace2,
                                                                  // width:1300,
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
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                      content: Container(
                                                        height: 500,
                                                        width: 2500,
                                                        child: SfPdfViewer.network(widget.record.identityCardImageFace2,),
                                                      ),
                                                    )
                                                )
                                            );
                                          }



                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width*0.365,
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
                                            Center(child: Icon(Icons.remove_red_eye_sharp,size: 20,))
                                          ],
                                        ),
                                      )

                                    // ? Text(controller.selectedFile.value!.path.split('/').last)

                                  ),
                                ),

                                // Obx(() => Padding(
                                //   padding: const EdgeInsets.only(
                                //       top:2.0,
                                //       bottom:2
                                //   ),
                                //   child: Container(
                                //     height: 70,
                                //     width: MediaQuery.of(context).size.width*0.365,
                                //     decoration: BoxDecoration(
                                //         color: Colors.white.withOpacity(0.2),
                                //         border: Border.all(
                                //             color: Colors.grey.withOpacity(0.4),
                                //             width: 2
                                //         )
                                //     ),
                                //     child: controller.selectedIdentityFace2.value == null
                                //         ?Image(image:AssetImage("assets/images/idFace2.png"))
                                //         :controller.selectedIdentityFace2.value!.path.endsWith('.pdf')
                                //         ? Column(
                                //       children: [
                                //         Icon(Icons.file_open),
                                //         Text(controller.selectedIdentityFace2.value!.path.split('/').last,)
                                //       ],
                                //     )
                                //         :Padding(
                                //         padding: EdgeInsets.only(
                                //             top:2,
                                //             bottom:2,
                                //             right: 15,
                                //             left: 15
                                //         ),
                                //         child: Image.file(controller.selectedIdentityFace2.value!,fit: BoxFit.fill,)),
                                //   ),
                                // )),
                              ],
                            ),
                            // Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 8,color: Colors.grey),),
                            SizedBox(height: 12,),
                            Text('Driver Licence',style:TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 5,),
                            Row(
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
                                      GestureDetector(
                                        onTap:(){
                                          if(controller.selectedLicenceFace1.value!=null && controller.selectedLicenceFace1.value!.path.split('/')!.last.endsWith('.pdf'))
                                          {
                                            // SfPdfViewer.network(widget.record.identityCardImageFace1);
                                            showDialog(
                                                context: context,
                                                builder: (
                                                        (builder)=>AlertDialog(
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
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
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                      content: Stack(
                                                        children: [
                                                          Container(
                                                            // height:250,
                                                            width: 1800,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(
                                                                top:20.0,
                                                              ),
                                                              child: PhotoView(
                                                                imageProvider:FileImage(
                                                                  controller.selectedLicenceFace1.value!,
                                                                  // width:1300,
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
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                      content: Stack(
                                                        children: [
                                                          Container(
                                                            // height:250,
                                                            width:  MediaQuery.of(context).size.width,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(
                                                                top:20.0,
                                                              ),
                                                              child: PhotoView(
                                                                imageProvider: NetworkImage(
                                                                  widget.record.licenceImageFace1,
                                                                  // width:1300,
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
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
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
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.365,
                                              child:
                                              widget.record.licenceImageFace1.split('?').first.endsWith('.jpg')
                                                  ?Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Image.network(
                                                  widget.record.licenceImageFace1,
                                                  width: 100,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  :widget.record.licenceImageFace1.split('?').first.endsWith('.jpeg')
                                                  ?Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Image.network(
                                                  widget.record.licenceImageFace1,
                                                  width: 100,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  : widget.record.licenceImageFace1.split('?').first.endsWith('.png')
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
                                            Center(child: Icon(Icons.remove_red_eye_sharp,size: 20,))
                                          ],
                                        ),
                                      )

                                    // ? Text(controller.selectedFile.value!.path.split('/').last)

                                  ),
                                ),
                                 SizedBox(width: 8,),
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
                                      GestureDetector(
                                        onTap:(){
                                          if(widget.record.licenceImageFace2.split('?').first.endsWith('.jpg')||
                                              widget.record.licenceImageFace2.split('?').first.endsWith('.jpeg')||
                                              widget.record.licenceImageFace2.split('?').first.endsWith('.png')
                                          )
                                            showDialog(
                                                context: context,
                                                builder: ((builder)=>
                                                    AlertDialog(
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                      content: Stack(
                                                        children: [
                                                          Container(
                                                            // height:250,
                                                            width:  MediaQuery.of(context).size.width,
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(
                                                                top:20.0,
                                                              ),
                                                              child: PhotoView(
                                                                imageProvider: NetworkImage(
                                                                  widget.record.licenceImageFace2,
                                                                  // width:1300,
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
                                                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                                      content: Container(
                                                        height: 500,
                                                        width: 2500,
                                                        child: SfPdfViewer.network(widget.record.licenceImageFace2,),
                                                      ),
                                                    )
                                                )
                                            );
                                          }


                                        },
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.365,
                                              child:
                                              widget.record.licenceImageFace2.split('?').first.endsWith('.jpg')
                                                  ?Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Image.network(
                                                  widget.record.licenceImageFace2,
                                                  width: 100,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  :widget.record.licenceImageFace2.split('?').first.endsWith('.jpeg')
                                                  ?Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Image.network(
                                                  widget.record.licenceImageFace2,
                                                  width: 100,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  : widget.record.licenceImageFace2.split('?').first.endsWith('.png')
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
                                            Center(child: Icon(Icons.remove_red_eye_sharp,size: 20,))
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            // Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 8,color: Colors.grey),),
                            SizedBox(height: 12,),

                            if(widget.record.moreImage1!="")moreWidget1(),
                            if(widget.record.moreImage2!="")moreWidget2(),
                            if(widget.record.moreImage3!="")moreWidget3(),
                            SizedBox(height: 100,),


                          ],
                        ),
                      ),

                      Positioned(
                        bottom: 30,
                        right: 10,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                controller.init();
                                Get.back();
                              },
                              child: Center(
                                child: Container(
                                  width: 120,
                                  height: 30,
                                  child: Center(child: Text('Back',style: TextStyle(color: Colors.black),)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xFFFFFFFF)
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Obx(
                               () {
                                return GestureDetector(
                                  onTap: ()async{
                                    if(controller.loadingConfirmed.value)return;
                                    await controller.add_driver(
                                        DriverModel(
                                            driverImage: widget.record.driverImage,
                                            firstName: widget.record.firstName.capitalize.toString(),
                                            lastName: widget.record.lastName.capitalize.toString(),
                                            birthDate: widget.record.birthDate,
                                            identityNumber: widget.record.identityNumber,
                                            identityCardImageFace1: widget.record.identityCardImageFace1,
                                            identityCardImageFace2: widget.record.identityCardImageFace2,
                                            phoneNumber: widget.record.phoneNumber,
                                            licenceType: widget.record.licenceType,
                                            licenceImageFace1: widget.record.licenceImageFace1,
                                            licenceImageFace2: widget.record.licenceImageFace2,
                                            email: widget.record.email,
                                            contractType: widget.contract,
                                            password:widget.record.password,
                                          moreImage1: widget.record.moreImage1,
                                          moreImage2: widget.record.moreImage2,
                                          moreImage3: widget.record.moreImage3,
                                        )
                                    ).then((value) {
                                      // Get.offAll(() => HomeScreen())
                                      notificationNewDriverController.notiDrivers.doc(widget.record.id).update({"valid":true});
                                      Get.back();
                                      Get.back();
                                    }
                                    );

                                  },

                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Color(0xFF333333)
                                      ),
                                      width: 120,
                                      height: 30,
                                      child: controller.loadingConfirmed.value ? Center(child: CircularProgressIndicator(color: Colors.white70,),):Center(child: Text('Confirm',style: TextStyle(color: Colors.white),)),

                                    ),
                                  ),
                                );
                              }
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
                        ?Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.network(
                        widget.record.moreImage1!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        :widget.record.moreImage1!.split('?').first.endsWith('.jpeg')
                        ?Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.network(
                        widget.record.moreImage1!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        : widget.record.moreImage1!.split('?').first.endsWith('.png')
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
                                        contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                        content: Stack(
                                          children: [
                                            Container(
                                              // height:250,
                                              width:  MediaQuery.of(context).size.width,
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
                              // SfPdfViewer.network(widget.record.identityCardImageFace1);
                              showDialog(
                                  context: context,
                                  builder: (
                                          (builder)=>AlertDialog(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        // Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 10,color: Colors.grey),),
        // InkWell(
        //   onTap: (){
        //     controller.selectedMore1.value=null;
        //   },
        //   child: Text('cancel',style: TextStyle(color: Colors.red,fontSize: 15),),
        // )
        //   ],
        // ),
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
                        ?Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.network(
                        widget.record.moreImage2!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        :widget.record.moreImage2!.split('?').first.endsWith('.jpeg')
                        ?Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.network(
                        widget.record.moreImage2!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        : widget.record.moreImage2!.split('?').first.endsWith('.png')
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
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
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
                                        contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                        content: Stack(
                                          children: [
                                            Container(
                                              // height:250,
                                              width:  MediaQuery.of(context).size.width,
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
                                        contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                        content: Stack(
                                          children: [
                                            Container(
                                              // height:250,
                                              width:  MediaQuery.of(context).size.width,
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
                              // SfPdfViewer.network(widget.record.identityCardImageFace1);
                              showDialog(
                                  context: context,
                                  builder: (
                                          (builder)=>AlertDialog(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        // Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 10,color: Colors.grey),),
        //     InkWell(
        //       onTap: (){
        //         controller.selectedMore1.value=null;
        //       },
        //       child: Text('cancel',style: TextStyle(color: Colors.red,fontSize: 15),),
        //     )
        //   ],
        // ),
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
                        ?Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.network(
                        widget.record.moreImage3!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        :widget.record.moreImage3!.split('?').first.endsWith('.jpeg')
                        ?Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.network(
                        widget.record.moreImage3!,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    )
                        : widget.record.moreImage3!.split('?').first.endsWith('.png')
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
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
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
                                        contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                        content: Stack(
                                          children: [
                                            Container(
                                              // height:250,
                                              width:  MediaQuery.of(context).size.width,
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
                                        contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                                        content: Stack(
                                          children: [
                                            Container(
                                              // height:250,
                                              width:  MediaQuery.of(context).size.width,
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
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 32),
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
        // Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 10,color: Colors.grey),),

      ],
    );
  }

}
