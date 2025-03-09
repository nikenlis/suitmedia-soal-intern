import 'package:flutter/material.dart';
import 'package:suitmedia/core/theme.dart';

class TextFormFieldItem extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  const TextFormFieldItem({super.key, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: greyTextStyle.copyWith(fontSize: 16, fontWeight: medium, decoration: TextDecoration.none, ),
           filled: true,
          fillColor: whiteColor,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: whiteColor,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(16)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: greenColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(16))),
    );
  }
}
