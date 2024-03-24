import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:livit/auth/loginPage.dart';
import 'package:livit/home.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class authController extends GetxController {
  String? userEmail;
  checkIfLoggedIn(context) async {
    User? user = FirebaseAuth.instance.currentUser;
    await Future.delayed(Duration(milliseconds: 2500));
    if (user != null) {
      if (user.email!.endsWith('@vitstudent.ac.in')) {
        print('asdfasdf');
        print(user.displayName);
        Get.off(() => Home(), transition: Transition.downToUp);
        userEmail = user.email;
      } else {
        await Future.delayed(Duration.zero);
        showIllegalLoginDialog(context);
        logoutWithGoogle();
        Get.off(() => Login(), transition: Transition.rightToLeft);
      }
    } else {
      Get.off(() => Login(), transition: Transition.rightToLeft);
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
        userEmail = userCredential.user!.email;
        Get.dialog(AlertDialog(
          title:
              Text('${userCredential.user!.displayName} logged in Succesfuly'),
        ));
        await Future.delayed(Duration(milliseconds: 4000));
        Get.back();
        Get.offAll(() => Home(), transition: Transition.downToUp);
      } else {
        showIllegalLoginDialog(context);
        await GoogleSignIn().signOut();
      }
    }
    print(userCredential.user?.displayName);
    update();
  }

  logoutWithGoogle() async {
    await GoogleSignIn().signOut();
  }

  void showIllegalLoginDialog(context) {
    Get.dialog(AlertDialog(
      title: Text('Illegal Login'),
      content: Text(
          'Imposter Detected \nonly VIT Students Allowed \nEmail should end with (@vitstudent.ac.in)'),
    ));
  }
}
