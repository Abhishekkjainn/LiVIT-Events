import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:livit/auth/loginPage.dart';
import 'package:livit/eventModal/authController.dart';
import 'package:livit/postevent.dart';
import 'package:livit/screens/eventsPage.dart';
import 'package:livit/screens/searchPage.dart';

class Home extends StatelessWidget {
  Home({super.key});
  authController controller = Get.put(authController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 16, 16, 16),
          drawer: drawerHome(),
          drawerEnableOpenDragGesture: true,
          drawerScrimColor: Color.fromARGB(255, 0, 0, 0),
          appBar: appBarmain(),
          body: EventsPage()),
    );
  }

  Drawer drawerHome() {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              onTap: () async {
                await controller.logoutWithGoogle();
                Get.off(() => Login());
              },
              child: Container(
                width: double.maxFinite,
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Log Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
            child: GestureDetector(
              onTap: () {
                Get.back();
                Get.to(() => PostEvent(), transition: Transition.rightToLeft);
              },
              child: Container(
                width: double.maxFinite,
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.paperplane_fill,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Post Events',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar appBarmain() {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 179, 179, 179),
        fill: 1,
      ),
      title: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
                color: const Color.fromARGB(0, 255, 255, 255), width: 2)),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'appBarTitleIcon',
                child: Icon(
                  CupertinoIcons.location_circle,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'VIT Vellore',
                style: TextStyle(
                    color: Color.fromARGB(255, 201, 201, 201),
                    fontSize: 14,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => SearchPage(), transition: Transition.upToDown);
            },
            icon: Icon(
              CupertinoIcons.search_circle_fill,
              color: Colors.grey,
              size: 30,
            ))
      ],
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
    );
  }
}
