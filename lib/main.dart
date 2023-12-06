// libraries
import 'dart:io';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shipment_tracker/screens/Calculator.dart';
import 'package:shipment_tracker/screens/LandingPage.dart';
import 'package:shipment_tracker/screens/Maps.dart';
import 'package:shipment_tracker/screens/NotificationsPage.dart';
import 'package:shipment_tracker/screens/PricingCard.dart';
import 'package:shipment_tracker/screens/profile.dart';
import 'package:shipment_tracker/utils/route-observer.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

//Theme
import 'package:shipment_tracker/constants/Theme.dart';

//state
import 'package:shipment_tracker/store/app_state.dart';

//store
import './store/store.dart';

// screens
import 'package:shipment_tracker/screens/home.dart';

// import 'package:shipment_tracker/screens/login.dart';
import 'package:shipment_tracker/screens/Help.dart';

import 'package:shipment_tracker/screens/PrivacyPolicy.dart';

import 'package:shipment_tracker/screens/TermsAndConditions.dart';

void main() {
  runApp(MyApp());
}

//default routes list
Map<String, dynamic> predefinedList = {
  "/": (context) => LandingPage(),
  "/home": (context) => Home(),
  "/maps": (context) => Maps(),
  "/notifications": (context) => NotificationsPage(),
  "/calculate": (context) => Calculator(),
  "/profile": (BuildContext context) => Profile(),
  "/privacy-policy": (BuildContext context) => PrivacyPolicy(),
  "/terms-and-conditions": (BuildContext context) => TermsAndConditions(),
  "/help": (BuildContext context) => Help(),

  // Add other routes and screen classes as needed
};

class MyApp extends StatelessWidget {
  void initDeepLinking(BuildContext context) async {
    // This method handles initial deep link activation
    String? initialLink = await getInitialLink();
    handleDeepLink(context, initialLink!);

    // This method handles subsequent deep link activations
    listenToLinks(context);
  }

  void listenToLinks(BuildContext context) {
    // Check if link stream is available for the current platform
    if (Platform.isAndroid || Platform.isIOS) {
      linkStream.listen((String? link) {
        // Handle subsequent deep link activations
        handleDeepLink(context, link);
      });
    } else {
      print('Link stream is not supported on this platform.');
      // Handle deep links using an alternative method or package
      // For example, you might use JavaScript interop on the web platform.
    }
  }

  void handleDeepLink(BuildContext context, String? link) {
    if (link != null) {
      print('Received deep link: $link');

      // Extract the route from the deep link
      String route = extractRouteFromLink(link);

      // Navigate to the appropriate screen based on the route
      navigateToScreen(context, route);
    }
  }

  String extractRouteFromLink(String link) {
    Uri uri = Uri.parse(link);
    // The path property contains the path after the scheme and authority
    // For example, for "shipment_tracker://shipment_tracker.com/privacy", path will be "/privacy"
    String path = uri.path;

    // Remove the leading "/" and return the dynamic path
    return path.isNotEmpty ? path.substring(1) : '';
  }

  void navigateToScreen(BuildContext context, String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add logic to navigate to the appropriate screen based on the route
      // Ensure that the route starts with "/"
      if (!route.startsWith("/")) {
        route = "/$route";
      }
      // Check if the route is one of the predefined routes
      if (predefinedList.containsKey(route)) {
        Navigator.pushNamed(context, route);
      } else {
        // If the route doesn't match any predefined routes, navigate to a default route (e.g., home page)
        Navigator.pushNamed(context, "/");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Call initDeepLinking when the app starts
    initDeepLinking(context);

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'shipment_tracker',
        theme: ThemeData(
          fontFamily: 'OpenSans',
          scaffoldBackgroundColor: ShipmentTrackerColors.bgColorScreen,
        ),
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{...predefinedList},
        navigatorObservers: [routeObserver], // Add this line
      ),
    );
  }
}
