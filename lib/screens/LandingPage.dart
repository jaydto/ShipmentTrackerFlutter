import 'dart:math';

import 'package:shipment_tracker/screens/Maps.dart';
import 'package:shipment_tracker/screens/bottomNavigations.dart';
import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/utils/shipment_tracker_functions.dart';
//widgets
import 'package:shipment_tracker/widgets/navbar.dart';
import 'package:shipment_tracker/widgets/drawer.dart';
import 'package:shipment_tracker/screens/bottomNavigations.dart';
import 'package:shipment_tracker/widgets/onboarding_carousel.dart';
import 'package:shipment_tracker/widgets/slider-product.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

final List<String> location = [
  'Atlanta, 5343',
  'Chicago, 4040',
  'New York, 2091',
  'Alaska, 11234',
];

final List<String> time = [
  '2 day- 3 days',
  '1 day- 4 days',
  '3 day- 4 days',
  '5 day- 6 days',
];

String getRandomData(dynamic data) {
  final random = Random();
  return data[random.nextInt(data.length)];
}

class _LandingPageState extends State<LandingPage> {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "LandingPage",
        rightOptions: false,
        getCurrentPage: () {}, // Provide a value for getCurrentPage
        searchController:
            TextEditingController(), // Provide a value for searchController
        searchOnChanged: (String newValue) {
          // Handle the changed value here
        },
        // Provide a value for searchOnChanged
        tags: [], // Provide a value for tags
      ),
      backgroundColor: ShipmentTrackerColors.bgColorBottomNav,
      // key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 2.0, left: 8.0),
                child: Text(
                  'Tracking',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text('ShipMent Number',
                                  style: TextStyle(
                                      color: ShipmentTrackerColors.muted,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w200)),
                              SizedBox(width: 8),
                            ],
                          ),
                          subtitle: Text(
                            'NERTYFDSK',
                            style: TextStyle(
                                color: ShipmentTrackerColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          // leading: Icon(Icons.star),
                          trailing: Image.asset(
                            'assets/images/fork_lift.png', // Replace with your image path
                            width: 60,
                            height: 70,
                          ),
                          onTap: () {
                            // Handle list tile tap
                          },
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildListItem(getRandomData(location),
                                'assets/images/inbox.jpg', 'Sender'),
                            SizedBox(
                              height: 30.0,
                            ),
                            _buildDataItem('Time', getRandomData(time)),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildListItem(getRandomData(location),
                                'assets/images/outbox.jpg', 'Receiver'),
                            SizedBox(
                              height: 30.0,
                            ),
                            _buildDataItem('Status', 'Waiting To collect'),
                          ],
                        ),
                        Divider(),
                        InkWell(
                          onTap: () {
                            // Navigator.push(context, '/maps');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Maps()),
                            );
                          },
                          child: Center(
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 40,
                                    color: ShipmentTrackerColors.badgeColor,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Add Stop',
                                    style: TextStyle(
                                        color:
                                            ShipmentTrackerColors.badgeColor),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // Handle add item tap
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Maps()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: OnBoardingCarousel(
                      imgArray: onboardingCards["Music"]?["products"]))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: 0,
      ),
    );
  }
}

Widget _buildListItem(String text, String imagePath, String type) {
  return Row(
    children: [
      Image.asset(
        imagePath,
        width: 40,
        height: 40,
      ),
      SizedBox(width: 4),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type,
              style: TextStyle(
                  color: ShipmentTrackerColors.black,
                  fontWeight: FontWeight.w700)),
          Text(text,
              style: TextStyle(
                  color: ShipmentTrackerColors.muted,
                  fontWeight: FontWeight.w500,
                  fontSize: 12)),
        ],
      ),
    ],
  );
}

Widget _buildDataItem(String text, String info) {
  return Container(
    width: 120.0,
    child: Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: ShipmentTrackerColors.black,
                  fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                //small round badge
                Text(info,
                    style: TextStyle(
                        color: ShipmentTrackerColors.muted,
                        fontWeight: FontWeight.w300,
                        fontSize: 12)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
