import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/admin/add_drug/presentation/widgets/text_filed.dart';

class CartAdmin extends StatefulWidget {
  const CartAdmin({
    super.key,
    this.areaController,
    this.bedroomsController,
    this.roomsController,
    this.bathroomsController,
    this.onBedsChanged,
    this.onRoomsChanged,
    this.onBathroomsChanged,
  });

  final TextEditingController? areaController;
  final TextEditingController? bedroomsController;
  final TextEditingController? roomsController;
  final TextEditingController? bathroomsController;
  final ValueChanged<int>? onBedsChanged;
  final ValueChanged<int>? onRoomsChanged;
  final ValueChanged<int>? onBathroomsChanged;

  @override
  State<CartAdmin> createState() => _CartAdminState();
}

class _CartAdminState extends State<CartAdmin> { 
  late TextEditingController _internalAreaController;

  TextEditingController get areaController =>
      widget.areaController ?? _internalAreaController;

  @override
  void initState() {
    super.initState();
    _internalAreaController = TextEditingController();
  }

  @override
  void dispose() {
    _internalAreaController.dispose();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
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
                controller: areaController,
                labelText: "مساحه الشقه",
                hintText: "ادخل مساحه الشقه",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "مساحه الشقه مطلوبه";
                  } else if (int.tryParse(value) == 0) {
                    return "مساحه الشقه مطلوبه";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),

              Gap(20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerBedsCounter(
                    text: "عدد السراير",
                    controller: widget.bedroomsController,
                    onCountChanged: widget.onBedsChanged,
                  ),
                  ContainerBedsCounter(
                    text: "عدد الغرف",
                    controller: widget.roomsController,
                    onCountChanged: widget.onRoomsChanged,
                  ),
                  ContainerBedsCounter(
                    text: "عدد الحمامات",
                    controller: widget.bathroomsController,
                    onCountChanged: widget.onBathroomsChanged,
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

class ContainerBedsCounter extends StatefulWidget {
  const ContainerBedsCounter({
    super.key,
    required this.text,
    this.controller,
    this.onCountChanged,
  });

  final String text;
  final TextEditingController? controller;
  final ValueChanged<int>? onCountChanged;

  @override
  State<ContainerBedsCounter> createState() => _ContainerBedsCounterState();
}

class _ContainerBedsCounterState extends State<ContainerBedsCounter> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      count = int.tryParse(widget.controller!.text) ?? 0;
    } else if (widget.controller != null) {
      widget.controller!.text = count.toString();
    }
  }

  void _updateCount(int newCount) {
    setState(() {
      count = newCount;
      if (widget.controller != null) {
        widget.controller!.text = count.toString();
      }
      widget.onCountChanged?.call(count);
    });
  }

  void add() {
    _updateCount(count + 1);
  }

  void remove() {
    if (count > 0) {
      _updateCount(count - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryGreen, width: 1),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          children: [
            Text(
              widget.text,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),

            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: add,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryGreen,
                    radius: 12,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),

                Text(
                  count.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),

                GestureDetector(
                  onTap: remove,
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryGreen,
                    radius: 12,
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
