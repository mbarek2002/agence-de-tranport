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
    Size size =  MediaQuery.of(context).size;
    return Scaffold(
      body: ImageContainer(
        width: size.width,
        // border: BorderRadius.only(
        //       // topRight: Radius.circular(40),
        //       topLeft: Radius.circular(40),
        //     ),
        // margin: EdgeInsets.only(
        //   left: size.width*.15,
        //  top: size.height*.1
        //     ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              Text(
                tDriveInSecurity,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 55,
                    fontFamily: "Georgia"
                ),
              ),
              // SizedBox(height: 30,),
              Spacer(flex: 4,),
              SizedBox(
                width: size.width*0.7,
                child: OutlinedButton(
                  onPressed: (){
                    Get.offAll(()=>LogInScreen());
                  },
                  child: Text(tGetStart,style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.bold),),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white
                  )
                ),
              ),
              Spacer(flex: 3,),

            ],
          ),
        )
    )
    );
  }
}
