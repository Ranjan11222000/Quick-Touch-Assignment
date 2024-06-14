import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_touch/data/auth.dart';
import '../res/utils/utils.dart';
import '../view/gif_view.dart';

class LoginController extends GetxController {
  final loginId = TextEditingController();
  final password = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLogin = true.obs;




  checkLogin() {
    isLogin.value = !isLogin.value;
    loginId.text = "";
    password.text = "";
  }

  Future<void> login() async {
    try {
      await Auth()
          .signIn(
              email: loginId.text.toString(),
              password: password.text.toString())
          .then(
        (value) {
          if (isLogin.value) {
            Get.off(() => const GifView(),
                transition: Transition.leftToRightWithFade,
                duration: const Duration(seconds: 1));
          }
          // checkLogin();
        },
      );
    } on FirebaseAuthException catch (e) {
      Utils.errorSnackBar("Error", e.message ?? "");
    } on PlatformException catch (e) {
      Utils.errorSnackBar("Error", e.message ?? "");
    }
  }

  Future<void> checkUserSigningOrNot() async {
    if (await Auth().authStateChanges.isEmpty) {
      checkLogin();
    } else {
      checkLogin();
    }
  }

  Future<void> signUp() async {
    try {
      await Auth()
          .signUp(
              email: loginId.text.toString(),
              password: password.text.toString())
          .then(
        (value) {
          checkLogin();
        },
      );
    } on FirebaseAuthException catch (e) {
      Utils.errorSnackBar("Error", e.message ?? "");
    } on PlatformException catch (e) {
      Utils.errorSnackBar("Error", e.message ?? "");
    }
  }

  showPassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
