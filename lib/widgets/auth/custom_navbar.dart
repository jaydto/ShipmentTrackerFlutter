import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/screens/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  CustomAppBar({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: ShipmentTrackerColors.bgColorBottomNavigations,
        title: Container(
          height: 50,
          child: 
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
                child: Text(
                  widget.title,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                ),
              ),
              Container(
                height: 50,
                width: 110,
                child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ))
                    // Navigator.pushNamed(context, '/'),
                    ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.fitWidth)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
