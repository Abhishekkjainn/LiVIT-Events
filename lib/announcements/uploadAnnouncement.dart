import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:livit/eventModal/authController.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UploadAnnouncements extends StatefulWidget {
  UploadAnnouncements({super.key});

  @override
  State<UploadAnnouncements> createState() => _UploadAnnouncementsState();
}

class _UploadAnnouncementsState extends State<UploadAnnouncements> {
  TextEditingController headingController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController externallinkController = TextEditingController();

  AuthController controller = Get.find();

  String setColor = 'Colors.redAccent';
  int colorIndex = 0;
  List setColorList = [
    'Colors.yellowAccent',
    'Colors.redAccent',
    'Colors.blue',
    'Colors.greenAccent'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: announcementAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20, bottom: 5, top: 20),
              child: Text(
                'Enter Heading',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: headingController,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Register on VTOP',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.person_alt_circle_fill,
                      color: Colors.redAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 207, 207, 207),
                            width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 88, 88, 88), width: 2),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20, bottom: 5, top: 20),
              child: Text(
                'Enter Description',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: descriptionController,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.person_alt_circle_fill,
                      color: Colors.redAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 207, 207, 207),
                            width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 88, 88, 88), width: 2),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20, bottom: 5, top: 20),
              child: Text(
                'External Link',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: externallinkController,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'www.google.com',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.person_alt_circle_fill,
                      color: Colors.redAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 207, 207, 207),
                            width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 88, 88, 88), width: 2),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20, bottom: 5, top: 20),
              child: Text(
                'Choose Announcement Color',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 20),
              child: Container(
                width: double.maxFinite,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          colorIndex = 0;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: (colorIndex == 0)
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 4)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          colorIndex = 1;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: (colorIndex == 1)
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 4)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          colorIndex = 2;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: (colorIndex == 2)
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 4)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          colorIndex = 3;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: (colorIndex == 3)
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 4)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                CollectionReference collref =
                    FirebaseFirestore.instance.collection('announcements');
                try {
                  if (headingController.text == '') {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "Enter Your Club Name",
                      ),
                    );
                  }
                  if (descriptionController.text == '') {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "Please Enter your Board Position",
                      ),
                    );
                  }
                  if (externallinkController.text == '') {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message:
                            "Please Enter your Faculty Co-ordinator's Name",
                      ),
                    );
                  } else {
                    Get.defaultDialog(
                        barrierDismissible: false,
                        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                        titlePadding: const EdgeInsets.all(20),
                        title: 'Announcing your Message..',
                        titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        content: Lottie.asset('assets/images/uploading.json',
                            height: 80, width: 80, repeat: true));

                    await collref
                        .doc(
                            '${controller.userEmail}+${controller.getFormattedDate()}')
                        .set({
                      'Desc': descriptionController.text,
                      'clubname': controller.clubname,
                      'imagelink':
                          'https://media.istockphoto.com/id/1344512181/vector/icon-red-loudspeaker.jpg?s=612x612&w=0&k=20&c=MSi3Z2La8OYjSY-pr0bB6f33NOuUKAQ_LBUooLhLQsk=',
                      'heading': headingController.text,
                      'color': setColorList[colorIndex],
                      'datePosted': controller.getFormattedDate(),
                      'timePosted': controller.getFormattedTime()
                    });
                    Get.back();
                    Get.dialog(
                        barrierDismissible: true,
                        barrierColor: const Color.fromARGB(255, 21, 21, 21),
                        AlertDialog(
                          elevation: 20,
                          contentPadding: const EdgeInsets.all(0),
                          backgroundColor:
                              const Color.fromARGB(255, 51, 51, 51),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset('assets/images/doneanim.json',
                                  repeat: false, width: 250, height: 250),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: Text(
                                  'Announcement Update',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ));
                    await Future.delayed(const Duration(milliseconds: 5500));
                    Get.back();
                    Get.back();
                  }
                } catch (error) {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: 'Some Error Ocurred. Please Try Again Later.',
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 60, bottom: 40, right: 20, left: 20),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.speaker_2_fill,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Post Announcement',
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
            ),
          ],
        ),
      ),
    );
  }

  AppBar announcementAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.redAccent,
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 37, 37, 37),
                borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(
                CupertinoIcons.back,
                color: Colors.redAccent,
                size: 26,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      title: Text('Post Announcement',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
