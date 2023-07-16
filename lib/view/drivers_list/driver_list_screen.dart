import 'package:admin_citygo/view/drivers_list/add_driver.dart';
import 'package:admin_citygo/controllers/driver_list/drivers_list_controller.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriversListScreen extends StatefulWidget {
  const DriversListScreen({Key? key}) : super(key: key);

  @override
  State<DriversListScreen> createState() => _DriversListScreenState();
}

class _DriversListScreenState extends State<DriversListScreen> {

  DriversListController driversListController = Get.put(DriversListController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
        onPressed: (){
          // Get.to(()=>AddDriverScreen);
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
                  // TopWidget(title: 'Notification New driver'),
                  SizedBox(height: 35,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Column(
                      children: [
                          TextFormField(
                            // style:,
                          ),
                        SizedBox(height: 30,),
                        Center(
                          child: SingleChildScrollView(
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.68,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: driversListController.driversList.snapshots(),
                                  builder: (context,AsyncSnapshot snapshots){
                                    if(snapshots.connectionState == ConnectionState.waiting){
                                      return Center(
                                        child: CircularProgressIndicator(color: Colors.green,),
                                      );
                                    }
                                    if(!snapshots.hasData){
                                      print('no data ');
                                    }
                                    // else{
                                    //   return Center(child: CircularProgressIndicator(color: Colors.red,),);}
                                    return ListView.builder(
                                      itemCount: snapshots.data!.docs.length,
                                      itemBuilder: (BuildContext context, int index) {

                                        final DocumentSnapshot records = snapshots.data!.docs[index];
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
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(records['driverImage'])
                                                    )
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Row(
                                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  //   children: [
                                                  SizedBox(width: 15,),
                                                  Text(records['firstName']+ " " + records['lastName'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: "Georgia"
                                                    ),
                                                  ),
                                                  SizedBox(width: 60 ,),
                                                  //
                                                  //   ],
                                                  // ),
                                                  Container(
                                                    width:MediaQuery.of(context).size.width*.45,                                                          height: 1,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: Colors.white
                                                    ),
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  print("edit");
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
                                                    backgroundColor: Colors.transparent,
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
                                                                    Text(records['firstName']+" "+records['lastName'],
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
                                                                          driversListController.delete_driver(records.id);
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
                                                                      image: DecorationImage(
                                                                          fit:BoxFit.fill,
                                                                          image:NetworkImage(
                                                                            records['driverImage'],
                                                                          )
                                                                      )

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
                                    );
                                  }
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height* .04,
              // right:MediaQuery.of(context).size.width*0.5 ,
              // width: MediaQuery.of(context).size.width,
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
            ),
          ],
        )


    );
  }
}
