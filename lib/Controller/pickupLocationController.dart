import 'package:get/get.dart';

class PickupLocationController extends GetxController {
  RxString address = 'set your location'.obs;
  RxString lat = ''.obs;
  RxString long = ''.obs;

  Future<void> setAddress(String value, String value1, String value2) async{
    address.value = value;
    lat.value = value1;
    long.value = value2;
  }

  Future<void> setDefaultValue() async {
    address.value = 'set your location';
    lat.value = '';
    long.value = '';
  }
}