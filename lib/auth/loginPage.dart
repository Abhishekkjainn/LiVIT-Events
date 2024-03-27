import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:livit/eventModal/authController.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthController controller = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.maxFinite,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'appBarTitleIcon',
                      child: Icon(
                        CupertinoIcons.location_circle,
                        color: Colors.redAccent,
                        size: 50,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'LiVIT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Lottie.asset('assets/images/login.json',
                    height: 300, width: 300),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Discover, Connect and Elevate your Campus Life at VIT Vellore',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 132, 132, 132),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      controller.signinWithGoogle(context);
                    },
                    child: Container(
                      height: 60,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Lottie.asset('assets/images/GOOGLE.json',
                              height: 40, width: 40, repeat: false),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              'Get Started with Google',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
