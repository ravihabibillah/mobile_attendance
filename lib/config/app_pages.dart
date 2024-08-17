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
  // Private constructor untuk mencegah pembuatan instance dari kelas ini.
  AppPages._();

  // Ini adalah inisialisasi route awal yang akan ditampilkan
  static const initial = Routes.home;

  // List dari GetPage yang merepresentasikan halaman dan route yang tersedia di aplikasi.
  static final routes = [
    // Definisi route untuk halaman HomeScreen.
    GetPage(
      name: _Paths.home,
      page: () => const HomeScreen(),
    ),

    // Definisi route untuk halaman AddLocationScreen.
    GetPage(
      binding: AddLocationBinding(),
      name: _Paths.addPinnedLocation,
      page: () => const AddLocationScreen(),
    ),

    // Definisi route untuk halaman LiveAttendanceScreen.
    GetPage(
      binding: LiveAttendanceBinding(),
      name: _Paths.liveAttendance,
      page: () => LiveAttendanceScreen(),
    ),
  ];
}
