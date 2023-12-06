import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60.0, // Adjust the height as needed
          backgroundColor: ShipmentTrackerColors.textAqua,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              // back button logic here
              Navigator.pushNamed(context, '/');
            },
          ),
          centerTitle: true,
          title: Text('Calculate')),
      body: Column(
        children: [
          NotificationCard(
            title: 'Arrived',
            description: 'Your package has arrived successfully.',
            icon: Icons.check,
            color: Colors.green,
          ),
          NotificationCard(
            title: 'Failed',
            description: 'There was an issue with your delivery.',
            icon: Icons.clear,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const NotificationCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Adjust the border radius
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
