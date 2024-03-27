import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:livit/auth/loginPage.dart';
import 'package:livit/home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthController extends GetxController {
  String? userEmail;
  String? username;
  String? regno;
  String? image;
  bool access = false;
  String? clubname;
  String? boardposition;

  String getFormattedDate() {
    // Get the current date
    DateTime now = DateTime.now();

    // Format the date as "dd-mm-yy"
    String formattedDate = DateFormat('dd-MM-yy').format(now);

    return formattedDate;
  }

  String getFormattedTime() {
    // Get the current time
    DateTime now = DateTime.now();

    // Format the time as "hh:mm:ss"
    String formattedTime = DateFormat('HH:mm:ss').format(now);

    return formattedTime;
  }

  checkAccessForClubs(context) async {
    try {
      // Access Firestore collection "ClubMembers"
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('ClubMembers').get();

      // Process each document in the snapshot
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Access document fields
        // String clubName = doc['clubName'];
        // String memberName = doc['memberName'];

        if (doc.id == userEmail) {
          access = true;
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: "You Have Club Access \nPost A New Event.",
            ),
          );
          clubname = doc['clubname'];
          boardposition = doc['boardposition'];
          break;
        } else {
          access = false;
        }
        print(access);
        update();
      }
    } catch (e) {
      print('Error fetching data: $e');
      // showTopSnackBar(
      //   Overlay.of(context),
      //   const CustomSnackBar.error(
      //     message: "Cant Get your Club Access Information.\nPlease Try Again",
      //   ),
      // );
      update();
    }
  }

  checkIfLoggedIn(context) async {
    User? user = FirebaseAuth.instance.currentUser;
    print(user);
    await Future.delayed(const Duration(milliseconds: 2500));
    if (user != null) {
      if (user.email!.endsWith('@vitstudent.ac.in')) {
        Get.off(() => Home());
        String displayName = user.displayName!;
        List<String> parts = displayName.split(' ');
        String lastPart = parts.isNotEmpty ? parts.last : '';
        regno = lastPart;
        parts.removeLast();
// Join the remaining parts to get the rest of the name
        username = parts.join(' ');
        userEmail = user.email;
        image = user.photoURL;
        userEmail = user.email;
        checkAccessForClubs(context);
      } else {
        // logoutWithGoogle(context);
        await Future.delayed(Duration.zero);
        // showIllegalLoginDialog(context);
        Get.off(() => const Login(), transition: Transition.rightToLeft);
      }
    } else {
      // logoutWithGoogle(context);
      Get.off(() => const Login(), transition: Transition.rightToLeft);
    }
    update();
  }

  signinWithGoogle(context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      if (userCredential.user!.email!.endsWith('@vitstudent.ac.in')) {
        String displayName = userCredential.user!.displayName!;
        List<String> parts = displayName.split(' ');
        String lastPart = parts.isNotEmpty ? parts.last : '';
        regno = lastPart;
        parts.removeLast();
        username = parts.join(' ');
        userEmail = userCredential.user!.email;
        image = userCredential.user!.photoURL;

        showSuccesfulLoginDialog(context);
        await Future.delayed(const Duration(milliseconds: 2500));
        Get.back();
        Get.offAll(() => Home(), transition: Transition.downToUp);
      } else {
        showIllegalLoginDialog(context);
        logoutWithGoogle(context);
      }
    }
    update();
  }

  logoutWithGoogle(context) async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(milliseconds: 2500));
    showLoggedoutDialog(context);
  }

  void showIllegalLoginDialog(context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: "Psst! Only VIT students get the backstage pass to our app.",
      ),
    );
  }

  void showSuccesfulLoginDialog(context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: "Congratulations ! Succefully Logged in",
      ),
    );
  }

  void showLoggedoutDialog(context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: "You Have been Logged out Succefully.",
      ),
    );
  }
}
