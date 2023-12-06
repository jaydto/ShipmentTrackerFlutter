import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';

class CardCategory extends StatelessWidget {
  CardCategory(
      {this.title = "Placeholder Title",
      this.img = "https://via.placeholder.com/250",
      this.tap = defaultFunc,
      this.height = 300,
      this.width = null,
      this.overlay = true});

  final String img;
  final Function tap;
  final String title;
  double? height;
  double? width;
  bool overlay;

  static void defaultFunc() {
    // print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              blurRadius: 3.0,
              spreadRadius: 0.2,
              offset: Offset(0, 3))
        ]),
        width: width ?? null,
        child: GestureDetector(
          onTap: () {
            tap(); // Call the tap function here
          },
          child: Card(
              color: ShipmentTrackerColors.bgColorScreen,
              elevation: 0.1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Stack(children: [
                Container(
                    width: width ?? null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: img,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300], // Placeholder color
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )),
                Container(
                    decoration: BoxDecoration(
                        color: overlay ? Colors.black45 : null,
                        borderRadius: BorderRadius.all(Radius.circular(6.0)))),
                Center(
                  child: Text(title,
                      style: TextStyle(
                          color: ShipmentTrackerColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0)),
                )
              ])),
        ));
  }
}
