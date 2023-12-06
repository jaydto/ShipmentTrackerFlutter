import 'dart:async';

import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shipment_tracker/constants/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

class FormatDate extends StatelessWidget {
  final String? start_time;
  final String? match_time;
  final bool live;
  final bool jackpot;

  FormatDate({
    required this.start_time,
    required this.match_time,
    required this.live,
    required this.jackpot,
  });

  @override
  Widget build(BuildContext context) {
    // print('start_time  data $start_time');
    // Extract the date and time components
    final List<String>? dateTimeComponents = start_time?.split(' ');
    final List<String>? dateComponents = dateTimeComponents?[0].split('-');
    final List<String>? timeComponents = dateTimeComponents?[1].split(':');

    if (dateComponents != null && timeComponents != null) {
      final int year = int.parse(dateComponents[0]);
      final int month = int.parse(dateComponents[1]);
      final int day = int.parse(dateComponents[2]);
      final int hour = int.parse(timeComponents[0]);
      final int minute = int.parse(timeComponents[1]);

      final DateTime dateTime = DateTime(year, month, day, hour, minute);

      final formattedDateTime = DateFormat('MMMM d, h:mm a').format(dateTime);

      if (live) {
        return Text(
          match_time!,
          style: TextStyle(color: ShipmentTrackerColors.muted, fontSize: 12),
        );
      } else if (match_time != null) {
        return Text(
          formattedDateTime,
          style: TextStyle(color: ShipmentTrackerColors.muted, fontSize: 12),
        );
      } else if (jackpot) {
        return Text(
          formattedDateTime,
          style: TextStyle(color: ShipmentTrackerColors.muted, fontSize: 12),
        );
      } else {
        return Text(
          formattedDateTime,
          style: TextStyle(color: ShipmentTrackerColors.muted, fontSize: 12),
        );
      }
    } else {
      // Handle the case where the date and time components are not available
      return Text('Invalid Date',
          style: TextStyle(color: ShipmentTrackerColors.muted, fontSize: 12));
    }
  }
}

String formatDate({
  String? start_time,
  String? match_time,
  bool live = false,
  bool jackpot = false,
}) {
  if (live) {
    return match_time ?? '';
  } else {
    if (start_time == null) {
      return '';
    }
    // print('start_time provided $start_time');
    List<String> dateTimeComponents = start_time.split(' ');
    List<String> dateComponents = dateTimeComponents[0].split('-');
    List<String> timeComponents = dateTimeComponents[1].split(':');

    int year = int.tryParse(dateComponents[0]) ?? 0;
    int month = int.tryParse(dateComponents[1]) ?? 1;
    int day = int.tryParse(dateComponents[2]) ?? 1;
    int hour = int.tryParse(timeComponents[0]) ?? 0;
    int minute = int.tryParse(timeComponents[1]) ?? 0;

    // Add leading '0' if the day is less than 10
    String formattedDay = day < 10 ? '0$day' : day.toString();

    String formattedDateTime = '${month}/${formattedDay} ${hour}:${minute}';

    if (match_time != null && match_time.isNotEmpty) {
      return formattedDateTime;
    } else if (jackpot) {
      return formattedDateTime;
    } else {
      return formattedDateTime;
    }
  }
}

final Map<String, Map<String, dynamic>> onboardingCards = {
  "Music": {
    "title": "View article",
    "image":
        "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
    "products": [
      {
        "img": "assets/images/ship.jpg",
        "title": "Ocean Freight",
        "type": "International",
      },
      {
        "img": "assets/images/truck.png",
        "title": "Cargo Freight",
        "type": "Reliable",
      },
      {
        "img": "assets/images/airFreight.jpg",
        "title": "Air Freight",
        "type": "International",
      },
      {
        "img": "assets/images/motorcycle.jpg",
        "title": "Instant Ferier",
        "type": "Local",
      },
    ],
    "suggestions": [
      {
        "img":
            "https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music studio for real..."
      },
      {
        "img":
            "https://images.unsplash.com/photo-1477233534935-f5e6fe7c1159?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music equipment to borrow..."
      },
    ]
  }
};


