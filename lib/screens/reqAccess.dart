import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:livit/eventModal/authController.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RequestClubAccessPage extends StatefulWidget {
  RequestClubAccessPage({super.key});

  @override
  State<RequestClubAccessPage> createState() => _RequestClubAccessPageState();
}

class _RequestClubAccessPageState extends State<RequestClubAccessPage> {
  AuthController controller = Get.find();

  TextEditingController accessnameController = TextEditingController();

  TextEditingController clubnameController = TextEditingController();

  TextEditingController boardController = TextEditingController();

  TextEditingController regnoController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController facultynameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      accessnameController = TextEditingController(text: controller.username!);
      regnoController = TextEditingController(text: controller.regno!);
      emailController = TextEditingController(text: controller.userEmail!);
    });
    super.initState();
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
      final path = 'requests/${pickedFile!.name}';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reqAccessAppBar(),
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 40, right: 20, bottom: 5, top: 20),
              child: Text(
                'Enter your Name',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: accessnameController,
                cursorColor: Colors.redAccent,
                readOnly: true,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'John Doe',
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
                'Enter Club/Chapter name',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: clubnameController,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Club / Chapter Name',
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
                            'Upload Club/Chapter Official Logo',
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
                            'Upload A Valid Proof of your Enrollment',
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
                'Board Position',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: boardController,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Technical Head',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.person_2_alt,
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
                'Registration No',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: regnoController,
                readOnly: true,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: regnoController.text,
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.person_2_alt,
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
                'VIT Email ID',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: emailController,
                cursorColor: Colors.redAccent,
                readOnly: true,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: '',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.person_2_alt,
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
                'Faculty Co-ordinator Name',
                style: TextStyle(
                    color: Color.fromARGB(255, 61, 61, 61),
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: facultynameController,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    hintText: 'Prof Vishwanathan G',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.person_2_alt,
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
            GestureDetector(
              onTap: () async {
                CollectionReference collref =
                    FirebaseFirestore.instance.collection('ClubAccessRequests');
                try {
                  if (clubnameController.text == '') {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "Enter Your Club Name",
                      ),
                    );
                  }
                  if (boardController.text == '') {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: "Please Enter your Board Position",
                      ),
                    );
                  }
                  if (facultynameController.text == '') {
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
                        title: 'Getting Access Request',
                        titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        content: Lottie.asset('assets/images/uploading.json',
                            height: 80, width: 80, repeat: true));
                    var link = await uploadFileAndGetUrl();
                    await collref
                        .doc(
                            '${accessnameController.text + clubnameController.text}')
                        .set({
                      'name': accessnameController.text,
                      'clubname': clubnameController.text,
                      'logolink': link,
                      'boardPosition': boardController.text,
                      'regno': regnoController.text,
                      'vitemail': emailController.text,
                      'facultycoordinator': facultynameController.text,
                      'reviewed': false,
                      'accepted': false
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
                                  'Request Sent, You will get a Mail from us if your Request gets Approved',
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
                    top: 20, bottom: 40, right: 20, left: 20),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Text(
                      'Request Access',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
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

  AppBar reqAccessAppBar() {
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
      title: Text('Request Club Access',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
