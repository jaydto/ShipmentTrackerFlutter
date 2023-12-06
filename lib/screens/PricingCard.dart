import 'package:flutter/material.dart';
import 'package:shipment_tracker/constants/Theme.dart';

class PricingCard extends StatefulWidget {
  final Map<String, dynamic> payload;

  PricingCard({required this.payload});

  @override
  _PricingCardState createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard>
    with TickerProviderStateMixin {
  late AnimationController _successImageController;
  late AnimationController _priceAnimationController;
  late Animation<double> _priceAnimation;

  @override
  void initState() {
    super.initState();

    _successImageController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _priceAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _priceAnimation = Tween<double>(
      begin: 0,
      end: widget.payload['price'].toDouble(),
    ).animate(_priceAnimationController);

    // Start the animations
    _successImageController.forward();
    _priceAnimationController.forward();
  }

  @override
  void dispose() {
    _successImageController.dispose();
    _priceAnimationController.dispose();
    super.dispose();
  }

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
     
      body: Container(
        color: ShipmentTrackerColors.textAqua,
        child: SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 205, 212, 220),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _successImageController,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                     Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Text(
                          'Total Estimated Amount',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                      
                        
                      ],
                    ),
                  ),
                
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: widget.payload['price'].toDouble()),
                    duration: Duration(seconds: 3),
                    builder: (context, value, child) {
                      return Text(
                        '\$${value.toStringAsFixed(2)} USD', // Format the price as needed
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green
                        ),
                      );
                    },
                    onEnd: () {
                      // You can add additional actions when the animation ends
                    },
                  ),
                  SizedBox(height: 20),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child:Text(
                          'This amount is estimated and will vary if you change your location or weight.',
                          style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: btn_style,
                          onPressed: () {
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          child: Text('Back to Home'),
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
