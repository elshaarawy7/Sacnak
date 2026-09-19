import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sacny/core/constant/colors_app.dart';

class MapLocationPicker extends StatefulWidget {
  const MapLocationPicker({super.key, this.initialLocation});

  /// موقع مبدئي (اختياري) — لو مش موجود هنستخدم القاهرة كـ default
  final LatLng? initialLocation;

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  // Default: القاهرة
  static const LatLng _cairo = LatLng(30.0444, 31.2357);

  final Completer<GoogleMapController> _mapController = Completer();

  LatLng _selectedLocation = _cairo;
  bool _isLoadingLocation = false;

  Set<Marker> get _markers => {
        Marker(
          markerId: const MarkerId('selected'),
          position: _selectedLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: const InfoWindow(title: 'الموقع المحدد'),
        ),
      };

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _selectedLocation = widget.initialLocation!;
    }
  }

  // ---- الحصول على الموقع الحالي ----
  Future<void> _goToCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnack('يرجى تفعيل خدمة الـ GPS');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnack('تم رفض إذن الموقع');
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _showSnack('إذن الموقع محظور — افتح إعدادات التطبيق');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final current = LatLng(position.latitude, position.longitude);
      _moveTo(current);
      setState(() => _selectedLocation = current);
    } catch (e) {
      _showSnack('حدث خطأ: $e');
    } finally {
      setState(() => _isLoadingLocation = false);
    }
  }

  Future<void> _moveTo(LatLng position) async {
    final controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 16),
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red.shade700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'تحديد الموقع على الخريطة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        centerTitle: true,
        actions: [
          // زر تأكيد الموقع
          TextButton.icon(
            onPressed: () => Navigator.of(context).pop(_selectedLocation),
            icon: const Icon(Icons.check, color: Colors.white),
            label: const Text(
              'تأكيد',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // ---- الخريطة ----
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.initialLocation ?? _cairo,
              zoom: 14,
            ),
            onMapCreated: (controller) => _mapController.complete(controller),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onTap: (LatLng position) {
              setState(() => _selectedLocation = position);
            },
          ),

          // ---- بطاقة المعلومات في الأسفل ----
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: _InfoCard(location: _selectedLocation),
          ),

          // ---- زر الموقع الحالي ----
          Positioned(
            bottom: 120,
            left: 16,
            child: FloatingActionButton.small(
              heroTag: 'myLocation',
              backgroundColor: Colors.white,
              elevation: 4,
              onPressed: _isLoadingLocation ? null : _goToCurrentLocation,
              child: _isLoadingLocation
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.green,
                      ),
                    )
                  : const Icon(Icons.my_location, color: Colors.green),
            ),
          ),

          // ---- إشارة تلميح في الوسط ----
          const Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Center(
              child: _HintChip(),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- بطاقة عرض الإحداثيات ----
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.location});

  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_pin,
              color: AppColors.primaryGreen,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'الموقع المحدد',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'خط العرض: ${location.latitude.toStringAsFixed(6)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'خط الطول: ${location.longitude.toStringAsFixed(6)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(location),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            child: const Text(
              'تأكيد',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- تلميح الضغط ----
class _HintChip extends StatelessWidget {
  const _HintChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.touch_app, color: Colors.white, size: 16),
          SizedBox(width: 6),
          Text(
            'اضغط على الخريطة لتحديد الموقع',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
