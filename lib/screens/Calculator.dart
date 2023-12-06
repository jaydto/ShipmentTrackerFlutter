import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/screens/PricingCard.dart';
import 'package:shipment_tracker/screens/home.dart';
import 'package:toastification/toastification.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'location': '',
    'receiver': '',
    'weight_approximation': '',
    'packaging': 'Box',
    'categories': ''
  };

  final List<String> categories = [
    'Documents',
    'Glass',
    'Liquid',
    'Food',
    'Electronic',
    'Product',
    'Other'
  ];
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Perform a random calculation for the price
      final random = Random();
      final randomPrice = 100 +
          random.nextInt(9000); // Generates a random number between 100 and 9000

      // Handle form submission here
      final payload = {
        'location': _formData['location'],
        'receiver': _formData['receiver'],
        'weight_approximation': _formData['weight_approximation'],
        'packaging': _formData['packaging'],
        'categories': _formData['categories'],
        'price': randomPrice,
      };

      // Clear form inputs
      _formKey.currentState!.reset();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PricingCard(payload: payload)),
      );
      // toastification.show(
      //   context: context,
      //   title: 'Success',
      //   icon: const Icon(Icons.check),
      //   description: 'Successful Login',
      //   type: ToastificationType.success,
      //   style: ToastificationStyle.fillColored,
      //   closeButtonShowType: CloseButtonShowType.always,
      //   autoCloseDuration: const Duration(seconds: 5),
      // );
    }
  }

  final TextStyle style = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: ShipmentTrackerColors.black,
  );
  final TextStyle input_text_style = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: ShipmentTrackerColors.muted,
  );
  final TextStyle label_text_style = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: ShipmentTrackerColors.muted,
  );

  String selectedValue = 'Box'; // Store the selected value

  // List of items for the dropdown
  List<String> dropdownItems = ['Box', 'Box Container', 'Large Box'];
  String assetImagePath = 'assets/images/outbox.jpg';

  // Function to show the bottom sheet
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              for (String item in dropdownItems)
                ListTile(
                  title: Text(item),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(assetImagePath),
                  ),
                  onTap: () {
                    // Set the selected value and close the bottom sheet
                    setState(() {
                      selectedValue = item;
                    });
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  int buttonsPerRow = 4; // Adjust this value based on your requirement

  @override
  Widget build(BuildContext context) {
    final ButtonStyle btn_style = ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width * 4.7 / 5, 48.0),
        textStyle: const TextStyle(
            fontFamily: 'Roboto', // Use the Roboto font family
            letterSpacing: 2,
            fontSize: 16,
            color: ShipmentTrackerColors.black,
            fontWeight: FontWeight.w500),
        backgroundColor: Color.fromARGB(255, 245, 145, 4),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)));
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60.0, // Adjust the height as needed
          backgroundColor: ShipmentTrackerColors.textAqua,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              // back button logic here
              Navigator.pushNamed(context, '/');
            },
          ),
          centerTitle: true,
          title: Text('Calculate')),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10.0),
                  child: Text(
                    'Destination',
                    style: TextStyle(
                        color: ShipmentTrackerColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2.0),
                  padding: EdgeInsets.only(
                      left: 2.0, right: 2.0, top: 7.0, bottom: 7.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 6, horizontal: 2.0),
                          padding: EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12.0, bottom: 7.0),
                          decoration: BoxDecoration(
                            color: ShipmentTrackerColors.bgColorBottomNav,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: input_text_style,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        // Border style and color
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue, // Border color
                                          width: 0.5, // Border width
                                        )),
                                    prefixIcon: Container(
                                      width: 51,
                                      margin: EdgeInsets.only(right: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.all_inbox_outlined,
                                              color: const Color.fromARGB(
                                                  255, 120, 118, 118),
                                            ),
                                            onPressed: () {
                                              // handle icon clicked
                                            },
                                          ),
                                          Container(
                                            width: 3.0,
                                            height: 24.0,
                                            child: VerticalDivider(
                                              color: Colors.grey,
                                              thickness: 1.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    labelStyle: input_text_style,
                                    filled:
                                        true, // Set to true to fill the background
                                    fillColor:
                                        const Color.fromARGB(255, 106, 105, 105)
                                            .withOpacity(0.1),
                                    labelText: 'Sender Location',
                                    hintStyle: input_text_style.copyWith(
                                        color: ShipmentTrackerColors.muted)),
                                onSaved: (value) {
                                  _formData['location'] = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Sender location is required';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(height: 18),
                              TextFormField(
                                style: input_text_style,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      // Border style and color
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue, // Border color
                                        width: 2.0, // Border width
                                      )),
                                  filled:
                                      true, // Set to true to fill the background
                                  fillColor:
                                      const Color.fromARGB(255, 106, 105, 105)
                                          .withOpacity(0.1), // Background color
                                  labelText: 'Receiver Location',
                                  labelStyle: input_text_style,
                                  hintStyle: input_text_style.copyWith(
                                      color: ShipmentTrackerColors.white),
                                  prefixIcon: Container(
                                    width: 51,
                                    margin: EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.archive_outlined,
                                            color: const Color.fromARGB(
                                                255, 120, 118, 118),
                                          ),
                                          onPressed: () {
                                            // handle icon clicked
                                          },
                                        ),
                                        Container(
                                          width: 3.0,
                                          height: 24.0,
                                          child: VerticalDivider(
                                            color: Colors.grey,
                                            thickness: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onSaved: (value) {
                                  _formData['receiver'] = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Receiver is required';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(height: 18),
                              TextFormField(
                                style: input_text_style,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      // Border style and color
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue, // Border color
                                        width: 2.0, // Border width
                                      )),
                                  filled:
                                      true, // Set to true to fill the background
                                  fillColor:
                                      const Color.fromARGB(255, 106, 105, 105)
                                          .withOpacity(0.1), // Background color
                                  labelText: 'Approx Weight',
                                  labelStyle: input_text_style,
                                  hintStyle: input_text_style.copyWith(
                                      color: ShipmentTrackerColors.white),
                                  prefixIcon: Container(
                                    width: 51,
                                    margin: EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.balance_outlined,
                                            color: const Color.fromARGB(
                                                255, 120, 118, 118),
                                          ),
                                          onPressed: () {
                                            // handle icon clicked
                                          },
                                        ),
                                        Container(
                                          width: 3.0,
                                          height: 24.0,
                                          child: VerticalDivider(
                                            color: Colors.grey,
                                            thickness: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onSaved: (value) {
                                  _formData['weight_approximation'] = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Approximate Weight is required';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 10.0),
                                child: Text('Packaging',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: ShipmentTrackerColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('What are you sending ?',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: ShipmentTrackerColors.muted,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                        ),
                        // Text form field with GestureDetector to show bottom sheet on tap
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                TextEditingController(text: selectedValue),
                            onTap: _showBottomSheet,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  // Border style and color
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: ShipmentTrackerColors
                                        .muted, // Border color
                                    width: 2.0, // Border width
                                  )),
                              filled:
                                  true, // Set to true to fill the background
                              fillColor:
                                  const Color.fromARGB(255, 106, 105, 105)
                                      .withOpacity(0.1), // Background color
                              labelText: '',
                              labelStyle: input_text_style,
                              hintStyle: input_text_style.copyWith(
                                  color: ShipmentTrackerColors.white),
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 27,
                                color: Color.fromARGB(255, 55, 48, 48),
                              ),
                              prefixIcon: Container(
                                width: 51,
                                margin: EdgeInsets.only(right: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.houseboat_outlined,
                                        color: const Color.fromARGB(
                                            255, 120, 118, 118),
                                      ),
                                      onPressed: () {
                                        // handle icon clicked
                                      },
                                    ),
                                    Container(
                                      width: 3.0,
                                      height: 24.0,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onSaved: (value) {
                              _formData['packaging'] = value;
                            },
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Categories',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: ShipmentTrackerColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('What are you sending ?',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: ShipmentTrackerColors.muted,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                        ),

                        Container(
                          child: Wrap(
                            children: List.generate(categories.length, (index) {
                              bool isActive =
                                  _formData['categories'] == categories[index];

                              return Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1, // Adjust this value
                                      blurRadius: 3, // Adjust this value
                                      offset: Offset(0.5, 0.5),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary: ShipmentTrackerColors.white,
                                    backgroundColor: isActive
                                        ? Color.fromARGB(255, 245, 145, 4)
                                        : Colors.white, // Ch
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                  ),
                                  onPressed: () {
                                    // Your onPressed logic here
                                    setState(() {
                                      _formData['categories'] =
                                          categories[index];
                                    });
                                  },
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      color: isActive
                                          ? ShipmentTrackerColors.black
                                          : ShipmentTrackerColors.muted,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        SizedBox(
                          height: 40.0,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: btn_style,
                            onPressed: _submitForm,
                            child: Text('Calculate',
                                style: TextStyle(
                                    color: ShipmentTrackerColors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
