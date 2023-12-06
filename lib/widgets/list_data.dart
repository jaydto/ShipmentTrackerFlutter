import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String body;
  final String status;
  final String date;
  final String cost;

  const CustomListTile({
    required this.title,
    required this.body,
    required this.status,
    required this.date,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    print('status received ${status}');
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2.0),
      padding: EdgeInsets.only(left: 2.0, right: 2.0, top: 7.0, bottom: 7.0),
      decoration: BoxDecoration(
        color: ShipmentTrackerColors.bgColorBottomNav,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0, bottom: 3.0),
            child: CustomBadge(status),
          ),
          ListTile(
            title: Container(
              child: Text(title),
              width: 81.0,
              // margin: EdgeInsets.only(right: 180.0),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(body)),
                    Image.asset('assets/images/cubes3.jpg',
                        height: 90, width: 111),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      cost,
                      style: TextStyle(
                          color: ShipmentTrackerColors.textAqua,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 8),
                    Text(date),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBadge extends StatelessWidget {
  final String text;

  const CustomBadge(this.text);

  Color getBadgeColor() {
    switch (text) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return ShipmentTrackerColors.badgeColor;
    }
  }

  IconData getIcon() {
    switch (text) {
      case 'Completed':
        return Icons.check_circle;
      case 'In Progress':
        return Icons.hourglass_bottom;
      case 'Cancelled':
        return Icons.cancel;
      case 'Pending':
        return Icons.access_time;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125.0,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: getBadgeColor(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(getIcon(), color: Colors.white, size: 16),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
