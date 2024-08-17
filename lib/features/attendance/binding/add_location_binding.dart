import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/controllers/add_location_controller.dart';

class AddLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddLocationController());
  }
}
