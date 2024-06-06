import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/loginController.dart';
import '../utilis/text_utils/app_strings.dart';


class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.login.tr,
                style: const  TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: AppStrings.emailOnly.tr,
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: AppStrings.password.tr,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  loginController.login(emailController.text.toString(), passwordController.text.toString());
                },
                child: Text(AppStrings.login.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
