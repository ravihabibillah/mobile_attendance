import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/binding/add_location_binding.dart';
import 'package:mobile_attendance/features/attendance/binding/live_attendance_binding.dart';
import 'package:mobile_attendance/features/attendance/presentation/ui/add_location_screen.dart';
import 'package:mobile_attendance/features/attendance/presentation/ui/live_attendance_screen.dart';
import 'package:mobile_attendance/features/home/home_screen.dart';

part 'app_routes.dart';

/// Kelas ini digunakan untuk mendaftarkan `Page` dan `Route`
/// ke Aplikasi.
class AppPages {
  AppPages._();

  // Ini adalah inisialisasi route awal yang akan ditampilkan
  static const initial = Routes.home;

  // List Page
  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      binding: AddLocationBinding(),
      name: _Paths.addPinnedLocation,
      page: () => const AddLocationScreen(),
    ),
    GetPage(
      binding: LiveAttendanceBinding(),
      name: _Paths.liveAttendance,
      page: () => LiveAttendanceScreen(),
    ),
  ];
}
