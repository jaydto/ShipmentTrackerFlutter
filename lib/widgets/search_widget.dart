import 'package:shipment_tracker/constants/Theme.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String searchString = '';

  void onSearchTextChanged(String text) {
    setState(() {
      searchString = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 2, right: 2, top: 2),
          child: Container(
              height: 40,
              child: TextField(
                showCursor: true,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.start,
                onChanged: onSearchTextChanged,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 8), // Adjust vertical padding
                  labelStyle: TextStyle(
                      height:
                          0), // Set labelStyle height to 0 to remove underline
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide:
                          BorderSide(width: 1.0, color: Colors.blueAccent)),
                  hintText: 'Search...',
                  fillColor: ShipmentTrackerColors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      // Add your search functionality here
                    },
                  ),
                ),
              )

              //  Row(
              //   children: [
              //     Expanded(
              //       child: TextField(
              //         showCursor: true,
              //         textAlignVertical: TextAlignVertical.center,
              //         textAlign: TextAlign.start,
              //         onChanged: onSearchTextChanged,
              //         decoration: InputDecoration(
              //           hintText: 'Search...',
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10.0),
              //           ),
              //           fillColor: ShipmentTrackerColors.white,
              //           filled: true,
              //         ),
              //       ),
              //     ),
              //     IconButton(
              //       icon: Icon(
              //         Icons.search,
              //         color: Colors.blue,
              //       ),
              //       onPressed: () {
              //         // Add your search functionality here
              //       },
              //     ),
              //   ],
              // )

              //   Padding(
              //     padding: const EdgeInsets.only(left: 8, right: 8),
              //     child: TextField(
              //       showCursor: true,
              //       textAlignVertical: TextAlignVertical.center,
              //       textAlign: TextAlign.start,
              //       onChanged: onSearchTextChanged,
              //       decoration: InputDecoration(
              //         hintText: 'Search...',
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(
              //               10.0), // Set the border radius you want
              //         ),
              //         fillColor: ShipmentTrackerColors.white,
              //         filled: true, // Set to true to
              //         prefixIcon: Icon(Icons.search), // Add the search icon
              //       ),
              //     ),
              //   ),
              // )
              //   ListView.builder(
              //     itemCount: /* Replace with your data source length */ 10,
              //     itemBuilder: (context, index) {
              //       // Replace this with your actual data filtering logic
              //       if (searchString.isEmpty ||
              //           // Check if your data matches the search string
              //           /* Replace with your data filter logic */
              //           'Item $index'.toLowerCase().contains(searchString.toLowerCase())) {
              //         return ListTile(
              //           title: Text('Item $index'),
              //         );
              //       } else {
              //         return Container();
              //       }
              //     },

              ),
        )
      ],
    );
  }
}
