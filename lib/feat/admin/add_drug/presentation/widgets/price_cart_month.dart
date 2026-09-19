import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/text_filed.dart';

class PriceCartMonth extends StatefulWidget {
  const PriceCartMonth({
    super.key,
    this.priceController,
    this.insuranceController,
    this.isIncludesBills,
    this.onSwitchChanged,
  });

  final TextEditingController? priceController;
  final TextEditingController? insuranceController;
  final bool? isIncludesBills;
  final ValueChanged<bool>? onSwitchChanged;

  @override
  State<PriceCartMonth> createState() => _PriceCartMonthState();
}

class _PriceCartMonthState extends State<PriceCartMonth> {
  bool isSwitsh = false; 
  late TextEditingController _internalPriceController;
  late TextEditingController _internalInsuranceController;

  TextEditingController get priceController =>
      widget.priceController ?? _internalPriceController;
  TextEditingController get insuranceController =>
      widget.insuranceController ?? _internalInsuranceController;

  @override
  void initState() {
    super.initState();
    isSwitsh = widget.isIncludesBills ?? false;
    _internalPriceController = TextEditingController();
    _internalInsuranceController = TextEditingController();
  }

  @override
  void dispose() {
    _internalPriceController.dispose();
    _internalInsuranceController.dispose();
    super.dispose();
  } 
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Card(
        elevation: 2,
        shadowColor: AppColors.primaryGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppColors.primaryGreen, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
          child: Column(
            children: [
              CusteomFromTextFiledAdmain(
                controller: priceController,
                labelText: "سعر الشهر",
                hintText: "ادخل سعر الشهر",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "سعر الشهر مطلوب";
                  } else if (int.tryParse(value) == 0) {
                    return "سعر الشهر مطلوب";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),

              Gap(20),

              CusteomFromTextFiledAdmain(
                controller: insuranceController,
                labelText: "قيمه التامين المسترد ",
                hintText: "ادخل قيمه التامين المسترد ",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "قيمه التامين المسترد مطلوب";
                  } else if (int.tryParse(value) == 0) {
                    return "قيمه التامين المسترد مطلوب";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),

              Gap(20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "هل الايجار شامل الفواتير",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),

                  Switch(
                    value: isSwitsh,
                    onChanged: (value) {
                      setState(() {
                        isSwitsh = value;
                        widget.onSwitchChanged?.call(value);
                      });
                    },
                    activeTrackColor: AppColors.primaryGreen,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
