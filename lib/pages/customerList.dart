import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_place_picker/utils/urls.dart';
import 'package:get/get.dart';
import 'package:max_mob/utilis/text_utils/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/customerListController.dart';
import 'addCustomerPage.dart';
import 'database.dart';


class customerListPage extends StatelessWidget {

  final CustomerListController customerListController =
      Get.put(CustomerListController());

  void openGoogleMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch Google Maps';
    }
    // openGoogleMaps(lat, lng);
  }
//

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.dataList.tr),
          actions: [
            Obx(()=> IconButton(
                  onPressed: () {
                  },
                  icon: customerListController.isInternetAvailable.value!="ConnectivityResult.none"?const Icon(Icons.wifi):const Icon(Icons.signal_wifi_connected_no_internet_4_rounded)),
            ),

          ],
        ),
        body: Obx(
          () {
            if (customerListController.dataList.isEmpty) {
              return Center(child: Text(AppStrings.noDataFound.tr));
            }
            return ListView.builder(
              itemCount: customerListController.dataList.length,
              itemBuilder: (context, index) {
                final item = customerListController.dataList[index];
                print( "==>${customerListController.dataList[index]}");
                return Card(
                  child: Row(
                    children: [
                      Checkbox(value: item['isCompleted'] == 2, onChanged: (bool? value)async{
                        final database = await openDatabase1();
                        updateIsCompleted(database,item['id'],value!?2:1);
                        customerListController.retrieveData();
                        Get.snackbar("Done", "Task marked as completed");
                      }),
                      Expanded(
                        child: ListTile(
                          title: Text("${item['name']}-${item['id']}"),
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
                      ),
                      IconButton(padding: EdgeInsets.zero,onPressed: ()async{
                        final database = await openDatabase1();
                        removeData(database,item['id']);
                        print(item['id']);
                        customerListController.retriveAfterDelete();
                        Get.snackbar("Deleted", "Task deletion successful");
                      }, icon: const Icon(Icons.delete,color: Colors.red,))
                    ],
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
