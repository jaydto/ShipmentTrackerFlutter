import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final VoidCallback?
      onTap; // Use VoidCallback for functions that take no arguments and return nothing
  final ValueChanged<String>?
      onChanged; // Use ValueChanged<String>? for onChanged
  final TextEditingController? controller;
  final bool autofocus;
  final Color borderColor;

  Input({
    required this.placeholder,
    this.suffixIcon = const SizedBox.shrink(),
    this.prefixIcon =
        const SizedBox.shrink(), // Use SizedBox.shrink() as the default value
    this.onTap,
    this.onChanged, // Make onChanged optional
    this.autofocus = false,
    this.borderColor = ShipmentTrackerColors.border,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: ShipmentTrackerColors.muted,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        autofocus: autofocus,
        style: TextStyle(
            height: 0.85, fontSize: 14.0, color: ShipmentTrackerColors.initial),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: ShipmentTrackerColors.white,
            hintStyle: TextStyle(
              color: ShipmentTrackerColors.muted,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
