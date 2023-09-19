
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginController extends GetxController{
  static LoginController get instance =>Get.find();
  RxBool test=false.obs ;
  RxString message = ''.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  CollectionReference admins = FirebaseFirestore.instance.collection("admins");

  RxBool isLoading=true.obs;
  // RxString adminImageUrl=''.obs;
  RxString idAdmin=''.obs;
  void getAdminImage(String email)async {
    try {
       // Future.delayed(Duration(seconds: 4));
      QuerySnapshot adminsData = await FirebaseFirestore.instance.collection(
          'admins').where("email", isEqualTo: email).get();

      for (var admin in adminsData.docs) {
        // print("------------------------------");
        // print(admin);
        // print("------------------------------");
        // adminImageUrl.value = admin['imageUrl'];
        idAdmin.value = admin.id;
      }
      isLoading.value = false;
    }catch(e){
      print(e.toString());
    }
  }

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
            email: email, password: password).then((value){
            emailController.text="";
            passwordController.text="";
            Get.offAll(()=>HomeScreen());
        }
        );
        // Navigator.pop(context);
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
        }
        else if(e.code.toLowerCase() == 'wrong-password'){
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
        else{
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context){
                return const  AlertDialog(
                  title: Text("Sorry,somethings went wrong,Please try again",style: TextStyle(fontSize: 20),),
                );
              }
          );
        }
      }
  }

  void signAdminOut(){
    FirebaseAuth.instance.signOut();
  }
}