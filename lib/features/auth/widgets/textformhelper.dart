import 'package:flutter/material.dart';

class TextformHelper extends StatelessWidget {
  final String hintText;
  final bool ispass;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  const TextformHelper(
      {Key? key,
      required this.hintText,
      required this.ispass,
      required this.textInputType,
      required this.textInputAction,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter $hintText";
            }
            return null;
          },
          obscureText: ispass,
          controller: controller,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.only(left: 10),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
