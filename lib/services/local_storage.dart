import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final now = () => DateTime.now().millisecondsSinceEpoch;

Future<dynamic> getFromLocalStorage(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final entry = prefs.getString(key);
  // print('entry $entry');

  if (entry == null) {
    return null;
  }

  final entryData = Map<String, dynamic>.from(json.decode(entry));
  final expiry = entryData['now'] + entryData['ttl'];

  if (entryData['ttl'] != null && expiry < now()) {
    await prefs.remove(key);
    return null;
  }

  return entryData['value'];
}

Future<void> setLocalStorage(String key, dynamic value,
    [int ttl = 2629800000]) async {
  final prefs = await SharedPreferences.getInstance();
  final entryData = {
    'ttl': ttl,
    'now': now(),
    'value': value,
  };
  await prefs.setString(key, json.encode(entryData));
}

Future<Map<int, Map<String, dynamic>>> removeFromSlip(
    int matchId, String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentSlipString = prefs.getString(key) ?? '{}';

  // Convert the JSON string to a Map with String keys
  Map<String, dynamic> currentSlip = jsonDecode(currentSlipString);

  // Remove the entry with the specified matchId
  currentSlip.remove(matchId.toString());

  // Convert the Map back to JSON
  String updatedSlipString = jsonEncode(currentSlip);

  // Update the SharedPreferences
  prefs.setString(key, updatedSlipString);

  // Convert currentSlip to Map<int, Map<String, dynamic>> before returning
  Map<int, Map<String, dynamic>> convertedCurrentSlip = currentSlip.map(
    (key, value) => MapEntry(int.parse(key), Map<String, dynamic>.from(value)),
  );

  // Print the converted currentSlip
  print(convertedCurrentSlip);

  // Return the updated currentSlip
  return convertedCurrentSlip;
}

Future<Map<int, Map<String, dynamic>>> addToSlip(
    Map<int, Map<String, dynamic>> slip, String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentSlipString = prefs.getString(key) ?? '{}';

  dynamic decodedData = jsonDecode(currentSlipString);
  Map<String, dynamic> currentSlip;

  if (decodedData is Map<String, dynamic>) {
    currentSlip = decodedData;
  } else {
    currentSlip = {};
  }

  final int matchId = slip.keys.first; // Assuming 'match_id' is the key

  // Convert inner map to standard map
  Map<String, dynamic> standardInnerMap = {};
  slip[matchId]!.forEach((key, value) {
    standardInnerMap[key] = value;
  });

  // Update the outer map directly
  currentSlip[matchId.toString()] = Map<String, dynamic>.from(standardInnerMap);

  // Convert the Map back to JSON
  String jsonString = jsonEncode(currentSlip);
  prefs.setString(key, jsonString);

  // Convert keys back to int
  Map<int, Map<String, dynamic>> result = currentSlip.map(
    (key, value) => MapEntry(int.parse(key), Map<String, dynamic>.from(value)),
  );

  return result;
}

Future<Map<String, dynamic>> addToKironSlip(Map<String, dynamic> slip) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentSlipString = prefs.getString('kironbetslip') ?? '{}';
  Map<String, dynamic> currentSlip = jsonDecode(currentSlipString);

  if (currentSlip != null) {
    currentSlip[slip['parent_match_id']] = slip;
  } else {
    currentSlip = {slip['parent_match_id']: slip};
  }

  String updatedSlipString = jsonEncode(currentSlip);
  prefs.setString('kironbetslip', updatedSlipString);

  return currentSlip;
}

Future<Map<String, dynamic>> getKironSlip() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentSlipString = prefs.getString('kironbetslip') ?? '{}';
  return jsonDecode(currentSlipString);
}

Future<Map<String, dynamic>> removeFromKironSlip(String parentMatchId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentSlipString = prefs.getString('kironbetslip') ?? '{}';
  Map<String, dynamic> currentSlip = jsonDecode(currentSlipString);

  currentSlip.remove(parentMatchId);

  String updatedSlipString = jsonEncode(currentSlip);
  prefs.setString('kironbetslip', updatedSlipString);

  return currentSlip;
}

Future<void> clearSlip(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<Map<int, Map<String, dynamic>>> getBetslip() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentSlipString = prefs.getString('betslip') ?? '{}';
  Map<String, dynamic> currentSlip = jsonDecode(currentSlipString);

  // Convert keys back to int
  Map<int, Map<String, dynamic>> result = currentSlip.map(
    (key, value) => MapEntry(int.parse(key), Map<String, dynamic>.from(value)),
  );

  return result;
}

Future<Map<int, Map<String, dynamic>>> getJackpotBetslip() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentSlipString = prefs.getString('jpbetslip') ?? '{}';
  Map<String, dynamic> currentSlip = jsonDecode(currentSlipString);

  // Convert keys back to int
  Map<int, Map<String, dynamic>> result = currentSlip.map(
    (key, value) => MapEntry(int.parse(key), Map<String, dynamic>.from(value)),
  );

  return result;
}

Future<Map<String, dynamic>> addToJackpotSlip(Map<String, dynamic> slip) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentSlipString = prefs.getString('jackpotbetslip') ?? '{}';
  Map<String, dynamic> currentSlip = jsonDecode(currentSlipString);

  if (currentSlip.length != 0) {
    currentSlip[slip['match_id']] = slip;
  } else {
    currentSlip = {slip['match_id']: slip};
  }

  String updatedSlipString = jsonEncode(currentSlip);
  prefs.setString('jackpotbetslip', updatedSlipString);

  return currentSlip;
}

Future<Map<String, dynamic>> removeFromJackpotSlip(String matchId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String currentSlipString = prefs.getString('jackpotbetslip') ?? '{}';
  Map<String, dynamic> currentSlip = jsonDecode(currentSlipString);

  currentSlip.remove(matchId);

  String updatedSlipString = jsonEncode(currentSlip);
  prefs.setString('jackpotbetslip', updatedSlipString);

  return currentSlip;
}

Future<void> clearJackpotSlip() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('jackpotbetslip');
}

Future<void> clearKironSlip() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('kironbetslip');
}

Future<void> removeItem(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

Map<String, dynamic> setTrackingData(Map<String, dynamic> data) {
  final utmSource = getFromLocalStorage('utm_source');
  final utmCampaign = getFromLocalStorage('utm_campaign');

  data['utm_source'] = utmSource;

  final bTag = getFromLocalStorage('btag');

  data['btag'] = bTag;

  data['utm_campaign'] = utmCampaign;

  return data;
}

Future<void> clearTrackingData() async {
  await setLocalStorage('utm_source', null);
  await setLocalStorage('utm_campaign', null);
}

// Function to format a number
String formatNumber(dynamic number) {
  if (number == null || number == 0) {
    return '0.00';
  }
  return number
      .toString()
      .replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (match) => '${match.group(1)},',
      )
      .replaceAll('.00', '');
}
