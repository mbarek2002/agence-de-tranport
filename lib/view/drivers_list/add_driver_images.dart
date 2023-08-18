import 'dart:io';
import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/drivers_list/driver_list_screen.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddDriverImagesScreen extends StatefulWidget {

   AddDriverImagesScreen({
    Key? key,
    required this.record
  }) : super(key: key);

   DriverModel record;

  @override
  State<AddDriverImagesScreen> createState() => _AddDriverImagesScreenState();
}

class _AddDriverImagesScreenState extends State<AddDriverImagesScreen> {

  int counter=0;
  final DriversController controller = Get.put(DriversController());
  LoginController loginController =Get.put(LoginController());



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
            child: Text("Add driver",style: TextStyle(
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
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFffffff).withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left:28,
                          right: 28
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text('Upload Identity',style:TextStyle(fontWeight: FontWeight.bold)),
                                  Text('*',style:TextStyle(color: Colors.red,fontWeight: FontWeight.bold))
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: Obx(() => Padding(
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
                                        child: controller.selectedIdentityFace1.value == null
                                        ?Image(image:AssetImage("assets/images/idFace1.png"))
                                          :controller.selectedIdentityFace1.value!.path.endsWith('.pdf')
                                           ? Column(
                                             children: [
                                              Icon(Icons.file_open),
                                              Text(controller.selectedIdentityFace1.value!.path.split('/').last,
                                                style: TextStyle(fontSize: 10),)
                                          ],
                                        )
                                            :Padding(
                                            padding: EdgeInsets.only(
                                                top:2,
                                                bottom:2,
                                                right: 15,
                                                left: 15
                                            ),
                                            child: Image.file(controller.selectedIdentityFace1.value!,fit: BoxFit.fill,)),
                                        // ? Text(controller.selectedFile.value!.path.split('/').last)

                                      ),
                                    )),
                                    onTap: (){
                                      controller.pickIdentityFileFace1();
                                      // showModalBottomSheet(
                                      //     context: context,
                                      //     builder: ((builder)=>bottomSheet())
                                      // );
                                    },
                                  ),
                                  GestureDetector(
                                    child: Obx(() => Padding(
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
                                        child: controller.selectedIdentityFace2.value == null
                                            ?Image(image:AssetImage("assets/images/idFace2.png"))
                                            :controller.selectedIdentityFace2.value!.path.endsWith('.pdf')
                                            ? Column(
                                          children: [
                                              Icon(Icons.file_open),
                                              Text(controller.selectedIdentityFace2.value!.path.split('/').last,)
                                            ],
                                          )
                                            :Padding(
                                            padding: EdgeInsets.only(
                                                top:2,
                                                bottom:2,
                                                right: 15,
                                                left: 15
                                            ),
                                            child: Image.file(controller.selectedIdentityFace2.value!,fit: BoxFit.fill,)),
                                      ),
                                    )),
                                    onTap: (){
                                      controller.pickIdentityFileFace2();
                                    },
                                  ),
                                ],
                              ),
                              Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 8,color: Colors.grey),),
                              SizedBox(height: 12,),
                              Row(
                                children: [
                                  Text('Upload Licence',style:TextStyle(fontWeight: FontWeight.bold)),
                                  Text('*',style:TextStyle(color: Colors.red,fontWeight: FontWeight.bold))
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: Obx(() => Padding(
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
                                        child:controller.selectedLicenceFace1.value == null
                                            ?Image(image:AssetImage("assets/images/idFace1.png"))
                                            :controller.selectedLicenceFace1.value!.path.endsWith('.pdf')
                                            ? Column(
                                             children: [
                                              Icon(Icons.file_open),
                                              Text(controller.selectedLicenceFace1.value!.path.split('/').last,)
                                          ],
                                        )
                                            :Padding(
                                            padding: EdgeInsets.only(
                                                top:2,
                                                bottom:2,
                                                right: 15,
                                                left: 15
                                            ),
                                            child: Image.file(controller.selectedLicenceFace1.value!,fit: BoxFit.fill,)),
                                      ),
                                    )),
                                    onTap: (){
                                      controller.pickLicenceFileFace1();
                                    },
                                  ),
                                  GestureDetector(
                                    child: Obx(() => Padding(
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
                                        child: controller.selectedLicenceFace2.value == null
                                            ?Image(image:AssetImage("assets/images/permis.png"))
                                            :controller.selectedLicenceFace2.value!.path.endsWith('.pdf')
                                            ? Column(
                                          children: [
                                            Icon(Icons.file_open),
                                            Text(controller.selectedLicenceFace2.value!.path.split('/').last,)
                                          ],
                                        )
                                            :Padding(
                                            padding: EdgeInsets.only(
                                                top:2,
                                                bottom:2,
                                                right: 15,
                                                left: 15
                                            ),
                                            child: Image.file(controller.selectedLicenceFace2.value!,fit: BoxFit.fill,)),
                                      ),
                                    )),
                                    onTap: (){
                                      controller.pickLicenceFileFace2();
                                      // return;
                                      // showModalBottomSheet(
                                      //     context: context,
                                      //     builder: ((builder)=>bottomSheet())
                                      // );
                                      // controller.pickImage();
                                      // Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 8,color: Colors.grey),),
                              SizedBox(height: 12,),
                              if(counter>=1)moreWidget1(),
                              if(counter>=2)moreWidget2(),
                              if(counter>=3)moreWidget3(),

                              if(counter<3)OutlinedButton(
                                  onPressed: (){
                                    setState(() {
                                      counter++;
                                    });
                                  },
                                  child: Text('More...',style:TextStyle(color: Colors.black))
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 20,
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
                                GestureDetector(
                                  onTap: (){
                                    if(
                                    controller.selectedIdentityFace1.value==null || controller.selectedIdentityFace1.value==null||
                                        controller.selectedLicenceFace1.value==null ||controller.selectedLicenceFace2.value==null
                                    ){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Please make sure that you have select the four necessary pictures"),
                                          duration: Duration(seconds: 5),
                                        ),
                                      );
                                    }
                                    else {
                                      try{
                                        showDialog(
                                            context: context, builder: ((builder)=>Center(child:CircularProgressIndicator())));
                                        uploadFiles().then((value) {
                                          Navigator.pop(context);
                                          Get.back();
                                          Get.back();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Driver added succeffuly"),
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                        }
                                        );

                                      }catch(e){
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("there is an error"+e.toString()),
                                            duration: Duration(seconds: 5),
                                          ),
                                        );
                                      }


                                      // controller.init();

                                      // Navigator.push(context, MaterialPageRoute(builder: ((builder)=>DriversListScreen()))));
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 120,
                                      height: 30,
                                      child: Center(child: Text('Save',style: TextStyle(color: Colors.white),)),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Color(0xFF333333)
                                      ),
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
            "Choose photo",
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
              GestureDetector(
                onTap : (){
                  controller.getImage();
                  Navigator.pop(context);

                },
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
                onTap : (){
                  controller.pickIdentityFileFace1();
                  Navigator.pop(context);
                  },
                child: Container(
                  child: Row(
                    children: [
                      Text('Other'),
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
  Widget moreWidget1(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        GestureDetector(
          child: Obx(() => Padding(
            padding: const EdgeInsets.only(
                top:2.0,
                bottom:2
            ),
            child: Container(
              height: 85,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                      width: 2
                  )
              ),
              child: controller.selectedMore1.value == null
                  ?Padding(
                  padding: EdgeInsets.only(
                  top:10,
                  bottom:2,
                  right: 15,
                  left: 15
                  ),
                  child: Column(
                  children: [
                    Icon(Icons.file_download_outlined),
                    Text('Click on this area to upload file')
                  ],
                  ),
                  )
                  :controller.selectedMore1.value!.path.endsWith('.pdf')
                  ? Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                    children: [
                      Icon(Icons.file_open),
                      Text(controller.selectedMore1.value!.path.split('/').last,)
                ],
              ),
                  )
                  :Padding(
                  padding: EdgeInsets.only(
                      top:2,
                      bottom:2,
                      right: 40,
                      left: 40
                  ),
                  child: Image.file(controller.selectedMore1.value!,fit: BoxFit.fill,)),

            ),
          )),
          onTap: (){
            controller.pickMore1File();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 10,color: Colors.grey),),
            InkWell(
              onTap: (){
                controller.selectedMore1.value=null;
              },
              child: Text('cancel',style: TextStyle(color: Colors.red,fontSize: 15),),
            )
          ],
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
        GestureDetector(
          child: Obx(() => Padding(
            padding: const EdgeInsets.only(
                top:2.0,
                bottom:2
            ),
            child: Container(
              height: 85,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                      width: 2
                  )
              ),
              child:  controller.selectedMore2.value == null
                  ?Padding(
                padding: EdgeInsets.only(
                    top:10,
                    bottom:2,
                    right: 15,
                    left: 15
                ),
                child: Column(
                  children: [
                    Icon(Icons.file_download_outlined),
                    Text('Click on this area to upload file')
                  ],
                ),
              )
                  :controller.selectedMore2.value!.path.endsWith('.pdf')
                  ? Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                  children: [
                    Icon(Icons.file_open),
                    Text(controller.selectedMore2.value!.path.split('/').last,)
                  ],
                ),
              )
                  :Padding(
                  padding: EdgeInsets.only(
                      top:2,
                      bottom:2,
                      right: 40,
                      left: 40
                  ),
                    child: Image.file(controller.selectedMore2.value!,fit: BoxFit.fill,)),
            ),
          )),
          onTap: (){
            controller.pickMore2File();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 10,color: Colors.grey),),
            InkWell(
              onTap: (){
                controller.selectedMore2.value=null;

              },
              child: Text('cancel',style: TextStyle(color: Colors.red,fontSize: 15),),
            )
          ],
        ),
        SizedBox(height: 10,),
      ],
    );
  }
  Widget moreWidget3(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        GestureDetector(
          child: Obx(() => Padding(
            padding: const EdgeInsets.only(
                top:2.0,
                bottom:2
            ),
            child: Container(
              height: 85,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.4),
                      width: 2
                  )
              ),
              child:  controller.selectedMore3.value == null
                  ?Padding(
                padding: EdgeInsets.only(
                    top:10,
                    bottom:2,
                    right: 15,
                    left: 15
                ),
                child: Column(
                  children: [
                    Icon(Icons.file_download_outlined),
                    Text('Click on this area to upload file')
                  ],
                ),
              )
                  :controller.selectedMore3.value!.path.endsWith('.pdf')
                  ? Padding(
                  padding: EdgeInsets.all(15),
                    child: Column(
                  children: [
                    Icon(Icons.file_open),
                    Text(controller.selectedMore3.value!.path.split('/').last,)
                  ],
                ),
              )
                  :Padding(
                  padding: EdgeInsets.only(
                      top:2,
                      bottom:2,
                      right: 40,
                      left: 40
                  ),
                  child: Image.file(controller.selectedMore3.value!,fit: BoxFit.fill,)),
            ),
          )),
          onTap: (){
            controller.pickMore3File();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Allowed file types .pdf,.png',style: TextStyle(fontSize: 10,color: Colors.grey),),
            InkWell(
              onTap: (){
                controller.selectedMore3.value=null;
              },
              child: Text('cancel',style: TextStyle(color: Colors.red,fontSize: 15),),
            )
          ],
        ),
        SizedBox(height: 45,),
      ],
    );
  }


  Future<void> uploadFiles() async {

    showDialog(
        context: context, builder: ((builder) => Center(child: CircularProgressIndicator())));
    try {
///////////image driver upload ///////
      final driverImageURL;
    if(widget.record.driverImage != "") {
      final driverUploadTask = FirebaseStorage.instance.ref(
          'drivers/' + DateTime
              .now()
              .difference(DateTime(2022, 1, 1))
              .inSeconds
              .toString() + '${widget.record.driverImage
              ?.split('/')
              .last}')
          .putFile(File(widget.record.driverImage));
      final driverSnapshot = await driverUploadTask.whenComplete(() => null);
       driverImageURL = await driverSnapshot.ref.getDownloadURL();
    }
    else{
      driverImageURL="";
    }
///////////identity card upload////////////

      final driverCardFace1UploadTask = FirebaseStorage.instance.ref(
          'drivers/' + DateTime
              .now()
              .difference(DateTime(2022, 1, 1))
              .inSeconds
              .toString() + '${controller.selectedIdentityFace1.value!
              .path
              .split('/')
              .last}')
          .putFile(controller.selectedIdentityFace1.value!);
      final driverCardFace1Snapshot = await driverCardFace1UploadTask
          .whenComplete(() => null);
      final driverCardFace1ImageURL = await driverCardFace1Snapshot.ref
          .getDownloadURL();

      print("selectedIdentityFace2 : "+controller.selectedIdentityFace2.value!.path);

      final driverCardFace2UploadTask = FirebaseStorage.instance.ref(
          'drivers/' + DateTime
              .now()
              .difference(DateTime(2022, 1, 1))
              .inSeconds
              .toString() + '${controller.selectedIdentityFace2.value!
              .path
              .split('/')
              .last}')
          .putFile(controller.selectedIdentityFace2.value!);
      final driverCardFace2Snapshot = await driverCardFace2UploadTask
          .whenComplete(() => null);
      final driverCardFace2ImageURL = await driverCardFace2Snapshot.ref
          .getDownloadURL();

//////////////////licence card upload//////////////


      final licenceCardFace1UploadTask = FirebaseStorage.instance.ref(
          'drivers/' + DateTime
              .now()
              .difference(DateTime(2022, 1, 1))
              .inSeconds
              .toString() + '${controller.selectedLicenceFace1.value!
              .path
              .split('/')
              .last}')
          .putFile(controller.selectedLicenceFace1.value!);
      final licenceCardFace1Snapshot = await licenceCardFace1UploadTask
          .whenComplete(() => null);
      final licenceCardFace1ImageURL = await licenceCardFace1Snapshot.ref
          .getDownloadURL();

      final licenceCardFace2UploadTask = FirebaseStorage.instance.ref(
          'drivers/' + DateTime
              .now()
              .difference(DateTime(2022, 1, 1))
              .inSeconds
              .toString() + '${controller.selectedLicenceFace2.value!
              .path
              .split('/')
              .last}')
          .putFile(controller.selectedLicenceFace2.value!);
      final licenceCardFace2Snapshot = await licenceCardFace2UploadTask
          .whenComplete(() => null);
      final licenceCardFace2ImageURL = await licenceCardFace2Snapshot.ref
          .getDownloadURL();
///////////////////more image upload////////////////
      var more1ImageURL = '';
      var more2ImageURL = '';
      var more3ImageURL = '';

      if (controller.selectedMore1.value != null) {
        final more1UploadTask = FirebaseStorage.instance.ref(
            'drivers/' + DateTime
                .now()
                .difference(DateTime(2022, 1, 1))
                .inSeconds
                .toString() + '${controller.selectedMore1.value!
                .path
                .split('/')
                .last}')
            .putFile(controller.selectedMore1.value!);
        final more1Snapshot = await more1UploadTask.whenComplete(() => {});
        more1ImageURL = await more1Snapshot.ref.getDownloadURL();
      }
      if (controller.selectedMore2.value != null) {
        final more2UploadTask = FirebaseStorage.instance.ref(
            'drivers/' + DateTime
                .now()
                .difference(DateTime(2022, 1, 1))
                .inSeconds
                .toString() + '${controller.selectedMore2.value!
                .path
                .split('/')
                .last}')
            .putFile(controller.selectedMore2.value!);
        final more2Snapshot = await more2UploadTask.whenComplete(() => {});
        more2ImageURL = await more2Snapshot.ref.getDownloadURL();
      }
      if (controller.selectedMore3.value != null) {
        final more3UploadTask = FirebaseStorage.instance.ref(
            'drivers/' + DateTime
                .now()
                .difference(DateTime(2022, 1, 1))
                .inSeconds
                .toString() + '${controller.selectedMore3.value!
                .path
                .split('/')
                .last}')
            .putFile(controller.selectedMore3.value!);
        final more3Snapshot = await more3UploadTask.whenComplete(() => {});
        more3ImageURL = await more3Snapshot.ref.getDownloadURL();
      }
      controller.add_driver(
          DriverModel(
            driverImage: driverImageURL,
            firstName: widget.record.firstName,
            lastName: widget.record.lastName,
            birthDate: widget.record.birthDate,
            identityNumber: widget.record.identityNumber,
            identityCardImageFace1: driverCardFace1ImageURL,
            identityCardImageFace2: driverCardFace2ImageURL,
            phoneNumber: widget.record.phoneNumber,
            licenceType: widget.record.licenceType,
            licenceImageFace1: licenceCardFace1ImageURL,
            licenceImageFace2: licenceCardFace2ImageURL,
            email: widget.record.email,
            contractType: widget.record.contractType,
            password: widget.record.password,
            moreImage1: more1ImageURL,
            moreImage2: more2ImageURL,
            moreImage3: more3ImageURL,
          )
      );
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      print("Failed with error '${e.code}': ${e.message}");
    }
  }

}
