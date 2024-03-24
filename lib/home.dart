import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livit/auth/loginPage.dart';
import 'package:livit/eventModal/authController.dart';
import 'package:livit/postevent.dart';
import 'package:livit/screens/eventsPage.dart';
import 'package:livit/screens/searchPage.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 16, 16, 16),
          drawer: drawerHome(context),
          drawerEnableOpenDragGesture: true,
          // drawerScrimColor: Color.fromARGB(255, 0, 0, 0),
          appBar: appBarmain(),
          body: EventsPage()),
    );
  }

  Drawer drawerHome(context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            introContainer(),
            postEventButton(),
            logoutButton(context),
          ],
        ),
      ),
    );
  }

  Padding postEventButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
      child: GestureDetector(
        onTap: () {
          Get.back();
          Get.to(() => const PostEvent(), transition: Transition.rightToLeft);
        },
        child: Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: const Row(
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
    );
  }

  Padding logoutButton(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () async {
          await controller.logoutWithGoogle(context);
          Get.off(() => const Login());
        },
        child: Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.redAccent, borderRadius: BorderRadius.circular(20)),
          child: const Row(
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
    );
  }

  Padding introContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
      child: IntrinsicHeight(
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 41, 41, 41),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    children: [
                      // Icon(
                      //   CupertinoIcons.person_alt_circle_fill,
                      //   color: Colors.redAccent,
                      // ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            controller.image!,
                            height: 20,
                            width: 20,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Name - ${controller.username!}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.envelope_circle_fill,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 180,
                        child: Text(
                          'Email - ${controller.userEmail!}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.book_circle_fill,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 180,
                        child: Text(
                          'Reg. No - ${controller.regno!}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBarmain() {
    return AppBar(
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 179, 179, 179),
        fill: 1,
      ),
      title: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
                color: const Color.fromARGB(0, 255, 255, 255), width: 2)),
        child: const Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
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
              Get.to(() => const SearchPage(), transition: Transition.upToDown);
            },
            icon: const Icon(
              CupertinoIcons.search_circle_fill,
              color: Colors.grey,
              size: 30,
            ))
      ],
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
    );
  }
}
