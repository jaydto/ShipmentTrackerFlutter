import 'dart:async';

import 'package:shipment_tracker/store/app_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shipment_tracker/constants/Theme.dart';

import 'package:shipment_tracker/widgets/input.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  bool searchBar;
  bool searchAvailable;
  bool mobileMenuAvailable;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String>? tags;
  final Function? getCurrentPage;
  final bool isOnSearch;
  final TextEditingController? searchController;
  final ValueChanged<String>? searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  Navbar(
      {Key? key,
      this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags,
      this.transparent = true,
      this.rightOptions = true,
      this.getCurrentPage,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = true,
      this.bgColor = ShipmentTrackerColors.bgColorScreen,
      this.searchBar = false,
      this.searchAvailable = true,
      this.mobileMenuAvailable = true})
      : super(key: key);

  final double _prefferedHeight = 200.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> with AutomaticKeepAliveClientMixin {
  late String activeTag;
  late Timer _timer_live_shipments;

  late StreamController<void> _timerStreamController;

  StreamSubscription<void>? _timerSubscription;

  String selectedLocation = 'Weimer Street'; // Initial value
  List<String> locations = [
    'Weimer Street',
    'NewYork',
    'West Viginia'
  ]; // List of locations

  void startTimer() {
    _timer_live_shipments = Timer.periodic(Duration(seconds: 30), (timer) {
      _timerStreamController.sink.add(null); // Emit an event to the stream
    });
  }

  void stopTimer() {
    print('timer ${_timer_live_shipments.isActive}');
    if (_timer_live_shipments.isActive) {
      _timer_live_shipments.cancel();
      _timerStreamController.close(); // Close the stream
    }
  }

  void initState() {
    super.initState();
    _timerStreamController = StreamController<void>();
    if (widget.tags != null && widget.tags?.length != 0) {
      activeTag = widget.tags![0];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print("Dispose called"); // Add this line

    stopTimer();

    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: locations.map((String value) {
              return ListTile(
                title: Text(value),
                leading: Icon(Icons.place),
                onTap: () {
                  setState(() {
                    selectedLocation = value;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags?.length == 0 ? false : true);

    return Theme(
      data: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,

            fillColor: ShipmentTrackerColors.white,
            contentPadding: EdgeInsets.symmetric(
                vertical: 14.0, horizontal: 8), // Adjust vertical padding
            labelStyle: TextStyle(
                height: 0), // Set labelStyle height to 0 to remove underline
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(width: 1.0, color: Colors.blueAccent)),
          ),
          shadowColor: widget.mobileMenuAvailable
              ? Colors.transparent
              : ShipmentTrackerColors.textAqua),
      child: Container(
          width: double.infinity,
          height: widget.searchBar
              ? 177.5
              : widget.mobileMenuAvailable
                  ? 177.5
                  : 177.5,
          decoration: BoxDecoration(
              color: !widget.transparent
                  ? widget.bgColor
                  : ShipmentTrackerColors.textAqua,
              boxShadow: [
                BoxShadow(
                    color: !widget.transparent && !widget.noShadow
                        ? ShipmentTrackerColors.initial
                        : const Color.fromARGB(0, 48, 25, 25),
                    spreadRadius: -10,
                    blurRadius: 12,
                    offset: Offset(0, 5))
              ]),
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 1.0),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Align children to the right
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: <Widget>[
                              Container(
                                  height: 60,
                                  width: 60,
                                  padding: EdgeInsets.all(25.0),
                                  margin:
                                      EdgeInsets.only(left: 30.0, top: 10.0),
                                  child: GestureDetector(
                                      onTap: (() =>
                                          Navigator.pushNamed(context, '/'))),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/john-screen-avatar.jpg"),
                                          fit: BoxFit.fitWidth))),
                              SizedBox(
                                width: 8.0,
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.green),),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 15.0),
                                      //   decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.red),),
                                      child: Text(
                                        'Your Location',
                                        style: TextStyle(
                                            color: ShipmentTrackerColors.muted,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Container(
                                      height: 20,
                                      //    decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.amber),),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _showBottomSheet(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          elevation: 0, // Remove elevation
                                          minimumSize:
                                              Size(0, 20), // Set minimum height
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${selectedLocation}',
                                              style: TextStyle(
                                                  color: ShipmentTrackerColors
                                                      .white), // Set text color
                                            ),
                                            Icon(Icons.arrow_drop_down,
                                                color: ShipmentTrackerColors
                                                    .white),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 17.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                            3.0), // Adjust padding for the circle size
                                        decoration: BoxDecoration(
                                          color: ShipmentTrackerColors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: ShipmentTrackerColors.muted,
                                            width:
                                                1.0, // Adjust border width as needed
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.notifications_active,
                                            color: (widget.bgColor ==
                                                    ShipmentTrackerColors
                                                        .bgColorScreen
                                                ? ShipmentTrackerColors.muted
                                                : ShipmentTrackerColors.muted),
                                            size:
                                                25.0, // Adjust icon size as needed
                                          ),
                                          onPressed: () async {
                                            // handle notifications
                                            Navigator.pushNamed(
                                                context, '/notifications');
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              3.0), // Adjust padding for the count size
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .red, // Adjust color as needed
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            '2', // Your count value
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  12.0, // Adjust font size as needed
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 4, left: 15, right: 15),
                          child: TextFormField(
                            readOnly: true,
                            onTap: () async {
                              showSearch(
                                  context: context,
                                  delegate: ShipmentSearchField(
                                      shipments_matches: matches,
                                      shipments_suggestions:
                                          matches_suggestions));
                            },
                            controller: widget.searchController,
                            onChanged: widget.searchOnChanged,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: ShipmentTrackerColors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 14.0,
                                  horizontal: 8), // Adjust vertical padding
                              labelStyle: TextStyle(
                                  height:
                                      0), // Set labelStyle height to 0 to remove underline
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.blueAccent)),
                              hintText: 'What are you looking for?',
                              prefixIcon: Icon(
                                Icons.search,
                                color: ShipmentTrackerColors
                                    .muted, // Color of the leading icon
                              ),
                              suffixIcon: Icon(Icons.qr_code_scanner_rounded,
                                  color: ShipmentTrackerColors.badgeColor),
                            ),
                          )),
                    ],
                  ),
                )),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ShipmentSearchField extends SearchDelegate {
  List<String>? shipments_matches;
  List<String>? shipments_suggestions;

  ShipmentSearchField({this.shipments_matches, this.shipments_suggestions});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: ShipmentTrackerColors.textAqua,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ShipmentTrackerColors.white,
        contentPadding: EdgeInsets.symmetric(
            vertical: 14.0, horizontal: 8), // Adjust vertical padding
        labelStyle: TextStyle(
            height: 0), // Set labelStyle height to 0 to remove underline
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(width: 1.0, color: Colors.blueAccent)),
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
  // List<Widget>? buildActions(BuildContext context) {
  //   return [
  //     IconButton(
  //         onPressed: () {
  //           query = '';
  //         },
  //         icon: Icon(
  //           Icons.clear,
  //           color: Colors.amber,
  //         ))
  //   ];
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
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
    final List<String>? matches = shipments_matches
        ?.where(
            (matches) => matches.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: matches!.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: ShipmentTrackerColors.textAqua,
            onTap: () {
              query = matches[index];
              close(context, query);
            },
            title: Text(
              matches[index],
              style: TextStyle(color: Colors.black),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? shipments_suggestions
        : shipments_suggestions
            ?.where((location) =>
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
              for (int index = 0; index < suggestionList!.length; index++)
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

final List<String> matches = ['main', 'mark', 'lead'];
final List<String> matches_suggestions = ['main', 'mark', 'lead'];
