part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const liveAttendance = _Paths.liveAttendance;
  static const addPinnedLocation = _Paths.addPinnedLocation;
}

abstract class _Paths {
  _Paths._();

  static const home = '/';
  static const liveAttendance = '/live-attendance';
  static const addPinnedLocation = '/add-pinned-location';
}
