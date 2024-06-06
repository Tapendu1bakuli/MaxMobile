import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../Controller/ProfileController.dart';
import '../Controller/addCustomerController.dart';
import '../Controller/customerListController.dart';
import '../Controller/pickupLocationController.dart';
import 'customerList.dart';
import 'database.dart';
import 'getUserCurrentLocation.dart';

class AddCustomerPage extends StatefulWidget {
  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  String? currentLocation;
  String? locationErrorMessage;

  final PickupLocationController pickupLocationController =
      Get.put(PickupLocationController());

  final ProfileController profileController = Get.put(ProfileController());
  final AddCustomerController addCustomerController =
      Get.put(AddCustomerController());

  final CustomerListController customerListController =
      Get.put(CustomerListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Customer'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GetBuilder<ProfileController>(builder: (profileController) {
                final profilePicture = profileController.profilePicture;
                return profilePicture != null
                    ? Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: FileImage(profilePicture),
                              radius: 50,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  profileController.selectProfilePicture();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  profileController.selectProfilePicture();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone No.',
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => getUserCurrentLocation(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 600),
                  );
                },
                child: const Text('Pick Current Location'),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Current Location:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Obx(
                () => Text(
                  pickupLocationController.address.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Current latitude:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Obx(
                () => Text(
                  pickupLocationController.lat.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Current Longitude:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Obx(
                () => Text(
                  pickupLocationController.long.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      pickupLocationController.lat.toString() == '' ||
                      profileController.profilePicture == null) {
                    Get.snackbar(
                      'Add Customer',
                      "Please Fill Up All The Details",
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
                    final database = await openDatabase1();
                    addCustomerController.insertData(
                      database,
                      profileController.profilePicture!.path.toString(),
                      nameController.text.toString(),
                      phoneController.text.toString(),
                      emailController.text.toString(),
                      pickupLocationController.address.toString(),
                      pickupLocationController.lat.toString(),
                      pickupLocationController.long.toString(),
                    );
                    customerListController.retrieveData();
                    pickupLocationController.setDefaultValue();
                    Get.to(
                      () => customerListPage(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 700),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
