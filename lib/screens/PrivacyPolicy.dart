import 'dart:convert';

import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/widgets/auth/custom_navbar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.definitions,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  String definitions;
  bool isExpanded;
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  List<Item> _sections = [];

  Future<List<Item>> loadItems() async {
    final String data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/privacy.json');
    final List<dynamic> jsonData = json.decode(data);

    List<Item> items = jsonData.map((itemData) {
      return Item(
        headerValue: itemData['headerValue'],
        expandedValue: itemData['expandedValue'],
        definitions: itemData['definitions'],
      );
    }).toList();

    return items;
  }

  @override
  void initState() {
    super.initState();
    loadItems().then((loadedItems) {
      setState(() {
        _sections = loadedItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShipmentTrackerColors.bgColorScreen,
      appBar: PreferredSize(
        child: CustomAppBar(title: 'Privacy Policy'),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'These Privacy Policies are effective from 01.12.2021',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Theme(
              data: ThemeData(brightness: Brightness.dark),
              child: ExpansionPanelList(
                expandIconColor: ShipmentTrackerColors.white,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _sections[index].isExpanded = isExpanded;
                  });
                },
                children: _sections.map<ExpansionPanel>((Item item) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    backgroundColor: ShipmentTrackerColors.bgColorScreen,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(item.headerValue,
                            style: TextStyle(color: Colors.white)),
                      );
                    },
                    body: ListTile(
                      title: Text(item.expandedValue,
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(item.definitions,
                          style: TextStyle(color: ShipmentTrackerColors.muted)),
                    ),
                    isExpanded: item.isExpanded,
                    // isExpanded: _currentlyExpandedIndex == _books.indexOf(item),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
