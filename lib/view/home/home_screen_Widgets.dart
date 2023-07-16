import 'package:admin_citygo/controllers/notication_new_driver/notication_new_driver_controller.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NotificationNewDriverController notificationNewDriverController = Get.put(NotificationNewDriverController());

class TopWidget extends StatelessWidget {
  const TopWidget({
    super.key,
    required this.widget,
    required this.title,
  });

  final Widget widget;
  final String title;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              child: Text(title,style: TextStyle(
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
                    SizedBox(height: 80,),
                    widget,
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
              )
            ],
          ),


        );

  }
}



