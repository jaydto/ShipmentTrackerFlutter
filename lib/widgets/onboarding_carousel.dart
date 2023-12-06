import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shipment_tracker/constants/Theme.dart';

class OnBoardingCarousel extends StatefulWidget {
  final List<Map<String, String>> imgArray;

  const OnBoardingCarousel({
    Key? key,
    required this.imgArray,
  }) : super(key: key);

  @override
  _OnBoardingCarouselState createState() => _OnBoardingCarouselState();
}

class _OnBoardingCarouselState extends State<OnBoardingCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imgArray.length,
              itemBuilder: (context, index) {
                final item = widget.imgArray[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 250, // Set the width of each card
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ShipmentTrackerColors.white,
                          blurRadius: 8,
                          spreadRadius: 0.3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 249, 246, 246),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["title"]!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: ShipmentTrackerColors.textAqua,
                                    ),
                                  ),
                                  Text(
                                    item["type"]!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: ShipmentTrackerColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 300, // Set the width of the image
                                height: 280, // Set the height of the image
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.asset(
                                    item["img"]!,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Separator Line
          Container(
            height: 4.0,
            margin: EdgeInsets.only(left: 80.0, right: 50),
            width: 150,
            color: ShipmentTrackerColors.textAqua,
          ),
        ],
      ),
    );
  }
}
