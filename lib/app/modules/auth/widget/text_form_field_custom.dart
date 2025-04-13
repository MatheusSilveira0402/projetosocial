import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFieldCustom extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final dynamic controller;
  final dynamic onChanged;
  bool? required = false;
  String? erroText = "";
  IconData? iconData;
  TextFormFieldCustom({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    this.required,
    this.erroText,
    this.iconData
  });
  @override
  Size get preferredSize => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: Icon(iconData),
        prefixIconColor: Colors.grey[600],
      ),
      cursorColor: Colors.black,
      onChanged: onChanged,
      validator:
          required != null
              ? (value) {
                if (value == null || value == "") {
                  return erroText;
                }
                return null;
              }
              : (value) {
                return null;
              },
    );
  }
}
