import 'dart:io';
import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/drivers_list/add_driver_images.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class AddDriverScreen extends StatefulWidget {
   AddDriverScreen({Key? key}) : super(key: key);

  @override
  State<AddDriverScreen> createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  String _selectedItem = '';
  List<String> _dropdownItems = ['AA', 'A', 'B','B+E','C','C+E','D','D1','D+E','G'+'H'];

   bool checkBox1 = false;
   bool checkBox2 = false;

   bool validLicenceType=false;
   bool validContratType=false;

   File? _image;
   File? identityImage;
   File? licenceImage;
   final picker = ImagePicker();
   String driverImageName='';
   String identityImageName='';
   String licenceImageName='';
   UploadTask? uploadTask;

   String contract='';
   String driverDownloadURL='';
   String identityDownloadURL='';
   String licenceDownloadURL='';

  DriversController controller =DriversController();
  final _formKey = GlobalKey<FormState>();

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  double password_strength =0;

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch("hdhfu637!jxjfjtrutu4688#");
  }

  DateTime? _selectedDate;


  XFile? pickedFile;

  LoginController loginController =Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.birthDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.birthDateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  String? _dateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a date';
    }

    try {
      DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (e) {
      return 'Invalid date format. Use yyyy-MM-dd';
    }

    return null;
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
                      child: Form(
                        key: _formKey,
                        child: ListView(
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
                              style: TextStyle(color: Colors.black),
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
                              style: TextStyle(color: Colors.black),
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
                              onTap: () => _selectDate(context),
                              readOnly: true,
                              validator: _dateValidator,
                              style: TextStyle(color: Colors.black),
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
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please entre Identity Number';
                                }
                                else if(value.length!=8){
                                  return 'invalid identity Number';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
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
                                }else if(value.length!=8){
                                  return 'invalid Phone Number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
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
                            TextFormField(
                              controller: controller.emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please entre Email';
                                }else if(!GetUtils.isEmail(value)){
                                  return 'Please entre that contains @ and .';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.black),
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
                            TextFormField(
                              controller: controller.passwordController,
                              obscureText: true,
                              validator: Validators.compose([
                                Validators.required('Password is required'),
                                Validators.patternString(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', 'Invalid Password')
                              ]),
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(

                                label: Text('password'),
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
                            if(validLicenceType)
                              Text(
                                'Please choose a Licence Type',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),),
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
                                          print("check Box1"+value.toString());


                                           if(checkBox2==true){
                                            setState(() {
                                              checkBox1=!checkBox1;
                                              checkBox2=!checkBox2;
                                            });}
                                          else{
                                            setState(() {
                                              checkBox1=!checkBox1;
                                            });
                                          }

                                        }),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Full Time Contract",style: TextStyle(fontSize: 10),),
                                        Checkbox(value: checkBox2, onChanged: (value){
                                          print("check Box2"+value.toString());

                                           if(checkBox1==true){
                                            setState(() {
                                              checkBox1=!checkBox1;
                                              checkBox2=!checkBox2;
                                            });}
                                           else{
                                             setState(() {
                                               checkBox2=!checkBox2;

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
                            if(validContratType)
                              Text(
                                'Please choose a Licence Type',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),),

                            SizedBox(height: 40,),
                            GestureDetector(
                              onTap: (){
                                if(checkBox1==false && checkBox2 == false){
                                  setState(() {
                                    validContratType=true;
                                  });
                                }else {
                                  setState(() {
                                    validContratType=false;
                                  });
                                }
                                if(checkBox1) {
                                  setState(() {
                                    contract="seasonal";
                                  });
                                }
                                if(checkBox2) {
                                  setState(() {
                                    contract="Full Time Contract";
                                  });
                                }
                                if(_selectedItem==""){
                                  setState(() {
                                    validLicenceType=true;
                                  });
                                }
                                if(_selectedItem!=""){
                                  setState(() {
                                    validLicenceType=false;
                                  });
                                }
                                if(_formKey.currentState!.validate()){

                                  if(!validLicenceType && !validContratType)
                                    if(_image==null){
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   SnackBar(
                                      //     content: Text("Please choose a profile picture"),
                                      //     duration: Duration(seconds: 5),
                                      //   ),
                                      // );
                                      // Navigator.pop(context);
                                      Get.to(AddDriverImagesScreen(
                                          record:DriverModel(
                                              driverImage: "",
                                              firstName: controller.firstNameController.text.capitalize.toString(),
                                              lastName: controller.lastNameController.text.capitalize.toString(),
                                              birthDate: controller.birthDateController.text,
                                              identityNumber:int.tryParse(controller.identityNumberController.text) ?? 0,
                                              identityCardImageFace1: "",
                                              identityCardImageFace2: "",
                                              phoneNumber: int.tryParse(controller.phoneNumberController.text) ?? 0,
                                              licenceType: _selectedItem,
                                              licenceImageFace1: "",
                                              licenceImageFace2: "",
                                              email: controller.emailController.text,
                                              contractType: contract,
                                              password: controller.passwordController.text
                                          )
                                      ));
                                    }
                                  else
                                    Get.to(AddDriverImagesScreen(
                                    record:DriverModel(
                                        driverImage: _image!.path,
                                        firstName: controller.firstNameController.text.capitalize.toString(),
                                        lastName: controller.lastNameController.text.capitalize.toString(),
                                        birthDate: controller.birthDateController.text,
                                        identityNumber:int.tryParse(controller.identityNumberController.text) ?? 0,
                                        identityCardImageFace1: "",
                                        identityCardImageFace2: "",
                                    phoneNumber: int.tryParse(controller.phoneNumberController.text) ?? 0,
                                        licenceType: _selectedItem,
                                        licenceImageFace1: "",
                                        licenceImageFace2: "",
                                    email: controller.emailController.text,
                                    contractType: contract,
                                    password: controller.passwordController.text
                                    )
                                    ));
                                }
                                // uploadFiles().then((value) => Get.back());
                                // Get.to(()=>AddDriverImagesScreen());

                                // controller.onInit();
                                },
                              child: Center(
                                child: Container(
                                  width: 120,
                                  height: 30,
                                  child: Center(child: Text('Next',style: TextStyle(color: Colors.white),)),
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
  Widget imageProfile(){
     return Stack(
       children: <Widget>[
         Center(
           child: CircleAvatar(
             backgroundColor: Colors.white10,
             radius: 35.0,
             child:_image == null
                 ? Image(image: AssetImage('assets/images/Exclude.png'),fit: BoxFit.fill,width: 70,)
                   :ClipOval(child: Image.file(_image!,width:70,fit: BoxFit.cover,))
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
                 onTap:() {
                   getImageFromGallery();
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
         driverImageName =pickedFile!.name;
         _image = File(pickedFile!.path);
       } else {
         print('No image selected.');
       }
     });
     Navigator.pop(context);
   }
   Future getImageFromGallery() async {
     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
     setState(() {
       if (pickedFile != null) {
         driverImageName =pickedFile.name;
         _image = File(pickedFile.path);
       } else {
         print('No image selected.');
       }
     });
     Navigator.pop(context);
   }


  Future<void> uploadFiles() async {
    final driverImagePath = 'drivers/${driverImageName}';
    final identityImagePath = 'drivers/${identityImageName}';
    final licenceImagePath = 'drivers/${licenceImageName}';

    final refDriver = FirebaseStorage.instance.ref(driverImagePath);
    final refIdentity = FirebaseStorage.instance.ref(identityImagePath);
    final refLicence = FirebaseStorage.instance.ref(licenceImagePath);

    final driverUploadTask = refDriver.putFile(_image!);
    final identityUploadTask = refIdentity.putFile(identityImage!);
    final licenceUploadTask = refLicence.putFile(licenceImage!);

    final driverSnapshot = await driverUploadTask.whenComplete(() => {});
    final identitySnapshot = await identityUploadTask.whenComplete(() => {});
    final licenceSnapshot = await licenceUploadTask.whenComplete(() => {});


      final driverDownloadURL = await driverSnapshot.ref.getDownloadURL();
      final identityDownloadURL = await identitySnapshot.ref.getDownloadURL();
      final licenceDownloadURL = await licenceSnapshot.ref.getDownloadURL();


    controller.add_driver(
        DriverModel(
            driverImage: driverDownloadURL,
            firstName: controller.firstNameController.text.capitalize.toString(),
            lastName: controller.lastNameController.text.capitalize.toString(),
            birthDate: controller.birthDateController.text,
            identityNumber:int.tryParse(controller.identityNumberController.text) ?? 0,
            identityCardImageFace1: "",
            identityCardImageFace2: "",
            phoneNumber: int.tryParse(controller.phoneNumberController.text) ?? 0,
            licenceType: _selectedItem,
            licenceImageFace1: "",
            licenceImageFace2: "",
            email: controller.emailController.text,
            contractType: contract,
            password: controller.passwordController.text
        )
    );

  }

}
