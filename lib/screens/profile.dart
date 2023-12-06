import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shipment_tracker/screens/bottomNavigations.dart';
import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';

//widgets
import 'package:shipment_tracker/widgets/navbar.dart';
import 'package:shipment_tracker/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<bool> _launchURL(String url) async {
    if (url != null && url.isNotEmpty) {
      final Uri _url = Uri.parse(url);

      if (await canLaunch(_url.toString())) {
        await launch(_url.toString());
        return true; // Successfully launched
      } else {
        return false; // Failed to launch
      }
    } else {
      return false; // Invalid URL
    }
  }


void _showContactSupportDialog(String type) {
  String phoneNumber = '+254795983399'; // Replace with the actual phone number
  bool copiedSuccessfully = false;
  Timer? timer; // Declare a Timer variable

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('CONNECT'),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  Text('If you need assistance, please $type me:'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: phoneNumber));
                          setState(() {
                            copiedSuccessfully = true;
                          });

                          // Reset the state after 3 seconds
                          timer = Timer(Duration(seconds: 3), () {
                            setState(() {
                              copiedSuccessfully = false;
                            });
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              phoneNumber,
                              style: TextStyle(
                                color: Colors.blue, // You can use a different color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!copiedSuccessfully)
                              SizedBox(width: 10),
                            if (!copiedSuccessfully)
                              Icon(
                                Icons.content_paste_rounded,
                                color: Colors.blue,
                              ),
                          ],
                        ),
                      ),
                      if (copiedSuccessfully)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('copied', style: TextStyle(color: Colors.green)),
                            SizedBox(width: 10),
                            Icon(
                              Icons.check_box_rounded,
                              color: Colors.green,
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Cancel the timer when the dialog is closed
                  timer?.cancel();
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar:  AppBar(
          title: Text('Profile'),
          centerTitle: true,
          toolbarHeight: 60.0, // Adjust the height as needed
          backgroundColor: ShipmentTrackerColors.textAqua,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              // back button logic here
              Navigator.pushNamed(context, '/');
            },
          ),
        ),
        backgroundColor: ShipmentTrackerColors.bgColorScreen,
        bottomNavigationBar: BottomNavigation(
          currentPage: 3,
        ),
        body: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: ShipmentTrackerColors.bgColorScreen,
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        ShipmentTrackerColors
                            .bgColorScreen, // Change this color to the desired color
                        BlendMode.modulate,
                      ),
                      alignment: Alignment.topCenter,
                      image: AssetImage("assets/img/profile-screen-bg.png"),
                      fit: BoxFit.fitWidth))),
          SafeArea(
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 4.0, right: 4.0, top: 74.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Card(
                            color: ShipmentTrackerColors.bgColorScreen,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: .0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 85.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    ShipmentTrackerColors.info,
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: TextButton(
                                                onPressed: () async {
                                                  bool launchSuccess =
                                                      await _launchURL(
                                                          "tel:0795983399");
                                                  if (!launchSuccess) {
                                                    _showContactSupportDialog('Call');
                                                  }
                                                },
                                                child: Text(
                                                  'CONNECT',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .blue, // You can use a different color
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            ),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ShipmentTrackerColors
                                                    .initial,
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: TextButton(
                                                onPressed: () async {
                                                  bool launchSuccess =
                                                      await _launchURL(
                                                          "https://wa.me/+254701087777");
                                                  if (!launchSuccess) {
                                                    _showContactSupportDialog('whatsap');
                                                  }
                                                },
                                                child: Text(
                                                  "MESSAGE",
                                                  style: TextStyle(
                                                      color:
                                                          ShipmentTrackerColors
                                                              .white,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                  vertical: 8.0),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text("2K",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Orders",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("10",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Photos",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("89",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            82, 95, 127, 1),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Comments",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 12.0))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 40.0),
                                        Align(
                                          child: Text("John Chege, 27",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 28.0)),
                                        ),
                                        SizedBox(height: 10.0),
                                        Align(
                                          child: Text("Nairobi, Kenya",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      50, 50, 93, 1),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w200)),
                                        ),
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 32.0, right: 32.0),
                                          child: Align(
                                            child: Text(
                                                "A Software Engineer of Considerable talent...",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        82, 95, 127, 1),
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                        Align(
                                            child: Text("Show more",
                                                style: TextStyle(
                                                    color: ShipmentTrackerColors
                                                        .primary,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0))),
                                        SizedBox(height: 25.0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 25.0, left: 25.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Album",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                    color: ShipmentTrackerColors
                                                        .text),
                                              ),
                                              Text(
                                                "View All",
                                                style: TextStyle(
                                                    color: ShipmentTrackerColors
                                                        .primary,
                                                    fontSize: 13.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 250,
                                          child: GridView.count(
                                              primary: false,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.0,
                                                  vertical: 15.0),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 3,
                                              children: <Widget>[
                                                Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6.0)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                                          fit: BoxFit.cover),
                                                    )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80"),
                                                      fit: BoxFit.cover),
                                                )),
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      FractionalTranslation(
                          translation: Offset(0.0, -0.5),
                          child: Align(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  "assets/images/john-screen-avatar.jpg"),
                              radius: 65.0,
                              // maxRadius: 200.0,
                            ),
                            alignment: FractionalOffset(0.5, 0.0),
                          ))
                    ]),
                  ],
                ),
              ),
            ]),
          )
        ]));
  }
}
