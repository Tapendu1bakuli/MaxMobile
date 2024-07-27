import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/database.dart';


class CustomerListController extends GetxController {
  final dataList = <Map<String, dynamic>>[].obs;
  List<ConnectivityResult> connectionStatus = [ConnectivityResult.none];
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  @override
  void onInit() {
    retrieveData();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    super.onInit();
  }
  RxString isInternetAvailable = "".obs;
  Future<void> updateConnectionStatus(List<ConnectivityResult> result) async {
    print("Tapendu");
    connectionStatus = result;
    // ignore: avoid_print
    print('Connectivity changed: $connectionStatus');

    if (connectionStatus[0].toString() != "ConnectivityResult.none") {
      showSuccessSnackBarForOnline("Internet connected", "App is in online mode now.");
      isInternetAvailable.value = connectionStatus[0].toString();
    }else{
      isInternetAvailable.value = connectionStatus[0].toString();
      showFailureSnackBarForOffline("No Internet!", "App is in offline mode now.");
    }
  }

  Future<void> retrieveData() async {
    final database = await openDatabase1();
    final isDataExists = await checkDataExists(database);

    if (!isDataExists) {
      print("No Data Found");
      dataList.clear();
    } else {
      final insertedData = await getInsertedData(database);
      dataList.value = insertedData;
    }
    await database.close();
  }
  void showSuccessSnackBarForOnline(String? title, String msg) {
    clearSnackBars();
    Get.snackbar(title ?? "Oops!", msg, snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF12433F).withOpacity(0.4),
        colorText: const Color(0xFFFFFFFF),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20)
    );
  }
  clearSnackBars() {
    Get.closeAllSnackbars();
  }
  void showFailureSnackBarForOffline(String? title, String msg) {
    clearSnackBars();
    Get.snackbar(
        "",
        "",
        messageText: const Offstage(),
        titleText: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
            msg,
            style: const TextStyle(
                letterSpacing: 0,
                color: Color(0xFFF4F7FF),
                fontSize: 13,fontWeight: FontWeight.w500),
          ),
        ),
        icon: const Icon(Icons.error_outline_rounded,color: Colors.white,),
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFBD3A02).withOpacity(0.4),
        colorText:Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0));
  }

}
