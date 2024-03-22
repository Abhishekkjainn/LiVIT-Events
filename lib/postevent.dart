import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:file_picker/file_picker.dart';

// import 'package:file_picker/file_picker.dart';

class PostEvent extends StatefulWidget {
  const PostEvent({super.key});

  @override
  State<PostEvent> createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController clubnamecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController venuecontroller = TextEditingController();
  TextEditingController eventCategorycontroller = TextEditingController();
  TextEditingController collabcontroller = TextEditingController();
  TextEditingController startdatecontroller = TextEditingController();
  TextEditingController enddatecontroller = TextEditingController();
  TextEditingController eventmodecontroller = TextEditingController();
  bool eventMode = false;

  String getFormattedDate() {
    // Get today's date
    DateTime now = DateTime.now();

    // Create a date format
    DateFormat formatter = DateFormat('dd/MM/yyyy');

    // Format the date and return as a string
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String getFormattedDateplusone() {
    // Get today's date
    DateTime now = DateTime.now();

    // Add one day to the current date
    DateTime tomorrow = now.add(const Duration(days: 2));

    // Create a date format
    DateFormat formatter = DateFormat('dd/MM/yyyy');

    // Format the date and return as a string
    String formattedDate = formatter.format(tomorrow);
    return formattedDate;
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        startdatecontroller.text = DateFormat('dd-MM-yy')
            .format(picked); // You can format the date as per your requirement
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        enddatecontroller.text = DateFormat('dd-MM-yy')
            .format(picked); // You can format the date as per your requirement
      });
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: Platform.isAndroid ? FileType.any : FileType.custom,
        allowedExtensions: Platform.isAndroid ? null : ['bin', 'nano']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: appBarEvent(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20, bottom: 5, top: 30),
              child: Text(
                'Event Name',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: namecontroller,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Blood Donation Drive',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.add_circled_solid,
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
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.redAccent, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://www.gaim.com/static/placeholder-dark.png')),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 180,
                          child: Text(
                            'Upload the Image Related to your Event.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(255, 61, 61, 61),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectFile();
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Upload',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20, bottom: 5, top: 20),
              child: Text(
                'Club/Chapter Name',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: clubnamecontroller,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Dream Merchants',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.building_2_fill,
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
                'Event Description',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: desccontroller,
                cursorColor: Colors.redAccent,
                maxLines: 3,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Detailed Description',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.pencil_circle_fill,
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
                'Venue',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: venuecontroller,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Anna Auditorium',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.location_solid,
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
                'Event Category',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: eventCategorycontroller,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Hackathon',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.square_list_fill,
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
                'Collaboration Name',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: collabcontroller,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Dream Merchants X GDSC',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.person_3_fill,
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
                'Start Date',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: startdatecontroller,
                cursorColor: Colors.redAccent,
                maxLines: null,
                readOnly: true,
                onTap: () => _selectStartDate(context),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: getFormattedDate(),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.calendar,
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
                'End Date',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: enddatecontroller,
                cursorColor: Colors.redAccent,
                readOnly: true,
                onTap: () => _selectEndDate(context),
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: getFormattedDateplusone(),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.calendar,
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 5, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Offline Event',
                    style: TextStyle(
                        color: Color.fromARGB(255, 61, 61, 61),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  CupertinoSwitch(
                    value: eventMode,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        eventMode = !eventMode;
                      });
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                CollectionReference collref =
                    FirebaseFirestore.instance.collection('events');
                try {
                  if (namecontroller.text == '') {
                    Get.snackbar(
                      "Error",
                      "Enter Event Name",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  if (clubnamecontroller.text == '') {
                    Get.snackbar(
                      "Error",
                      "Enter Host Club Name",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  if (venuecontroller.text == '') {
                    Get.snackbar(
                      "Error",
                      "Enter Event Venue's Name",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  if (eventCategorycontroller.text == '') {
                    Get.snackbar(
                      "Error",
                      "Enter Event Category's Name",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  if (startdatecontroller.text == '') {
                    Get.snackbar(
                      "Error",
                      "Enter Starting Date",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }

                  if (enddatecontroller.text == '') {
                    Get.snackbar(
                      "Error",
                      "Enter Last Date",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  if (desccontroller.text == '') {
                    Get.snackbar(
                      "Error",
                      "Enter Event Description",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                  if (namecontroller.text != '' &&
                      enddatecontroller.text != '' &&
                      desccontroller.text != '' &&
                      clubnamecontroller.text != '' &&
                      venuecontroller.text != '' &&
                      eventCategorycontroller.text != '' &&
                      startdatecontroller.text != '' &&
                      enddatecontroller.text != '') {
// Add data to Firestore
                    await collref.doc(clubnamecontroller.text).set({
                      'name': namecontroller.text,
                      'desc': desccontroller.text,
                      'clubname': clubnamecontroller.text,
                      'venue': venuecontroller.text,
                      'category': eventCategorycontroller.text,
                      'collabName': collabcontroller.text,
                      'startdate': startdatecontroller.text,
                      'lastdate': enddatecontroller.text,
                      'eventMode': (eventMode) ? 'Offline' : 'Online',
                    });

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
                              // Replace 'your_animation.json' with the path to your Lottie animation file
                              // You may need to adjust the width and height according to your animation size
                              Lottie.asset('assets/images/doneanim.json',
                                  repeat: false, width: 250, height: 250),
                            ],
                          ),
                        ));
                    await Future.delayed(const Duration(milliseconds: 5500));
                    Get.back();

                    // // Show success Snackbar
                    // Get.snackbar(
                    //   "Success",
                    //   "Congratulations! Your event has been posted.",
                    //   backgroundColor: Colors.green,
                    //   colorText: Colors.white,
                    // );

                    namecontroller.text = '';
                    desccontroller.text = '';
                    enddatecontroller.text = '';
                    startdatecontroller.text = '';
                    clubnamecontroller.text = '';
                    venuecontroller.text = '';
                    eventCategorycontroller.text = '';
                    collabcontroller.text = '';
                    eventMode = false;
                  }
                } catch (error) {
                  // Show error Snackbar
                  Get.snackbar(
                    "Error",
                    "Your event hasn't been posted.",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 40, right: 20, left: 20),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Text(
                      'Post Event',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar appBarEvent() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      leading: IconButton(
          style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 49, 49, 49))),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          )),
      title: const Text(
        'Post an Event',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
