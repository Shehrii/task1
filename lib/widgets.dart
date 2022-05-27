import 'package:flutter/material.dart';

customTextField({
  required String? hintText,
  TextEditingController? controller,
  TextInputType? keyboardType,
  Function(String)? onChanged,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
    ),
    keyboardType: keyboardType,
    onChanged: onChanged,
  );
}

customExpandedText({
  required String text,
  bool isBold = false,
}) {
  return Expanded(
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}
