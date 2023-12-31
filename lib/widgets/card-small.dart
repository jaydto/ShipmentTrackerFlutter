import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';

class CardSmall extends StatelessWidget {
  CardSmall(
      {this.title = "Placeholder Title",
      this.cta = "",
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final String cta;
  final String img;
  final Function tap;
  final String title;

  static void defaultFunc() {
    // print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
      height: 235,
      child: GestureDetector(
        onTap: () {
          tap(); // Call the tap function here
        },
        child: Card(
            elevation: 0.4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0),
                        ),
                        image: DecorationImage(
                            image: img.startsWith('http')
                                ? NetworkImage(img)
                                : AssetImage(img) as ImageProvider<
                                    Object>, // Load local asset
                            fit: BoxFit.cover,
                            alignment: Alignment.center),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: ShipmentTrackerColors.header, fontSize: 13)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(cta,
                                style: TextStyle(
                                    color: ShipmentTrackerColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ))
              ],
            )),
      ),
    ));
  }
}
