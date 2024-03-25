import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livit/eventModal/authController.dart';
import 'package:lottie/lottie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class PostEvent extends StatefulWidget {
  const PostEvent({super.key});
  @override
  State<PostEvent> createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  AuthController controller = Get.find();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController clubnamecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController venuecontroller = TextEditingController();
  TextEditingController eventCategorycontroller = TextEditingController();
  TextEditingController collabcontroller = TextEditingController();
  TextEditingController startdatecontroller = TextEditingController();
  TextEditingController enddatecontroller = TextEditingController();
  TextEditingController eventmodecontroller = TextEditingController();
  TextEditingController taglinecontroller = TextEditingController();
  TextEditingController extlinkcontroller = TextEditingController();
  bool eventMode = false;

  String getFormattedDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String getFormattedDateplusone() {
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(const Duration(days: 2));
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(tomorrow);
    return formattedDate;
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        startdatecontroller.text = DateFormat('dd-MM-yy').format(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      barrierColor: Colors.black,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        enddatecontroller.text = DateFormat('dd-MM-yy').format(picked);
      });
    }
  }

  PlatformFile? pickedFile;
  PlatformFile? pickedFileClub;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: Platform.isAndroid ? FileType.any : FileType.custom,
        allowedExtensions: Platform.isAndroid ? null : ['bin', 'nano']);
    setState(() {
      pickedFile = result!.files.first;
    });
  }

  Future selectFileClub() async {
    final result = await FilePicker.platform.pickFiles(
        type: Platform.isAndroid ? FileType.any : FileType.custom,
        allowedExtensions: Platform.isAndroid ? null : ['bin', 'nano']);
    setState(() {
      pickedFileClub = result!.files.first;
    });
  }

  Future<String> uploadFileAndGetUrl() async {
    try {
      final path = 'files/${pickedFile!.name}';
      final uploadFile = File(pickedFile!.path!);
      final storageRef = FirebaseStorage.instance.ref().child(path);
      await storageRef.putFile(uploadFile);
      final String downloadURL = await storageRef.getDownloadURL();
      print('File uploaded successfully. Download URL: $downloadURL');
      return downloadURL;
    } catch (error) {
      print('Error uploading file: $error');
      // Handle error as needed, e.g., show an error message to the user.
      return ''; // Return an empty string or null indicating failure.
    }
  }

  Future<String> uploadFileAndGetUrlClub() async {
    try {
      final path = 'clubs/${pickedFileClub!.name}';
      final uploadFile = File(pickedFileClub!.path!);
      final storageRef = FirebaseStorage.instance.ref().child(path);
      await storageRef.putFile(uploadFile);
      final String downloadURL = await storageRef.getDownloadURL();
      print('File uploaded successfully. Download URL: $downloadURL');
      return downloadURL;
    } catch (error) {
      print('Error uploading file: $error');
      // Handle error as needed, e.g., show an error message to the user.
      return ''; // Return an empty string or null indicating failure.
    }
  }

  // Function to display an alert dialog
  Future<void> showUploadDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Uploading Data'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please wait while data is being uploaded...'),
                CircularProgressIndicator(), // Loading indicator
              ],
            ),
          ),
        );
      },
    );
  }

// Function to remove the alert dialog
  void removeUploadDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    clubnamecontroller = TextEditingController(text: controller.clubname);
    super.initState();
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
                        child: (pickedFile != null)
                            ? Image.file(
                                File(pickedFile!.path!),
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://www.gaim.com/static/placeholder-dark.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 180,
                          child: const Text(
                            'Upload the Image Related to your Event.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(255, 61, 61, 61),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
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
                            child: const Center(
                              child: Text(
                                'Select',
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
                        child: (pickedFileClub != null)
                            ? Image.file(
                                File(pickedFileClub!.path!),
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://www.gaim.com/static/placeholder-dark.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 180,
                          child: const Text(
                            'Add your Club Logo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(255, 61, 61, 61),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectFileClub();
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Select',
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
                readOnly: true,
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
                'Tagline',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: taglinecontroller,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Fun Event',
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
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20, bottom: 5, top: 20),
              child: Text(
                'External Website link',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: extlinkcontroller,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'www.dreamerchantsvit.com',
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
                  if (extlinkcontroller.text == '') {
                    Get.snackbar(
                      "Error",
                      "Enter Your Website Link (if no official Website is there. Add VTOP Registration link for your event)",
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
                    Get.defaultDialog(
                        barrierDismissible: false,
                        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                        titlePadding: const EdgeInsets.all(20),
                        title: 'Uploading Event..',
                        titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        content: Lottie.asset('assets/images/uploading.json',
                            height: 80, width: 80, repeat: true));
                    var link = await uploadFileAndGetUrl();
                    var clubLink = await uploadFileAndGetUrlClub();

                    await collref.doc(namecontroller.text).set({
                      'name': namecontroller.text,
                      'tagline': taglinecontroller.text,
                      'desc': desccontroller.text,
                      'clubname': controller.clubname,
                      'venue': venuecontroller.text,
                      'category': eventCategorycontroller.text,
                      'collabName': collabcontroller.text,
                      'startdate': startdatecontroller.text,
                      'lastdate': enddatecontroller.text,
                      'eventMode': (eventMode) ? 'Offline' : 'Online',
                      'path': link,
                      'clubpath': clubLink,
                      'registered': 0,
                      'rsvp': 0,
                      'favourites': 0,
                      'uploadedBy': controller.userEmail,
                      'externalwebsite': extlinkcontroller.text,
                      'registeredContestants': '',
                      'rsvpContestants': ''
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
                            ],
                          ),
                        ));
                    await Future.delayed(const Duration(milliseconds: 5500));
                    Get.back();
                    Get.back();

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
