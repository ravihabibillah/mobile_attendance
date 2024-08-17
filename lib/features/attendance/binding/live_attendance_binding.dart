import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/controllers/live_attendance_controller.dart';

class LiveAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LiveAttendanceController());
  }
}
