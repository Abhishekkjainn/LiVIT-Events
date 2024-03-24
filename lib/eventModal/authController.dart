import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:livit/auth/loginPage.dart';
import 'package:livit/home.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthController extends GetxController {
  String? userEmail;
  String? username;
  String? regno;
  String? image;

  checkIfLoggedIn(context) async {
    User? user = FirebaseAuth.instance.currentUser;
    await Future.delayed(const Duration(milliseconds: 2500));
    if (user != null) {
      if (user.email!.endsWith('@vitstudent.ac.in')) {
        Get.off(() => Home(), transition: Transition.downToUp);
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
      } else {
        await Future.delayed(Duration.zero);
        showIllegalLoginDialog(context);
        logoutWithGoogle(context);
        Get.off(() => const Login(), transition: Transition.rightToLeft);
      }
    } else {
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
        await GoogleSignIn().signOut();
      }
    }
    update();
  }

  logoutWithGoogle(context) async {
    showLoggedoutDialog(context);
    regno = '';

// Join the remaining parts to get the rest of the name
    username = '';
    userEmail = '';
    image = '';
    await Future.delayed(const Duration(milliseconds: 2500));
    await GoogleSignIn().signOut();
    update();
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
