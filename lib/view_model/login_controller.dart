import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final loginId = TextEditingController();
  final password = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLogin= true.obs;


  checkLogin(){
    isLogin.value = !isLogin.value;
  }


  showPassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
