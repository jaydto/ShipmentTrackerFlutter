import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shipment_tracker/constants/Theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  double sheetHeight = 0.4;
  TextEditingController startController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  LatLng? startLatLng;
  LatLng? destLatLng;
  String distance = '';

  Future<void> updateMap() async {
    try {
      startLatLng = await getLatLngFromAddress(startController.text);
      destLatLng = await getLatLngFromAddress(destinationController.text);

      setState(() {
        sheetHeight = 0.4; // Reset sheet height
      });
    } catch (e) {
      print('Error updating map: $e');
    }
  }

  Future<LatLng> getLatLngFromAddress(String address) async {
    final locations = await locationFromAddress(address);
    return LatLng(locations.first.latitude, locations.first.longitude);
  }

  // Future<String?> getLocationSuggestion(BuildContext context) async {
  //   final sessionToken = Uuid().v4(); // Use a unique session token
  //   final prediction = await PlacesAutocomplete.show(
  //     context: context,
  //     apiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
  //     sessionToken: sessionToken,
  //     mode: Mode.fullscreen,
  //   );

  //   if (prediction != null && prediction.description.isNotEmpty) {
  //     return prediction.description;
  //   }
  //   return null;
  // }

  List<String> locationSuggestions = [
    'Nairobi, Kenya',
    'Mombasa, Kenya',
    'Kisumu, Kenya',
    'Eldoret, Kenya',
    // Add more locations as needed
  ];

  void showLocationSuggestions(
    TextEditingController controller,
    BuildContext context,
  ) {
    showSearch(
      context: context,
      delegate: LocationSearchDelegate(locationSuggestions),
    ).then((selectedLocation) {
      if (selectedLocation != null) {
        setState(() {
          controller.text = selectedLocation;
        });
      }
    });
  }

  //  Future<void> showLocationSuggestions(
  //   TextEditingController controller,
  //   BuildContext context,
  // ) async {
  //   final suggestions = await getLocationSuggestions(controller.text);
  //   showSearch(
  //     context: context,
  //     delegate: LocationSearchDelegate(suggestions),
  //   ).then((selectedLocation) {
  //     if (selectedLocation != null) {
  //       setState(() {
  //         controller.text = selectedLocation;
  //       });
  //     }
  //   });
  // }

  // Future<List<String>> getLocationSuggestions(String query) async {
  //   final geo = nom.NominatimGeocoding();
  //   final locations = await geo.locationFromAddress(query);
  //   return locations.map((location) => location.toString()).toList();
  // }

  void calculateDistance() async {
    if (startLatLng != null && destLatLng != null) {
      double calculatedDistance = await Geolocator.distanceBetween(
        startLatLng!.latitude,
        startLatLng!.longitude,
        destLatLng!.latitude,
        destLatLng!.longitude,
      );

      setState(() {
        distance = '${(calculatedDistance / 1000).toStringAsFixed(2)} km';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        backgroundColor: ShipmentTrackerColors.textAqua,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            // back button logic here
            Navigator.pushNamed(context, '/');
          },
        ),
        centerTitle: true,
        title: Text('Maps'),
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          // Update the sheet height when dragging vertically
          setState(() {
            sheetHeight -=
                details.primaryDelta! / MediaQuery.of(context).size.height;
            sheetHeight =
                sheetHeight.clamp(0.4, 0.6); // Adjust min and max height
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(-1.2921, 36.8219), // Center of Kenya
                  initialZoom: 6.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  if (startLatLng != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 30,
                          height: 30,
                          point: startLatLng!,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  if (destLatLng != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 30,
                          height: 30,
                          point: destLatLng!,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: sheetHeight,
              minChildSize: 0.2,
              maxChildSize: 0.6,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Add Start Destination',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Add your form fields here
                        TextField(
                          controller: startController,
                          decoration: InputDecoration(
                            labelText: 'Start Position',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.place),
                              onPressed: () async {
                                // String? location =
                                //     await getLocationSuggestion(context);
                                // if (location != null && location.isNotEmpty) {
                                //   setState(() {
                                //     startController.text = location;
                                //   });
                                // }
                                showLocationSuggestions(
                                    startController, context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextField(
                          controller: destinationController,
                          decoration: InputDecoration(
                            labelText: 'Destination Position',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.place),
                              onPressed: () async {
                                // String? location =
                                //     await getLocationSuggestion(context);
                                // if (location != null && location.isNotEmpty) {
                                //   setState(() {
                                //     destinationController.text = location;
                                //   });
                                // }
                                showLocationSuggestions(
                                  destinationController,
                                  context,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),

                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // Button pressed logic
                            updateMap();
                            calculateDistance();
                          },
                          child: Text('Add Destination'),
                        ),
                        Text('Distance: $distance'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LocationSearchDelegate extends SearchDelegate<String> {
  final List<String> suggestions;

  LocationSearchDelegate(this.suggestions);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: ShipmentTrackerColors.textAqua,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ShipmentTrackerColors.white,
        contentPadding: EdgeInsets.symmetric(
            vertical: 14.0, horizontal: 0), // Adjust vertical padding
        labelStyle: TextStyle(
            height: 0), // Set labelStyle height to 0 to remove underline
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(width: 1.0, color: Colors.blueAccent)
            ),
      ),
      // Background color
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black, // Text color
        ),
      ),
      appBarTheme: AppBarTheme(
          elevation: 0, // Remove the shadow
          toolbarHeight: 100, // Set the height of the search bar
          backgroundColor: ShipmentTrackerColors.textAqua),
    );
  }

  

  // @override
  // List<Widget> buildActions(BuildContext context) {
  //   return [
  //     IconButton(
  //       icon: Icon(
  //         Icons.clear,
  //         color: Colors.amber,
  //       ),
  //       onPressed: () {
  //         query = '';
  //       },
  //     ),
  //   ];
  // }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (() {
          close(context, query);
        }),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.amber,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

    @override
  String get searchFieldLabel => 'What are you looking for?';


  

  // @override
  // Widget buildSearchField(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: TextField(
  //             decoration: InputDecoration(
  //               prefixIcon: Icon(Icons.search),
  //               labelText: 'Search',
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
              
  //           ),
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.clear),
  //           onPressed: () {
  //             query = '';
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  

  // @override
  // Widget buildSearchField(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: TextField(
  //       decoration: InputDecoration(
  //         filled: true,
  //         fillColor: ShipmentTrackerColors.white,
  //         contentPadding: EdgeInsets.symmetric(
  //             vertical: 14.0, horizontal: 8), // Adjust vertical padding
  //         labelStyle: TextStyle(
  //             height: 0), // Set labelStyle height to 0 to remove underline
  //         border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(16.0),
  //             borderSide: BorderSide(width: 1.0, color: Colors.blueAccent)),
  //         hintText: 'What are you looking for?',
  //         prefixIcon: Icon(
  //           Icons.search,
  //           color: ShipmentTrackerColors.muted, // Color of the leading icon
  //         ),
  //         suffixIcon: Icon(Icons.qr_code_scanner_rounded,
  //             color: ShipmentTrackerColors.badgeColor),
  //       ),
  //       onChanged: (value) {
  //         // Handle text changes
  //       },
  //     ),
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? suggestions
        : suggestions
            .where((location) =>
                location.toLowerCase().contains(query.toLowerCase()))
            .toList();

    String assetImagePath = 'assets/images/outbox.jpg';

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Adjust the border radius
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int index = 0; index < suggestionList.length; index++)
                Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8, // Adjust the vertical padding
                      ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(assetImagePath),
                      ),
                      title: Text(suggestionList[index]),
                      subtitle: Text("City Location, ${suggestionList[index]}"),
                      onTap: () {
                        close(context, suggestionList[index]);
                      },
                    ),
                    if (index < suggestionList.length - 1)
                      Divider(
                        height: 1, // Adjust the height of the divider
                        thickness: 1, // Adjust the thickness of the divider
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
