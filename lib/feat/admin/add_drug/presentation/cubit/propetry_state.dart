import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sacny/feat/admin/add_drug/domain/entity/property_entity.dart';

class AddPropetryState {}

class AddPropetryInitial extends AddPropetryState {}

class AddPropetryLoading extends AddPropetryState {}

class AddPropetryError extends AddPropetryState {
  final String error;
  AddPropetryError({required this.error});
}

class SelectLocationState extends AddPropetryState {
  final LatLng? selectedLocation;
  final String address;

  SelectLocationState({this.selectedLocation, this.address = ''});
}

class PropertiesLoaded extends AddPropetryState {
  final List<PropertyEntity> properties;

  PropertiesLoaded(this.properties);
}

class AddPropertySucsess extends AddPropetryState {

  final PropertyEntity propertyEntity;
  AddPropertySucsess({required this.propertyEntity});
} 


