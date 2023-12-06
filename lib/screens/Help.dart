import 'dart:convert';

import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/widgets/auth/custom_navbar.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class DataItem {
  String title;
  String expandedValue;
  String definitions;

  DataItem({
    required this.title,
    required this.expandedValue,
    required this.definitions,
  });
}

class Item {
  Item({
    required this.headerValue,
    required this.data,
    this.isExpanded = false,
  });

  String headerValue;
  List<DataItem> data;
  bool isExpanded;
}

class _HelpState extends State<Help> {
  List<Item> _sections = [];

  Future<List<Item>> loadItems() async {
    final String data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/help.json');
    final List<dynamic> jsonData = json.decode(data);

    List<Item> items = jsonData.map((itemData) {
      List<DataItem> dataItems =
          (itemData['data'] as List<dynamic>).map((dataItem) {
        return DataItem(
          title: dataItem['title'],
          expandedValue: dataItem['expandedValue'],
          definitions: dataItem['definitions'],
        );
      }).toList();

      return Item(
        headerValue: itemData['headerValue'],
        data: dataItems,
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
        child: CustomAppBar(title: 'T&C'),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'These General Terms and Conditions are effective from 01.12.2021',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Theme(
              data: ThemeData(brightness: Brightness.dark),
              child: Column(
                children: _sections.map<Widget>((Item item) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(item.headerValue,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ),
                      ExpansionPanelList(
                        expandIconColor: ShipmentTrackerColors.white,
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            _sections[index].isExpanded = isExpanded;
                          });
                        },
                        children:
                            item.data.map<ExpansionPanel>((DataItem dataItem) {
                          return ExpansionPanel(
                            canTapOnHeader: true,
                            backgroundColor: ShipmentTrackerColors.bgColorScreen,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text(dataItem.title,
                                    style: TextStyle(color: Colors.white)),
                              );
                            },
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dataItem.expandedValue,
                                    style: TextStyle(color: Colors.white)),
                                Text(dataItem.definitions,
                                    style: TextStyle(
                                        color: ShipmentTrackerColors.muted)),
                              ],
                            ),
                            isExpanded: item.isExpanded,
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
