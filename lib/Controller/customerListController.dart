import 'package:get/get.dart';

import '../pages/database.dart';


class CustomerListController extends GetxController {
  final dataList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    retrieveData();
    super.onInit();
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
}
