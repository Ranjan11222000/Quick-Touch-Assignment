import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/components/text_editor.dart';
import '../res/components/text_style.dart';
import '../view_model/login_controller.dart';
import 'gif_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Obx(
                  () => Text(
                    loginController.isLogin.value ? "Log In" : "Sign Up",
                    style: text6().copyWith(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                loginTextField(),
                const SizedBox(
                  height: 15,
                ),
                passwordTextField(),
                const SizedBox(
                  height: 25,
                ),
                loginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginTextField() {
    return EditText(
      hintText: 'Login Id',
      controller: loginController.loginId,
      suffixIcon: Icons.login,
      validator: (value) {
        return (value == null || value.isEmpty) ? "Enter the e-mail ID" : null;
      },
    );
  }

  Widget passwordTextField() {
    return Obx(() => EditText(
          hintText: 'password',
          controller: loginController.password,
          suffixIcon: loginController.isPasswordVisible.value
              ? Icons.visibility_off
              : Icons.remove_red_eye,
          iconPressed: loginController.showPassword,
          isPasswordType: !loginController.isPasswordVisible.value,
          validator: (value) {
            return (value == null || value.isEmpty)
                ? "Enter the password"
                : null;
          },
        ));
  }

  Widget loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loginController.isLogin.value? const Spacer(flex: 2,):Container(),
        Obx(()=> ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // loginController.login();
                  Get.to(() => const GifView(),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(seconds: 1));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: Text(
                loginController.isLogin.value ? "LogIn" : "Sign up",
                style: text6().copyWith(fontSize: 18, color: Colors.white),
              )),
        ),
        const Spacer(),
        Obx(()=>loginController.isLogin.value?
            TextButton(
                    onPressed: () {
                      // loginController.signUp();
                    },
                    child: Text(
          "Sign Up",
          style: text4().copyWith(color: Colors.blue),
                    ),
                  ):Container(),
        )
      ],
    );
  }
}
