import 'package:admin_citygo/utils/common_widget.dart';
import 'package:admin_citygo/utils/images_strings.dart';
import 'package:admin_citygo/utils/text_strings.dart';
import 'package:admin_citygo/view/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width =  MediaQuery.of(context).size.width;
    return Scaffold(
      body: ImageContainer(
        width: width,
        border: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
        margin: EdgeInsets.only(
          left: 60,
         top: 80
            ),
        child: Center(
                child:Padding(
                  padding: const EdgeInsets.only(
                    top: 200,
                      left:40.0,
                    bottom: 200
                  ),
                  child: Column(
                    children: [
                      Text(
                        tDriveInSecurity,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 55,
                            fontFamily: "Georgia"
                        ),
                      ),
                      SizedBox(height: 30,),
                      SizedBox(
                        width: width*0.7,
                        child: OutlinedButton(
                          onPressed: (){
                            Get.offAll(()=>LogInScreen());
                          },
                          child: Text(tGetStart,style: TextStyle(color: Colors.white,fontSize: 15),),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xFF1590CF)
                          )
                        ),
                      )
                    ],
                  ),
                ),
      )
    )
    );
  }
}
