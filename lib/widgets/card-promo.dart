import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';

class CardPromo extends StatelessWidget {
  CardPromo(
      {this.id = 1,
      this.title = "Placeholder Title",
      required this.actions,
      this.img = "https://via.placeholder.com/200",
      this.tap = defaultFunc});

  final List<dynamic> actions;
  final String img;
  final Function tap;
  final String title;
  final int id;

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
            color: ShipmentTrackerColors.bgColorBottomNav,
            shadowColor: const Color.fromARGB(255, 84, 107, 127),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 2,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0),
                        ),
                        image: DecorationImage(
                            fit: BoxFit
                                .fill, // Maintain aspect ratio and crop if needed
                            image: img.startsWith('http')
                                ? NetworkImage(img)
                                : AssetImage(img) as ImageProvider<
                                    Object>, // Load local asset
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
                                  color: ShipmentTrackerColors.white, fontSize: 13)),
                          Padding(
                            padding: EdgeInsets.only(left: 2, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: actions.map((action) {
                                return GestureDetector(
                                  onTap: () {
                                    if (action['actionType'] == 'Read More') {
                                      Navigator.pushNamed(context, '/promo',
                                          arguments: {'id': id});
                                    } else {
                                      Navigator.pushNamed(
                                          context, action['action']);
                                    }
                                  },
                                  child: Text(
                                    action['actionType'],
                                    style: TextStyle(
                                      color: action['actionType'] == 'Read More'
                                          ? ShipmentTrackerColors.primary
                                          : const Color.fromARGB(
                                              255, 255, 127, 7),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            )),
      ),
    ));
  }
}
