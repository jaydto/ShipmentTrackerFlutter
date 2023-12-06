import 'package:flutter/material.dart';

import 'package:shipment_tracker/constants/Theme.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback
      onTap; // Use VoidCallback for functions that take no arguments and return nothing
  final bool isSelected;
  final Color iconColor;

  DrawerTile(
      {required this.title,
      required this.icon,
      required this.onTap,
      this.isSelected = false,
      this.iconColor = ShipmentTrackerColors.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: isSelected
                  ? ShipmentTrackerColors.primary
                  : ShipmentTrackerColors.bgColorBottomNavigations,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Icon(icon,
                  size: 20,
                  color: isSelected ? ShipmentTrackerColors.white : iconColor),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: 15,
                        color: isSelected
                            ? ShipmentTrackerColors.white
                            : ShipmentTrackerColors.muted)),
              )
            ],
          )),
    );
  }
}
