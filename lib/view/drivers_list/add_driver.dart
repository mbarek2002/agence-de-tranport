import 'dart:io';

import 'package:admin_citygo/controllers/driver_list/drivers_list_controller.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class AddDriverScreen extends StatefulWidget {
   AddDriverScreen({Key? key}) : super(key: key);

  @override
  State<AddDriverScreen> createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  String _selectedItem = '';
  List<String> _dropdownItems = ['A1', 'A', 'B','B+E','C','C+E'];

   bool checkBox1 = false;
   bool checkBox2 = false;

   File? _image;
   File? identityImage;
   File? licenceImage;
   final picker = ImagePicker();
   final driverImageName='';
   final identityImageName='';
   final licenceImageName='';

   UploadTask? uploadTask;

   String driverDownloadURL='';
   String identityDownloadURL='';
   String licenceDownloadURL='';

  DriversListController controller =DriversListController();
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
                  // TopWidget(title: 'Notification New driver'),
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
                      child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Text('Add a driver ',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Georgia'
                          ),),
                          imageProfile(),
                          TextFormField(
                            controller: controller.firstNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please entre first name';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              label: Text('First name'),
                              labelStyle: TextStyle(color: Color(0xFF373737),fontSize: 10),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: controller.lastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please entre last name';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              label: Text('Last name'),
                              labelStyle: TextStyle(color: Color(0xFF373737),fontSize: 10),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: controller.birthDateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please entre birth date';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              label: Text('Birth date'),
                              labelStyle: TextStyle(color: Color(0xFF373737),fontSize: 10),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: controller.identityNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please entre first name';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: (){
                                  getIdentityImage();
                                },
                                icon: Icon(Icons.file_download),
                              ),
                              label: Text('Identity Card'),
                              labelStyle: TextStyle(color: Color(0xFF373737),fontSize: 10),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: controller.phoneNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please entre phone number';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              label: Text('Phone Number'),
                              labelStyle: TextStyle(color: Color(0xFF373737),fontSize: 10),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Text("Licence type",style: TextStyle(color: Color(0xFF373737),fontSize: 10),),
                          DropdownButton<String>(
                                dropdownColor: Color(0xFF525252).withOpacity(0.97),
                                // value: _selectedItem,
                                hint: Text(_selectedItem,style:TextStyle(color: Color(0xFF373737),fontSize: 18)),
                                elevation: 16,
                                icon: IconButton(
                                  icon: Icon(Icons.file_download),
                                  onPressed: (){
                                    getLicenceImage();
                                  },
                                ),
                                items: _dropdownItems.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                underline: Container(
                                  height: 2,
                                  color: Colors.black,
                                ), //remove underline
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedItem = newValue!;
                                  });
                                },
                              ),
                          SizedBox(height:5),
                          Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Contract type".capitalize.toString(),style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Georgia"),),
                                  Row(
                                    children: [
                                      Text("seasonal",style: TextStyle(fontSize: 10),),
                                      Checkbox(value: checkBox1, onChanged: (value){
                                        if(checkBox2==false){
                                          setState(() {
                                            checkBox1=!checkBox1;
                                          });}
                                        else{
                                          setState(() {
                                            checkBox1=false;
                                          });
                                        }
                                      }),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Text("Full Time Contract",style: TextStyle(fontSize: 10),),
                                      Checkbox(value: checkBox2, onChanged: (value){
                                        if(checkBox1==false){
                                          setState(() {
                                            checkBox2=!checkBox2;
                                          });}
                                        else{
                                          setState((){
                                            checkBox2=false;
                                          });
                                        }
                                      }),
                                    ],
                                  ),

                                ],
                              ),
                          const Divider(
                                height: 10,
                                thickness: 2,
                                color: Colors.black,
                              ),
                          TextFormField(
                            controller: controller.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please entre first name';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(

                              label: Text('Email'),
                              labelStyle: TextStyle(color: Color(0xFF373737),fontSize: 10),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 2),
                              ),
                            ),
                          ),
                          SizedBox(height: 40,),
                          GestureDetector(
                            onTap: (){uploadFiles();},
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
                          SizedBox(height: 260,)
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
                // color: Colors.green,
                width: MediaQuery.of(context).size.width,
                // height: 20,
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage("assets/images/home_screen/person.jpg"),
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
  Widget imageProfile(){
     return Stack(
       children: <Widget>[
         Center(
           child: CircleAvatar(
             radius: 35.0,
             child:_image == null
                 ? Image(image: AssetImage('assets/images/Exclude.png'),fit: BoxFit.fill,width: 70,)
                   :ClipOval(child: Image.file(_image!,width:70,fit: BoxFit.fill,))
           ),
         ),

         Positioned(
           bottom: 5,
             right: 100,
             child: InkWell(
               onTap: (){
                 showModalBottomSheet(
                     context: context,
                     builder: ((builder)=>bottomSheet())
                 );
               },
               child: Container(
                 width: 20,
                 height: 20,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(45),
                    color: Color(0xFF373737)
                 ),
                   child: Icon(Icons.camera_alt_rounded,color: Colors.white,size: 15,)
               ),
             )
         )
       ],
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
                 onTap:getImageFromGallery,
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
     final pickedFile = await picker.pickImage(source: ImageSource.camera);
     setState(() {
       if (pickedFile != null) {
         final driverImageName =pickedFile!.name;
         _image = File(pickedFile.path);
       } else {
         print('No image selected.');
       }
     });
   }
   Future getImageFromGallery() async {
     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
     setState(() {
       if (pickedFile != null) {
         final driverImageName =pickedFile!.name;
         _image = File(pickedFile.path);
       } else {
         print('No image selected.');
       }
     });
   }
   Future getIdentityImage()async{
     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

     setState(() {
       if (pickedFile != null) {
         final identityImageName =pickedFile!.name;
         identityImage = File(pickedFile.path);
       } else {
         print('No image selected.');
       }
     });
   }
   Future getLicenceImage()async{
     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
     setState(() {
       if (pickedFile != null) {
         final licenceImageName =pickedFile!.name;
         licenceImage = File(pickedFile.path);
       } else {
         print('No image selected.');
       }
     });
   }

  Future<void> uploadFiles() async {
    final driverImagePath = 'drivers/${driverImageName}';
    final identityImagePath = 'files/${driverImageName}';
    final licenceImagePath = 'files/${driverImageName}';

    final refDriver = FirebaseStorage.instance.ref(driverImagePath);
    final refIdentity = FirebaseStorage.instance.ref(identityImagePath);
    final refLicence = FirebaseStorage.instance.ref(licenceImagePath);

    final driverUploadTask = refDriver.putFile(_image!);
    final identityUploadTask = refIdentity.putFile(identityImage!);
    final licenceUploadTask = refLicence.putFile(licenceImage!);

    final driverSnapshot = await driverUploadTask.whenComplete(() => {});
    final identitySnapshot = await identityUploadTask.whenComplete(() => {});
    final licenceSnapshot = await licenceUploadTask.whenComplete(() => {});


    setState(() async{
      driverDownloadURL = await driverSnapshot.ref.getDownloadURL();
      identityDownloadURL = await identitySnapshot.ref.getDownloadURL();
      licenceDownloadURL = await licenceSnapshot.ref.getDownloadURL();
    });

    print('Driver download link: $driverDownloadURL');
    print('Identity download link: $identityDownloadURL');
    print('Licence download link: $licenceDownloadURL');
  }

}
