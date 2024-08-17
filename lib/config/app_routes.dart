part of 'app_pages.dart';

/// Kelas abstrak yang mendefinisikan nama-nama route yang tersedia di aplikasi.
/// Digunakan untuk memudahkan referensi ke route dalam kode tanpa harus menulis string secara langsung.
abstract class Routes {
  // Private constructor untuk mencegah pembuatan instance dari kelas ini.
  Routes._();
  // Route untuk halaman HomeScreen.
  static const home = _Paths.home;

  // Route untuk halaman LiveAttendanceScreen.
  static const liveAttendance = _Paths.liveAttendance;

  // Route untuk halaman AddLocationScreen.
  static const addPinnedLocation = _Paths.addPinnedLocation;
}

/// Kelas abstrak yang mendefinisikan path dari setiap route yang tersedia di aplikasi.
/// Path ini digunakan oleh `GetPage` dalam `AppPages` untuk mendefinisikan URL dari setiap halaman.
abstract class _Paths {
  // Private constructor untuk mencegah pembuatan instance dari kelas ini.
  _Paths._();

  // Path untuk halaman HomeScreen, di mana '/' adalah root dari aplikasi.
  static const home = '/';

  // Path untuk halaman LiveAttendanceScreen.
  static const liveAttendance = '/live-attendance';

  // Path untuk halaman AddLocationScreen.
  static const addPinnedLocation = '/add-pinned-location';
}
