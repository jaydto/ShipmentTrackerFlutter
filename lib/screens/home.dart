import 'dart:math';

import 'package:shipment_tracker/screens/bottomNavigations.dart';
import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/widgets/list_data.dart';
//widgets
import 'package:shipment_tracker/widgets/navbar.dart';
import 'package:shipment_tracker/widgets/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final List<String> tabTitles = [
  'All ',
  'Completed',
  'In Progress',
  'Pending Order',
  'Cancelled',
];

final List<String> statusOptions = [
  'Completed',
  'In Progress',
  'Cancelled',
  'Pending Order',
];
final List<String> costs = [
  '\$200 USD',
  '\$1200 USD',
  '\$2300 USD',
  '\$500 USD',
];

final List<String> dates = [
  'Sep 20, 2023',
  'March 20, 2023',
  'Jan 20, 2023',
  'Dec 20, 2023',
];

final List<String> descriptionOptions = [
  'Your Delivery , \n#NRERFAFDFD from Atlanta is arriving Today',
  'Your Delivery , \n#NRSDFTYGHN from Kuwait is arriving Today',
  'Your Delivery , \n#NRDFGBJKLP from Canada is arriving Today',
  'Your Delivery , \n#NRERGHJKPL from Mexico is arriving Today',
];
String getRandomDescriptions() {
  final random = Random();
  return descriptionOptions[random.nextInt(descriptionOptions.length)];
}

String getRandomCost() {
  final random = Random();
  return costs[random.nextInt(costs.length)];
}

String getRandomDates() {
  final random = Random();
  return dates[random.nextInt(dates.length)];
}

String getRandomStatus() {
  final random = Random();
  return statusOptions[random.nextInt(statusOptions.length)];
}

final List<int> tabCounts = [10, 16, 12, 9];

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = new GlobalKey();
  late TabController _tabController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTitles.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: ShipmentTrackerColors.textAqua,
        child: SafeArea(
          child: DefaultTabController(
            length: 5, // Number of tabs
            child: Scaffold(
              backgroundColor: ShipmentTrackerColors.bgColorBottomNav,
              appBar: AppBar(
                toolbarHeight: 75.0, // Adjust the height as needed
                backgroundColor: ShipmentTrackerColors.textAqua,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    // back button logic here
                    Navigator.pushNamed(context, '/');
                  },
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Text('Shipment History'),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: TabBar(
                      controller: _tabController,

                      indicatorColor: ShipmentTrackerColors
                          .badgeColor, // Set the active underline color
                      indicatorWeight:
                          4.0, // Set the width of the active underline
                      isScrollable: true,
                      tabs: [
                        for (int i = 0; i < tabTitles.length; i++)
                          Tab(
                              child: Row(
                            children: [
                              Text(tabTitles[i]),
                              SizedBox(width: 4), // Add some spacing
                              if (i != tabTitles.length - 1)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedTabIndex == i
                                        ? ShipmentTrackerColors.badgeColor
                                        : ShipmentTrackerColors.textAquavariant,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    tabCounts[i].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            ],
                          )),
                      ],
                    ),
                  ),
                ),
              ),
              body:

                  /// The above code is creating a TabBarView widget with multiple tabs. Each tab contains a
                  /// list of items with different statuses. The first tab has specific statuses for all
                  /// items except the first one, while the other tabs have specific statuses for all items.
                  /// The items in the list are displayed using a CustomListTile widget, which shows the
                  /// title, body, status, date, and cost of each item. The number of items in each list can
                  /// be adjusted by changing the itemCount parameter in the ListView.builder.

                  TabBarView(
                children: [
                
                  for (int tabIndex = 0;
                      tabIndex < tabTitles.length;
                      tabIndex++)
                    Container(
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 12.0, top: 10.0, left: 5.0),
                            child: Text(
                              'Shipment',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: ShipmentTrackerColors.black,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  10, // You can adjust the itemCount as needed
                              itemBuilder: (context, index) {
                                return CustomListTile(
                                  title: 'Arriving Today',
                                  body: getRandomDescriptions(),
                                  status: selectedTabIndex==0?getRandomStatus():tabTitles[selectedTabIndex], // Loop through statusOptions
                                  // Loop through statusOptions
                                  date: getRandomDates(),
                                  cost: getRandomCost(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),


            ),
          ),
        ),
      ),
    );
  }
}


