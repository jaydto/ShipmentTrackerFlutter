import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/screens/profile.dart';

import 'package:shipment_tracker/store/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BottomNavigation extends StatefulWidget {
  int? currentPage;

  BottomNavigation({
    Key? key,
    this.currentPage = 0,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late String _calculate;

  @override
  void initState() {
    super.initState();
    _calculate = 'Calculate';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the Redux store and dispatch actions here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            height: 50.0,
            color: ShipmentTrackerColors.bgColorBottomNav,
            child: NavigationBarTheme(
              data: NavigationBarThemeData(
                labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                  (Set<MaterialState> states) {
                    // Check if the selected state is present
                    if (states.contains(MaterialState.selected)) {
                      // Return the TextStyle for the selected state
                      return TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w200,
                        color: ShipmentTrackerColors
                            .black, // Set your selected label color here
                      );
                    } else {
                      // Return the TextStyle for the unselected state
                      return TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w200,
                        color: ShipmentTrackerColors.muted,
                      );
                    }
                  },
                ),
              ),
              child: NavigationBar(
                height: 50.0,
                indicatorColor: Colors.transparent,
                backgroundColor: ShipmentTrackerColors.bgColorBottomNav,
                surfaceTintColor: ShipmentTrackerColors.textAqua,
                selectedIndex: widget.currentPage!,
                onDestinationSelected: (int index) {
                  // Handle navigation based on the index
                  switch (index) {
                    case 0:
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Home()),
                      // );
                      Navigator.pushNamed(context, '/');
                      break;
                    case 1:
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Live()),
                      // );
                      Navigator.pushNamed(context, '/calculate');
                      break;
                    case 2:
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Live()),
                      // );
                      Navigator.pushNamed(context, '/home');
                      break;
                    case 3:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                      break;
                  }
                },
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                destinations: [
                  _buildBottomNavItem(
                    icon: Icons.home_outlined,
                    label: 'Home',
                    isSelected: widget.currentPage ==
                        0, // Add this line to check if the item is selected
                  ),
                  _buildBottomNavItem(
                    icon: Icons.calculate_outlined,
                    label: _calculate,
                    isSelected: widget.currentPage ==
                        1, // Add this line to check if the item is selected
                  ),
                  _buildBottomNavItem(
                    icon: Icons.access_time_outlined,
                    label: 'Shipment',
                    isSelected: widget.currentPage ==
                        2, // Add this line to check if the item is selected
                  ),
                  
                  _buildBottomNavItem(
                    icon: Icons.person,
                    label: 'Profile',
                    isSelected: widget.currentPage ==
                        3, // Add this line to check if the item is selected
                  ),
                ],
              ),
            ));
      
    
        
  }

  NavigationDestination _buildBottomNavItem(
      {IconData? icon,
      String? label,
      bool hide_label = false,
      bool isSelected = false}) {
    return NavigationDestination(
      icon: hide_label
          ? Transform.translate(
              offset: Offset(0.0, 6.0), // Adjust the vertical offset as needed
              child: Transform.scale(
                // scale: 1.3,
                scaleX: 1.3,
                scaleY: 1.3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.circle_rounded,
                      size: 40, // Set the size of the center icon
                      color: ShipmentTrackerColors.textAqua,
                    ),
                    Positioned(
                      top:
                          11, // Adjust the top position to place content above the center icon
                      child: Text(
                        '11',
                        style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? ShipmentTrackerColors.textAqua :ShipmentTrackerColors.muted,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ))
          : FittedBox(
              fit: BoxFit.contain,
              child: Icon(
                icon,
                size: 30,
                color:
                    isSelected ? ShipmentTrackerColors.textAqua : ShipmentTrackerColors.muted,
              ),
            ),
      label: label!,
    );
  }
}
