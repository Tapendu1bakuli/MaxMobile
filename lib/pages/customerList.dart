import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/customerListController.dart';
import 'addCustomerPage.dart';


class customerListPage extends StatelessWidget {

  final CustomerListController customerListController =
      Get.put(CustomerListController());

  void openGoogleMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url, universalLinksOnly: true,);
    } else {
      throw 'Could not launch Google Maps';
    }
    openGoogleMaps(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data list'),
        ),
        body: Obx(
          () {
            if (customerListController.dataList.isEmpty) {
              return const Center(child: Text('No data found'));
            }
            return ListView.builder(
              itemCount: customerListController.dataList.length,
              itemBuilder: (context, index) {
                final item = customerListController.dataList[index];
                return Card(
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['mobile']),
                        Text(item['email']),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                          File(item['image'])),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.location_on_sharp, color: Colors.red,),
                      onPressed: () {
                        final destinationLat = double.parse(item['lat']);
                        final destinationLng = double.parse(item['lng']);
                        openGoogleMaps(destinationLat, destinationLng);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(
              () => AddCustomerPage(),
              transition: Transition.downToUp,
              duration: const Duration(milliseconds: 500),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
