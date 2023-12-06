import 'package:flutter/material.dart';

import 'package:shipment_tracker/constants/Theme.dart';

class TableCellSettings extends StatelessWidget {
  final String title;
  final VoidCallback
      onTap; // Use VoidCallback for functions that take no arguments and return nothing
  TableCellSettings({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: ShipmentTrackerColors.text)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios,
                  color: ShipmentTrackerColors.text, size: 14),
            )
          ],
        ),
      ),
    );
  }
}
