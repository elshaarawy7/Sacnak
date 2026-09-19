import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/admin/add_drug/presentation/pages/map_location_picker.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/text_filed.dart';

class AddressDragCart extends StatefulWidget {
  const AddressDragCart({
    super.key,
    this.cityController,
    this.streetController,
    this.buildingNumberController,
    this.apartmentNumberController,
  });

  final TextEditingController? cityController;
  final TextEditingController? streetController;
  final TextEditingController? buildingNumberController;
  final TextEditingController? apartmentNumberController;

  @override
  State<AddressDragCart> createState() => _AddressDragCartState();
}

class _AddressDragCartState extends State<AddressDragCart> { 
  late TextEditingController _internalCityController;
  late TextEditingController _internalStreetController;
  late TextEditingController _internalBuildingController;
  late TextEditingController _internalApartmentController;

  TextEditingController get nameCityController =>
      widget.cityController ?? _internalCityController;
  TextEditingController get nameStreetController =>
      widget.streetController ?? _internalStreetController;
  TextEditingController get buildingNumberController =>
      widget.buildingNumberController ?? _internalBuildingController;
  TextEditingController get apartmentNumberController =>
      widget.apartmentNumberController ?? _internalApartmentController;

  @override
  void initState() {
    super.initState();
    _internalCityController = TextEditingController();
    _internalStreetController = TextEditingController();
    _internalBuildingController = TextEditingController();
    _internalApartmentController = TextEditingController();
  }

  @override
  void dispose() {
    _internalCityController.dispose();
    _internalStreetController.dispose();
    _internalBuildingController.dispose();
    _internalApartmentController.dispose();
    super.dispose();
  } 
  LatLng? _selectedLocation;
  String? _addressLine;
  String? _cityLine;
  bool _isLoadingAddress = false;

  Future<void> _openMapPicker() async {
    final result = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (_) => MapLocationPicker(initialLocation: _selectedLocation),
      ),
    );
    if (result != null) {
      setState(() {
        _selectedLocation = result;
        _isLoadingAddress = true;
        _addressLine = null;
        _cityLine = null;
      });
      await _reverseGeocode(result);
    }
  }

  Future<void> _reverseGeocode(LatLng location) async {
    try {
      final geocoding = Geocoding();
      final placemarks = await geocoding.placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final streetParts = [p.thoroughfare, p.subLocality]
            .where((s) => s != null && s.isNotEmpty)
            .toList();
        final cityParts = [p.locality, p.administrativeArea, p.country]
            .where((s) => s != null && s.isNotEmpty)
            .toList();
        setState(() {
          _addressLine = streetParts.isNotEmpty ? streetParts.join(', ') : null;
          _cityLine = cityParts.isNotEmpty ? cityParts.join(', ') : null;
        });
      }
    } catch (_) {
      setState(() {
        _addressLine = null;
        _cityLine = null;
      });
    } finally {
      setState(() => _isLoadingAddress = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: AppColors.primaryGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.primaryGreen, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primaryGreen, size: 20),
                Gap(6),
                Text(
                  '\u0627\u0644\u0639\u0646\u0648\u0627\u0646',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
                Gap(6),
                Text(
                  '(\u0627\u062e\u062a\u064a\u0627\u0631\u064a)',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            Gap(12),

            CusteomFromTextFiledAdmain(
              controller: nameCityController,
              labelText: '\u0627\u0633\u0645 \u0627\u0644\u0645\u062f\u064a\u0646\u0647',
              hintText: '\u0627\u062f\u062e\u0644 \u0627\u0633\u0645 \u0627\u0644\u0645\u062f\u064a\u0646\u0647',
            ),

            Gap(12),

            CusteomFromTextFiledAdmain(
              controller: nameStreetController,
              labelText: '\u0627\u0633\u0645 \u0627\u0644\u0634\u0627\u0631\u0639',
              hintText: '\u0627\u062f\u062e\u0644 \u0627\u0633\u0645 \u0627\u0644\u0634\u0627\u0631\u0639',
            ),

            Gap(12),

            Row(
              children: [
                Expanded(
                  child: CusteomFromTextFiledAdmain(
                    controller: buildingNumberController,
                    labelText: '\u0631\u0642\u0645 \u0627\u0644\u0639\u0645\u0627\u0631\u0647',
                    hintText: '\u0631\u0642\u0645 \u0627\u0644\u0639\u0645\u0627\u0631\u0647',
                    keyboardType: TextInputType.number,
                  ),
                ),
                Gap(12),
                Expanded(
                  child: CusteomFromTextFiledAdmain(
                    controller: apartmentNumberController,
                    labelText: '\u0631\u0642\u0645 \u0627\u0644\u0634\u0642\u0647',
                    hintText: '\u0631\u0642\u0645 \u0627\u0644\u0634\u0642\u0647',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            Gap(14),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _openMapPicker,
                icon: Icon(
                  _selectedLocation == null
                      ? Icons.map_outlined
                      : Icons.edit_location_alt_outlined,
                  color: AppColors.primaryGreen,
                ),
                label: Text(
                  _selectedLocation == null
                      ? '\u062a\u062d\u062f\u064a\u062f \u0627\u0644\u0645\u0648\u0642\u0639 \u0639\u0644\u0649 \u0627\u0644\u062e\u0631\u064a\u0637\u0629'
                      : '\u062a\u0639\u062f\u064a\u0644 \u0627\u0644\u0645\u0648\u0642\u0639 \u0639\u0644\u0649 \u0627\u0644\u062e\u0631\u064a\u0637\u0629',
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryGreen, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            if (_selectedLocation != null) ...[
              Gap(10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primaryGreen.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.check_circle,
                        color: AppColors.primaryGreen,
                        size: 16,
                      ),
                    ),
                    Gap(8),
                    Expanded(
                      child: _isLoadingAddress
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryGreen,
                                  ),
                                ),
                                Gap(8),
                                Text(
                                  '\u062c\u0627\u0631\u064a \u062a\u062d\u062f\u064a\u062f \u0627\u0644\u0639\u0646\u0648\u0627\u0646...',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\u062a\u0645 \u062a\u062d\u062f\u064a\u062f \u0627\u0644\u0645\u0648\u0642\u0639 \u2713',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryGreen,
                                  ),
                                ),
                                if (_addressLine != null && _addressLine!.isNotEmpty) ...[
                                  Gap(3),
                                  Row(
                                    children: [
                                      Icon(Icons.signpost_outlined,
                                          size: 13, color: Colors.grey.shade600),
                                      Gap(4),
                                      Expanded(
                                        child: Text(
                                          _addressLine!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (_cityLine != null && _cityLine!.isNotEmpty) ...[
                                  Gap(2),
                                  Row(
                                    children: [
                                      Icon(Icons.location_city_outlined,
                                          size: 13, color: Colors.grey.shade600),
                                      Gap(4),
                                      Expanded(
                                        child: Text(
                                          _cityLine!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if ((_addressLine == null || _addressLine!.isEmpty) &&
                                    (_cityLine == null || _cityLine!.isEmpty)) ...[
                                  Gap(3),
                                  Text(
                                    'lat: ${_selectedLocation!.latitude.toStringAsFixed(5)} | lng: ${_selectedLocation!.longitude.toStringAsFixed(5)}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        _selectedLocation = null;
                        _addressLine = null;
                        _cityLine = null;
                      }),
                      child: Icon(Icons.close, size: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}