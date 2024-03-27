import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livit/announcements/uploadAnnouncement.dart';
import 'package:livit/auth/loginPage.dart';
import 'package:livit/eventModal/authController.dart';
import 'package:livit/mainScreen/blogs.dart';
import 'package:livit/mainScreen/chats.dart';
import 'package:livit/postevent.dart';
import 'package:livit/screens/eventsPage.dart';
import 'package:livit/screens/reqAccess.dart';
import 'package:livit/screens/searchPage.dart';
import 'package:livit/screens/uploadedEventsandData.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:livit/announcements/announcement.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthController controller = Get.put(AuthController());
  @override
  void initState() {
    controller.checkAccessForClubs(context);
    // TODO: implement initState
    super.initState();
  }

  final List homeScreens = [
    EventsPage(),
    const Announcements(),
    const Chats(),
    const Blogs()
  ];
  int mainIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        drawer: GetBuilder<AuthController>(
          builder: (controller) {
            return drawerHome(context);
          },
        ),
        drawerEnableOpenDragGesture: true,
        appBar: appBarmain(),
        body: homeScreens[mainIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black.withOpacity(0.5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GNav(
                      onTabChange: (value) {
                        setState(() {
                          mainIndex = value;
                        });
                      },
                      haptic: true,
                      tabBorderRadius: 40,
                      tabActiveBorder:
                          Border.all(color: Colors.redAccent, width: 2),
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 200),
                      gap: 4,
                      color: Colors.grey,
                      activeColor: Colors.white.withOpacity(1),
                      iconSize: 24,
                      tabBackgroundColor: Colors.redAccent.withOpacity(0.1),
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      tabs: [
                        GButton(
                          icon: CupertinoIcons.sparkles,
                          text: 'Events',
                          textSize: 12,
                        ),
                        GButton(
                          icon: CupertinoIcons.bell_circle_fill,
                          text: 'Announcements',
                          textSize: 12,
                        ),
                        GButton(
                          icon: CupertinoIcons.chat_bubble_2_fill,
                          text: 'Chat',
                        ),
                        GButton(
                          icon: Icons.message_rounded,
                          text: 'Blogs',
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Drawer drawerHome(context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            introContainer(),
            (controller.access) ? uploadedEvents() : Container(),
            GetBuilder<AuthController>(
              builder: (controller) {
                return (controller.access)
                    ? postEventButton()
                    : RequestClubAccessButton();
              },
            ),
            (controller.access)
                ? GestureDetector(
                    onTap: () {
                      Get.to(() => UploadAnnouncements(),
                          transition: Transition.rightToLeft);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 0, bottom: 20),
                      child: Container(
                        height: 60,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.speaker_1_fill,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Add Announcement',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            logoutButton(context),
          ],
        ),
      ),
    );
  }

  GestureDetector uploadedEvents() {
    return GestureDetector(
      onTap: () {
        Get.to(() => UploadedData(), transition: Transition.rightToLeft);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          height: 60,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.info_circle_fill,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Uploaded Events',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
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
          Get.offAll(() => Login());
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

  Padding RequestClubAccessButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
      child: GestureDetector(
        onTap: () async {
          bool go = false;

          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('ClubAccessRequests')
              .get();

          if (querySnapshot.docs.length == 0) {
            Get.to(() => RequestClubAccessPage(),
                transition: Transition.rightToLeft);
          } else {
            for (QueryDocumentSnapshot doc in querySnapshot.docs) {
              if (controller.userEmail == doc['vitemail']) {
                if (doc['reviewed'] == false) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message:
                          "One Request is Already Pending..\nPlease Wait till it gets Approved.",
                    ),
                  );
                  print('search 2');
                  go = false;
                }
                if (doc['reviewed'] == true && doc['accepted'] == false) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message:
                          "Your Request was Rejected\nContact Team for Details",
                    ),
                  );
                }
                break;
              }

              if (controller.userEmail != doc['vitemail']) {
                go = true;
                print('search3');
              }
            }
            if (go == true) {
              Get.to(() => RequestClubAccessPage(),
                  transition: Transition.rightToLeft);
              print('search4');
            }
          }
          ;
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
                'Request Club Access',
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
                ),
                (controller.access)
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Row(children: [
                          const Icon(
                            CupertinoIcons.checkmark_alt_circle_fill,
                            color: Colors.greenAccent,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 180,
                            child: Text(
                              'Club Access Granted',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ]),
                      )
                    : Container(),
                (controller.access)
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Row(children: [
                          const Icon(
                            CupertinoIcons.building_2_fill,
                            color: Colors.greenAccent,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 180,
                            child: Text(
                              'Club - ${controller.clubname}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ]),
                      )
                    : Container(),
                (controller.access)
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Row(children: [
                          const Icon(
                            CupertinoIcons.person_2_fill,
                            color: Colors.greenAccent,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 180,
                            child: Text(
                              'Board - ${controller.boardposition}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ]),
                      )
                    : Container(),
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
