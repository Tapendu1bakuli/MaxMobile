import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AddCustomerController extends GetxController {
  RxBool isLoading = false.obs;

  Future<int> insertData(
      Database database,
      String imageUrl,
      String name,
      String mobile,
      String email,
      String address,
      String lat,
      String lng,
      ) async {
    isLoading(true);
    final row = {
      'image': imageUrl,
      'name': name,
      'mobile': mobile,
      'email': email,
      'address': address,
      'lat': lat,
      'lng': lng,
    };

    final insertedId = await database.insert('my_table', row);
    return insertedId;
  }
}
