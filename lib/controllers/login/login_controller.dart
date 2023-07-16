import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginController extends GetxController{
  static LoginController get instance =>Get.find();
  RxBool test=false.obs ;
  RxString message = ''.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void loginAdmin(String email,String password,BuildContext context)async{
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password).then((value) => Get.offAll(HomeScreen()));
        Navigator.pop(context);
      }on FirebaseAuthException catch(e){
        if(e.code.toLowerCase() == 'invalid-email'){
          Navigator.pop(context);
          message='No User found for that email'.obs;
          // wrongMessage(context,message.toString());
          showDialog(
              context: context,
              builder: (context){
                return const  AlertDialog(
                  title: Text('No User found for that email',style: TextStyle(fontSize: 20),),
                );
              }
          );
        }else if(e.code.toLowerCase() == 'wrong-password'){
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context){
                return const  AlertDialog(
                  title: Text("Wrong password buddy",style: TextStyle(fontSize: 20),),
                );
              }
          );

        }
      }
      // Navigator.pop(context);
  }

  void signAdminOut(){
    FirebaseAuth.instance.signOut();
  }

}