import 'package:admin_citygo/controllers/login/login_controller.dart';
import 'package:admin_citygo/utils/text_strings.dart';
import 'package:admin_citygo/view/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/common_widget.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final controller  = Get.put(LoginController());
  Color color=Colors.transparent;
  @override
  var obscureText = true;
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: ImageContainer(
          height:height,
          width:width,
          margin: EdgeInsets.only(
                left: 60,
                top: 80
            ),
          border: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
            ),
            child: ListView(
                children: [
                  const Padding(
                    padding:  EdgeInsets.only(
                        top: 8
                    ),
                    child: Center(
                      child: Text(
                        tWelcome,
                        style: TextStyle(color: Colors.white,fontSize: 55),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Center(child: Text(tLogin,style: TextStyle(color: Colors.white,fontSize: 30),)),
                  SizedBox(height: 32,),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left:40.0,
                                right:40.0,
                                bottom:20.0,
                            ),
                            child: TextFormField(
                              onTap: (){
                                setState(() {
                                  color=Colors.black.withOpacity(0.3);
                                });
                              },

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please entre your Username';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              controller: controller.emailController,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(color: Color(0xFF090909),fontSize: 24),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white), // White bottom border color
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white), // White bottom border color
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(
                              right:40,
                              left: 40,
                              bottom: 35
                            ),
                            child: TextFormField(
                              onTap: (){
                                setState(() {
                                  color=Colors.black.withOpacity(0.3);
                                });
                              },
                              style: TextStyle(color: Colors.white),
                              obscureText: obscureText,
                              controller: controller.passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: obscureText ?
                                  const Icon(Icons.visibility_off,color: Colors.black,):
                                      const Icon(Icons.visibility,color: Colors.black,),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(color:Color(0xFF090909),fontSize: 24),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width*0.5,
                            child: OutlinedButton(
                                onPressed: (){
                                  if (_formKey.currentState!.validate()) {
                                    loginController.loginAdmin(controller.emailController.text.trim(), controller.passwordController.text.trim(),context);
                                  }
                                },
                                child: Text(tLogin,style: TextStyle(color: Colors.white,fontSize: 15),),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Color(0xFF1590CF)
                                )
                            ),
                          )
                        ],
                      )
                  )

                ],
              ),
          ),
      ),
    );
  }
}
