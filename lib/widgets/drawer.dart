import 'package:shipment_tracker/screens/home.dart';
import 'package:shipment_tracker/screens/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shipment_tracker/constants/Theme.dart';

import 'package:shipment_tracker/widgets/drawer-tile.dart';

class ShipmentTrackerDrawer extends StatelessWidget {
  final String currentPage;

  ShipmentTrackerDrawer({required this.currentPage});

  _launchURL(String url) async {
    final Uri _url = Uri.parse(url);

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: ShipmentTrackerColors.bgColorBottomNavigations,
      child: Column(children: [
        Container(
            child: SafeArea(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 10),
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.fitWidth))),
            ),
          ),
        )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 8, left: 16, right: 16),
            children: [
              DrawerTile(
                  icon: Icons.home,
                  onTap: () {
                    if (currentPage != "Home")
                      // Navigator.pushReplacementNamed(context, '/home');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                  },
                  iconColor: ShipmentTrackerColors.primary_icons,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: Icons.pie_chart,
                  onTap: () {
                    if (currentPage != "Profile")
                      // Navigator.pushReplacementNamed(context, '/profile');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                  },
                  iconColor: ShipmentTrackerColors.primary_icons,
                  title: "Profile",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: Icons.account_circle,
                  onTap: () {
                    // if (currentPage != "Signup")
                      // Navigator.push(context,
                          // MaterialPageRoute(builder: (context) => Signup()));
                  },
                  iconColor: ShipmentTrackerColors.primary_icons,
                  title: "Signup",
                  isSelected: currentPage == "Signup" ? true : false),
              DrawerTile(
                  icon: Icons.apps,
                  onTap: () {
                    if (currentPage != "Articles")
                      Navigator.pushReplacementNamed(context, '/articles');
                  },
                  iconColor: ShipmentTrackerColors.primary_icons,
                  title: "Articles",
                  isSelected: currentPage == "Articles" ? true : false),
              DrawerTile(
                icon: Icons.play_arrow,
                onTap: () {
                  if (currentPage != "Promotions")
                    Navigator.pushReplacementNamed(context, '/promotions');
                },
                iconColor: ShipmentTrackerColors.primary_icons,
                title: "Promotions",
                isSelected: currentPage == "Promotions" ? true : false,
              ),
              DrawerTile(
                icon: Icons.phone,
                onTap: () => _launchURL("tel:0701087777"),
                iconColor: ShipmentTrackerColors.primary_icons,
                title: "Call Us",
                isSelected: currentPage == "Call Customer Care" ? true : false,
              ),
              DrawerTile(
                icon: Icons.add_call,
                onTap: () => _launchURL("https://wa.me/+254701087777"),
                iconColor: ShipmentTrackerColors.primary_icons,
                title: "Whatsup Us",
                isSelected: currentPage == "Call Customer Care" ? true : false,
              ),
              
              DrawerTile(
                icon: Icons.question_answer,
                onTap: () {
                  if (currentPage != "Help")
                    Navigator.pushReplacementNamed(context, '/help');
                },
                iconColor: ShipmentTrackerColors.primary_icons,
                title: "Help",
                isSelected: currentPage == "Help" ? true : false,
              ),
              DrawerTile(
                icon: Icons.logout,
                onTap: () {
                  // Handle logout logic here
                },
                iconColor: ShipmentTrackerColors.primary_icons,
                title: "Logout",
                isSelected: currentPage == "Logout" ? true : false,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 24, bottom: 8),
                      child: Text(
                        "Terms And Conditions",
                        style: TextStyle(
                          color: ShipmentTrackerColors.muted,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    // Add "Terms and Conditions" tile
                    DrawerTile(
                      icon: Icons.library_books,
                      onTap: () {
                        Navigator.pushNamed(context, '/terms-and-conditions');
                        // Handle "Terms and Conditions" here
                      },
                      iconColor: ShipmentTrackerColors.primary_icons,
                      title: "Terms and Conditions",
                      isSelected:
                          currentPage == "Terms and Conditions" ? true : false,
                    ),
                    // Add "Cookie Policy" tile
                   
                   
                  ],
                ),
              ), // Legal section
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 24, bottom: 8),
                      child: Text(
                        "LEGAL",
                        style: TextStyle(
                          color: ShipmentTrackerColors.muted,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // Add "Dispute Resolution" tile
                    
                    DrawerTile(
                      icon: Icons.access_time_filled,
                      onTap: () {
                        // Handle "Dispute Resolution" here
                        Navigator.pushNamed(context, '/privacy-policy');
                      },
                      iconColor: ShipmentTrackerColors.primary_icons,
                      title: "Privacy Policy",
                      isSelected:
                          currentPage == "Privacy Policy" ? true : false,
                    ),
                    // Add "Anti-Money Laundering" tile
                   
                  ],
                ),
              ), // Licensing section
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 24, bottom: 8),
                      child: Text(
                        "LICENSING",
                        style: TextStyle(
                          color: ShipmentTrackerColors.muted,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // Add "Licensing" tile
                    DrawerTile(
                      icon: Icons.policy,
                      onTap: () {
                        // Handle "Licensing" here
                      },
                      iconColor: ShipmentTrackerColors.primary_icons,
                      title: "Licensing",
                      isSelected: currentPage == "Licensing" ? true : false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
