import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/customerList.dart';


class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    if(email == "user@maxmobility.in" && password != "Abc@#123") {
      Get.snackbar(
        'Login Status',
        "Entered password is wrong",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        mainButton: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Dismiss',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else if(email != "user@maxmobility.in" && password == "Abc@#123") {
      Get.snackbar(
        'Login Status',
        "Entered email is wrong",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        mainButton: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Dismiss',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else if(email == "user@maxmobility.in" && password == "Abc@#123"){
      Get.to(()=> customerListPage(), transition: Transition.leftToRightWithFade, duration: const Duration(milliseconds: 700),);
      Get.snackbar(
        'Login Status',
        "User Logged In successfully",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        mainButton: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Dismiss',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      Get.snackbar(
        'Login Status',
        "Wrong Credential",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.grey[800],
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        mainButton: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Dismiss',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}