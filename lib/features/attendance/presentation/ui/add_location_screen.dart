import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_attendance/features/attendance/controllers/add_location_controller.dart';
import 'package:mobile_attendance/shared_widgets/custom_button.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftarkan Lokasi Absensi'),
      ),
      body: const CustomSFMaps(),
    );
  }
}

class CustomSFMaps extends StatefulWidget {
  const CustomSFMaps({super.key});

  @override
  State<CustomSFMaps> createState() => _CustomSFMapsState();
}

class _CustomSFMapsState extends State<CustomSFMaps> {
  final controller = Get.find<AddLocationController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Listener(
          onPointerUp: (event) => controller.setPinLocation(context, event),
          child: SfMaps(
            layers: [
              MapTileLayer(
                initialZoomLevel: 15,
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                controller: controller.mapController,
                initialMarkersCount: controller.mapMarkers.length,
                initialFocalLatLng: controller.initialMarker,
                zoomPanBehavior: MapZoomPanBehavior(),
                markerBuilder: (BuildContext context, int index) {
                  var mapMarker = controller.mapMarkers[index];
                  return MapMarker(
                    longitude: mapMarker.longitude,
                    latitude: mapMarker.latitude,
                    child: GestureDetector(
                      child: const Icon(
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
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: 'Simpan Lokasi',
              onPressed: () {
                controller.saveLocation(
                  context,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
