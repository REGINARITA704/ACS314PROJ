import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      // backgroundColor: Colors.white,
      // title: Text(
      // "login screen",
      // style: TextStyle(color: Colors.white, fontSize: 20),

      //  centerTitle: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/Jumia-Logo-2012-500x281.png'),
              Text(
                "login screen",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "enter username",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "use email or phone number",
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: SizedBox(height: 30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text(
                    "Enter password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(height: 30),

              //MaterialButton(
              //onPressed: () {},
              //child: Text(
              //"login",
              //style: TextStyle(color:Colors.white,fontSize: 20),),
              //color: Colors.white,
              GestureDetector(
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "login",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onTap: () {
                  Get.offAndToNamed("/homescreen");
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/signup");
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 90, 20, 54),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),

                  Text("Forgot password?"),
                  SizedBox(width: 8),
                  Text(
                    "Reset",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 90, 20, 54),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
