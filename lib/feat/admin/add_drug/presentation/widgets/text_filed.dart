import 'package:flutter/material.dart';

class CusteomFromTextFiledAdmain extends StatelessWidget {
  const CusteomFromTextFiledAdmain({
    super.key,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.keyboardType, 
    required this.controller ,
  });

  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType; 
  final TextEditingController controller; 


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
