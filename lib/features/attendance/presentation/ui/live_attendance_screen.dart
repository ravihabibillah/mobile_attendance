import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/controllers/live_attendance_controller.dart';
import 'package:mobile_attendance/shared_widgets/custom_button.dart';
import 'package:mobile_attendance/utils/locator_service.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class LiveAttendanceScreen extends StatelessWidget {
  LiveAttendanceScreen({super.key});
  final controller = Get.find<LiveAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Attendance'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.hasData.value) {
          return const CustomSFMaps();
        } else {
          return const Center(
            child: Text('Terjadi Kesalahan'),
          );
        }
      }),
    );
  }
}

class CustomSFMaps extends StatefulWidget {
  const CustomSFMaps({super.key});

  @override
  State<CustomSFMaps> createState() => _CustomSFMapsState();
}

class _CustomSFMapsState extends State<CustomSFMaps> {
  final controller = Get.find<LiveAttendanceController>();

  late List<MapLatLng> mapMarkers;
  late MapLatLng marker;
  late MapTileLayerController mapController;

  @override
  void initState() {
    var locatorServicePosition = LocatorService.currentPosition!;
    mapController = MapTileLayerController();
    marker = MapLatLng(
        locatorServicePosition.latitude, locatorServicePosition.longitude);
    mapMarkers = <MapLatLng>[
      marker,
      MapLatLng(controller.pinnedLocation.latitude!,
          controller.pinnedLocation.longitude!)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfMaps(
          layers: [
            MapTileLayer(
              initialZoomLevel: 15,
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              controller: mapController,
              initialMarkersCount: mapMarkers.length,
              initialFocalLatLng: marker,
              markerBuilder: (BuildContext context, int index) {
                return MapMarker(
                  longitude: mapMarkers[index].longitude,
                  latitude: mapMarkers[index].latitude,
                  child: GestureDetector(
                    child: index > 0
                        ? const Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 50,
                          )
                        : const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 50,
                          ),
                  ),
                );
              },
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Lakukan Absensi',
              onPressed: () {
                controller.checkLocation(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
