import 'package:admin_citygo/controllers/home/home_controller.dart';
import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/view/drivers_list/add_driver.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/drivers_list/driverDetails.dart';
import 'package:admin_citygo/view/drivers_list/edit_driver.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/driver_list/drivers_controller.dart';


class DriversListScreen extends StatefulWidget {
  const DriversListScreen({Key? key}) : super(key: key);

  @override
  State<DriversListScreen> createState() => _DriversListScreenState();
}

class _DriversListScreenState extends State<DriversListScreen> {

  // DriversController DriversController = Get.put(DriversController());
  LoginController loginController =Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());


  void initState() {
    // TODO: implement initState
    super.initState();
    driversController.fetchDrivers();
    print(driversController.driverEmailList);
  }

  DriversController driversController = Get.put(DriversController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset:false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDriverScreen()));
            print("add");
          },
        ),
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
            child: Text("Drivers List",style: TextStyle(
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
                    child:Obx(()=> Column(
                      children: [
                        TextFormField(
                          onChanged: (value)=>driversController.updateList(value),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            hintText:"search by name , identity card",
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                          // style:,
                        ),
                        SizedBox(height: 30,),
                        if(driversController.isLoading.value)
                          Center(child: CircularProgressIndicator(),)
                        else
                          Center(
                          child:
                              SingleChildScrollView(
                            child: Container(
                                height: MediaQuery.of(context).size.height*0.6,
                                width: MediaQuery.of(context).size.width*0.9,
                                child:
                                RefreshIndicator(
                                  onRefresh: (){
                                    driversController.fetchDrivers();
                                    return Future.delayed(
                                      Duration(seconds: 1)
                                    );
                                  },
                                  child: ListView.builder(
                                    itemCount: driversController.filteredList.length,
                                    itemBuilder: (BuildContext context, int index) {

                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height:50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Colors.white
                                              ),
                                              child: Column(
                                                children: [
                                                  if(driversController.filteredList[index].driverImage != '')
                                                    Center(
                                                        child:ClipOval(
                                                          child:Image(
                                                              image: NetworkImage(
                                                                  driversController.filteredList[index].driverImage
                                                              )
                                                              ,width:50,height:50,fit: BoxFit.cover),
                                                        )
                                                    )
                                                  else Center(
                                                      child:ClipOval(child:Image(image: AssetImage('assets/images/Exclude.png')
                                                          ,width:50,height:50,fit: BoxFit.cover))
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            GestureDetector(
                                              onTap: (){
                                                Get.to(()=>DriverDetails(record: driversController.filteredList[index]));
                                              },
                                              child: Container(
                                                width:MediaQuery.of(context).size.width*.55,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(width: 15,),
                                                    Text(driversController.filteredList[index].firstName+ " " + driversController.filteredList[index].lastName,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: "Georgia"
                                                      ),
                                                    ),
                                                    SizedBox(width: 60 ,),
                                                    Container(
                                                      width:MediaQuery.of(context).size.width*.45,                                                          height: 1,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          color: Colors.white
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                driversController.fetchDrivers();
                                                Get.to(()=>EditDriverScreen(records: driversController.filteredList[index],));
                                              },
                                              child: Container(
                                                height:30,
                                                width:30,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/icons/edit.png"
                                                        )
                                                    )
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap:  () {
                                                showModalBottomSheet<void>(
                                                  backgroundColor: Colors.blue,
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return Stack(
                                                      children: [
                                                        Opacity(
                                                          opacity: .8,
                                                          child: Container(
                                                            height: 250,
                                                            decoration: BoxDecoration(
                                                                color: Colors.blue,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius.circular(40),
                                                                    topRight: Radius.circular(40)
                                                                )
                                                            ),
                                                            child: Center(
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: <Widget>[
                                                                  Text(driversController.filteredList[index].firstName+" "+driversController.filteredList[index].lastName,
                                                                    style: TextStyle(
                                                                        fontSize: 30,
                                                                        color: Colors.white,
                                                                        fontFamily: "Georgia"
                                                                    ),),
                                                                  SizedBox(height: 10,),
                                                                  SizedBox(
                                                                    width: 200,
                                                                    child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          elevation: 20,
                                                                          shadowColor: Colors.blue[700],
                                                                          primary: Color(0xDADADA).withOpacity(0.69),
                                                                          onPrimary: Colors.white
                                                                      ),
                                                                      child: const Text('Delete',style: TextStyle(fontFamily: "Georgia",fontSize: 20),),
                                                                      onPressed: (){
                                                                        if(driversController.filteredList[index].driverImage!="")FirebaseStorage.instance.refFromURL(driversController.filteredList[index].driverImage).delete();
                                                                        FirebaseStorage.instance.refFromURL(driversController.filteredList[index].identityCardImageFace1).delete();
                                                                        FirebaseStorage.instance.refFromURL(driversController.filteredList[index].identityCardImageFace2).delete();
                                                                        FirebaseStorage.instance.refFromURL(driversController.filteredList[index].licenceImageFace1).delete();
                                                                        FirebaseStorage.instance.refFromURL(driversController.filteredList[index].licenceImageFace2).delete();
                                                                        if(driversController.filteredList[index].moreImage1!="")FirebaseStorage.instance.refFromURL(driversController.filteredList[index].moreImage1!).delete();
                                                                        if(driversController.filteredList[index].moreImage2!="")FirebaseStorage.instance.refFromURL(driversController.filteredList[index].moreImage2!).delete();
                                                                        if(driversController.filteredList[index].moreImage3!="")FirebaseStorage.instance.refFromURL(driversController.filteredList[index].moreImage3!).delete();
                                                                        driversController.delete_driver(driversController.filteredList[index].id!);
                                                                        driversController.fetchDrivers();
                                                                        Navigator.pop(context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 15,),
                                                                  SizedBox(
                                                                    width: 200,
                                                                    child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          elevation: 20,
                                                                          shadowColor: Colors.blue[700],
                                                                          primary: Color(0x0F5CA0).withOpacity(0.8),
                                                                          onPrimary: Colors.white
                                                                      ),
                                                                      child: const Text('Cancel',style: TextStyle(fontFamily: "Georgia",fontSize: 20)),
                                                                      onPressed: () => Navigator.pop(context),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                            top:0,
                                                            left:MediaQuery.of(context).size.width*0.45,
                                                            child: Transform.translate(
                                                              offset: Offset(0,-35),
                                                              child: Container(
                                                                width: 60,
                                                                height: 70,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                                                    color: Colors.white.withOpacity(0.4)
                                                                ),
                                                                child: driversController.filteredList[index].driverImage!=""
                                                                    ?ClipOval(
                                                                  child: Image.network(
                                                                    driversController.filteredList[index].driverImage,
                                                                    fit:BoxFit.cover,
                                                                  ),
                                                                ):
                                                                Image.asset(
                                                                  'assets/images/Exclude.png',
                                                                  fit:BoxFit.fill,
                                                                ),
                                                              ),
                                                            )
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                height:30,
                                                width:30,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/icons/delete.png"
                                                        )
                                                    )
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )

                            ),
                          ),
                        )
                      ],
                    )),
                  ),
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
