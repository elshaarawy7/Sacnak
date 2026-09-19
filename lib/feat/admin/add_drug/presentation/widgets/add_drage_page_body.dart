import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sacny/core/widgets/custom_batton.dart';
import 'package:sacny/feat/admin/add_drug/presentation/cubit/propetry_cubit.dart';
import 'package:sacny/feat/admin/add_drug/presentation/cubit/propetry_state.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/addres_drag_cart.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/amenities_selector.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/cart_admain.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/nearby_universities_selector.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/price_cart_month.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/property_images_uploader.dart';

class AddDragePageBody extends StatefulWidget {
  const AddDragePageBody({super.key});

  @override
  State<AddDragePageBody> createState() => _AddDragePageBodyState();
}

class _AddDragePageBodyState extends State<AddDragePageBody> {
  final formKey = GlobalKey<FormState>();
  final areaController = TextEditingController();
  final bedroomsController = TextEditingController();
  final roomsController = TextEditingController();
  final bathroomsController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final buildingNumberController = TextEditingController();
  final apartmentNumberController = TextEditingController();
  final priceController = TextEditingController();
  final insuranceController = TextEditingController();
  bool isIncludesBills = false;
  List<String> nearbyUniversities = const [];
  List<String> selectedAmenities = const [];
  List<XFile> propertyImages = const [];

  @override
  void dispose() {
    formKey.currentState?.reset();
    areaController.dispose();
    bedroomsController.dispose();
    roomsController.dispose();
    bathroomsController.dispose();
    cityController.dispose();
    streetController.dispose();
    buildingNumberController.dispose();
    apartmentNumberController.dispose();
    priceController.dispose();
    insuranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyCubit, AddPropetryState>(
      listener: (context, state) {
        if (state is AddPropetryError) {
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        if (state is AddPropertySucsess) {
          Fluttertoast.showToast(
            msg: "تم اضافة الشقه بنجاح",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        final mycubit = context.read<PropertyCubit>();
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(70),
                  const Text(
                    "معلومات الشقه",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(20),
                  CartAdmin(
                    areaController: areaController,
                    bedroomsController: bedroomsController,
                    roomsController: roomsController,
                    bathroomsController: bathroomsController,
                  ),
                  const Gap(25),
                  const Text(
                    "عنوان الشقه",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(20),
                  AddressDragCart(
                    cityController: cityController,
                    streetController: streetController,
                    buildingNumberController: buildingNumberController,
                    apartmentNumberController: apartmentNumberController,
                  ),
                  const Gap(25),
                  const Text(
                    "سعر الشقه",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(20),
                  PriceCartMonth(
                    priceController: priceController,
                    insuranceController: insuranceController,
                    onSwitchChanged: (value) {
                      isIncludesBills = value;
                    },
                  ),
                  const Gap(30),
                  const Text(
                    "صور للشقه",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(20),
                  PropertyImagesUploader(
                    onImagesChanged: (images) {
                      propertyImages = images;
                    },
                  ),
                  const Gap(30),
                  AmenitiesSelector(
                    onSelectionChanged: (amenities) {
                      selectedAmenities = amenities
                          .map((item) => item.id)
                          .toList();
                    },
                  ),
                  const Gap(30),
                  NearbyUniversitiesSelector(
                    onUniversitiesChanged: (universities) {
                      nearbyUniversities = List<String>.from(universities);
                    },
                  ),
                  const Gap(35),

                  state is AddPropetryLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomBatton(
                          text: "نشر الاعلان الان ومتابعة الطلاب ",
                          ontap: () {
                            if (formKey.currentState!.validate()) {
                              mycubit.addProperty(
                                area: double.tryParse(areaController.text.trim()) ?? 0.0,
                                bedrooms: int.tryParse(bedroomsController.text.trim()) ?? 0,
                                rooms: int.tryParse(roomsController.text.trim()) ?? 0,
                                bathrooms: int.tryParse(bathroomsController.text.trim()) ?? 0,
                                city: cityController.text.trim(),
                                street: streetController.text.trim(),
                                buildingNumber: buildingNumberController.text.trim(),
                                apartmentNumber: apartmentNumberController.text.trim(),
                                nearbyUniversities: nearbyUniversities,
                                amenities: selectedAmenities,
                                price: double.tryParse(priceController.text.trim()),
                                insurance: double.tryParse(insuranceController.text.trim()),
                                isIncludesBills: isIncludesBills,
                                images: propertyImages,
                              );
                            }
                          },
                        ), 

                        Gap(20) , 
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
