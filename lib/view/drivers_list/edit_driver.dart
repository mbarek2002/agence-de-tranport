import 'dart:io';
import 'package:admin_citygo/controllers/driver_list/drivers_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/models/driver_model.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/drivers_list/edit_driver_images.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wc_form_validators/wc_form_validators.dart';


class EditDriverScreen extends StatefulWidget {
   EditDriverScreen({Key? key,required this.records}) : super(key: key);
   DriverModel records;
  @override
  State<EditDriverScreen> createState() => _EditDriverScreenState();
}

class _EditDriverScreenState extends State<EditDriverScreen> {
  String _selectedItem = '';
  List<String> _dropdownItems = ['AA', 'A', 'B','B+E','C','C+E','D','D1','D+E','G'+'H'];

  bool checkBox1 = false;
  bool checkBox2 = false;

  String? _image;
  final picker = ImagePicker();
  String driverImageName='';

  String contract='';
  String driverDownloadURL="";
  final _formKey = GlobalKey<FormState>();


  LoginController loginController =Get.put(LoginController());

  DriversController controller =DriversController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedItem = widget.records.licenceType;
    driverDownloadURL=widget.records.driverImage;
    controller.firstNameController.text= widget.records.firstName;
    controller.lastNameController.text= widget.records.lastName;
    controller.birthDateController.text= widget.records.birthDate;
    controller.identityNumberController.text= widget.records.identityNumber.toString();
    controller.phoneNumberController.text= widget.records.phoneNumber.toString();
    print(widget.records.phoneNumber.toString());
    controller.emailController.text= widget.records.email;
    controller.passwordController.text= widget.records.password;
    if(widget.records.contractType=="Full Time Contract") checkBox2=true;
        else checkBox1=true;

  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        controller.birthDateController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
      });
    }
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
            child: Text("Edit driver",style: TextStyle(
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
                            Text('Edit a driver ',style: TextStyle(
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
                            // TextFormField(
                            //   keyboardType: TextInputType.datetime,
                            //   controller: controller.birthDateController,
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please entre birth date';
                            //     }
                            //     return null;
                            //   },
                            //   style: TextStyle(color: Colors.black),
                            //   decoration: InputDecoration(
                            //     label: Text('Birth date'),
                            //     labelStyle: TextStyle(color: Color(0xFF373737),fontSize: 10),
                            //     enabledBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.black,width: 2),
                            //     ),
                            //     focusedBorder: UnderlineInputBorder(
                            //       borderSide: BorderSide(color: Colors.black,width: 2),
                            //     ),
                            //   ),
                            // ),
                            TextFormField(
                              controller: controller.birthDateController,
                              validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please entre birth date';
                                  }
                                  return null;
                                },
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              // decoration: InputDecoration(
                              //   labelText: "Date",
                              //   hintText: "Select a date",
                              //   prefixIcon: Icon(Icons.calendar_today),
                              //   border: OutlineInputBorder(),
                              // ),
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
                                return null;
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                // suffixIcon: IconButton(
                                //   onPressed: (){
                                //     getIdentityImage();
                                //   },
                                //   icon: Icon(Icons.file_download),
                                // ),
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
                              hint: Text(_selectedItem,style:TextStyle(color: Colors.black,fontSize: 18)),
                              elevation: 16,
                              // icon: IconButton(
                              //   icon: Icon(Icons.file_download),
                              //   onPressed: (){
                              //     getLicenceImage();
                              //   },
                              // ),
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

                            SizedBox(height: 40,),
                            GestureDetector(
                              onTap: (){
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
                                if(_image!=null && _formKey.currentState!.validate()){

                                  print(controller.passwordController.text);
                                  Get.to(()=>EditDriverImagesScreen(record:
                                DriverModel(
                                  id:widget.records.id,
                                  driverImage:_image!,
                                  firstName:controller.firstNameController.text,
                                  lastName: controller.lastNameController.text,
                                  birthDate: controller.birthDateController.text,
                                  identityNumber: int.tryParse(controller.identityNumberController.text) ?? 0,
                                  phoneNumber: int.parse(controller.phoneNumberController.text),
                                  licenceType: _selectedItem,
                                  contractType: contract,
                                  email: controller.emailController.text,
                                  password:controller.passwordController.text,
                                  identityCardImageFace1: widget.records.identityCardImageFace1,
                                  identityCardImageFace2: widget.records.identityCardImageFace2,
                                  licenceImageFace1: widget.records.licenceImageFace1,
                                  licenceImageFace2: widget.records.licenceImageFace2,
                                  moreImage1: widget.records.moreImage1,
                                  moreImage2: widget.records.moreImage2,
                                  moreImage3: widget.records.moreImage3,
                                )
                                ));
                                FirebaseStorage.instance.refFromURL(driverDownloadURL).delete();
                                }
                                else if(_image==null && _formKey.currentState!.validate()){
                                  Get.to(()=>EditDriverImagesScreen(record:
                                  DriverModel(
                                    id:widget.records.id,
                                    driverImage:driverDownloadURL,
                                    firstName:controller.firstNameController.text,
                                    lastName: controller.lastNameController.text,
                                    birthDate: controller.birthDateController.text,
                                    identityNumber: int.tryParse(controller.identityNumberController.text) ?? 0,
                                    phoneNumber: int.parse(controller.phoneNumberController.text),
                                    licenceType: _selectedItem,
                                    contractType: contract,
                                    email: controller.emailController.text,
                                    password:controller.passwordController.text,
                                    identityCardImageFace1: widget.records.identityCardImageFace1,
                                    identityCardImageFace2: widget.records.identityCardImageFace2,
                                    licenceImageFace1: widget.records.licenceImageFace1,
                                    licenceImageFace2: widget.records.licenceImageFace2,
                                    moreImage1: widget.records.moreImage1,
                                    moreImage2: widget.records.moreImage2,
                                    moreImage3: widget.records.moreImage3,

                                  )
                                  ));
                                };


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
        if(driverDownloadURL=='')
           Center(

            child:CircleAvatar(
                backgroundColor: Colors.white10,
                radius: 35.0,
                child:Image(image: AssetImage('assets/images/Exclude.png')
          ,width:70,fit: BoxFit.cover))
          )

        else Center(
          child: CircleAvatar(
              backgroundColor: Colors.white10,
              radius: 35.0,
              child:_image == null
            ?         ClipOval(child: Image.network(driverDownloadURL,fit: BoxFit.cover,width: 70))
                  :ClipOval(child: Image.file(File(_image!),width:70,fit: BoxFit.cover,))
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
                onTap: (){
                  getImage();
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
                onTap:(){
                  getImageFromGallery();
                Navigator.pop(context);
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
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        driverImageName =pickedFile.name;
        _image = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        driverImageName =pickedFile.name;
        _image = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

}
