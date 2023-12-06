import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/screens/VerifyAccount.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController msisdnController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  int currentStep = 0;
  bool showPassword = false;
  bool termsAndConditionsChecked = false;

  final _msisdnFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _referralCodeFormKey = GlobalKey<FormState>();

  final TextStyle input_text_style = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: ShipmentTrackerColors.muted,
  );

  final ButtonStyle btn_style = ElevatedButton.styleFrom(
      minimumSize: Size(350, 45.0),
      textStyle: const TextStyle(
          fontFamily: 'Roboto', // Use the Roboto font family

          letterSpacing: 2,
          fontSize: 15,
          color: ShipmentTrackerColors.black,
          fontWeight: FontWeight.w500),
      backgroundColor: ShipmentTrackerColors.defaultBtnColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)));

  final ButtonStyle btn_style_disabled = ElevatedButton.styleFrom(
      minimumSize: Size(350, 45.0),
      textStyle: const TextStyle(
          fontFamily: 'Roboto', // Use the Roboto font family

          letterSpacing: 2,
          fontSize: 15,
          color: ShipmentTrackerColors.black,
          fontWeight: FontWeight.w500),
      backgroundColor: ShipmentTrackerColors.muted,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)));

  final ButtonStyle btn_normal_style = ElevatedButton.styleFrom(
      minimumSize: Size(50, 45.0),
      textStyle: const TextStyle(
          fontFamily: 'Roboto', // Use the Roboto font family

          letterSpacing: 2,
          fontSize: 15,
          color: ShipmentTrackerColors.black,
          fontWeight: FontWeight.w500),
      backgroundColor: ShipmentTrackerColors.defaultBtnColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)));
  final ButtonStyle btn_prev_style = ElevatedButton.styleFrom(
      minimumSize: Size(50, 45.0),
      textStyle: const TextStyle(
          fontFamily: 'Roboto', // Use the Roboto font family

          letterSpacing: 2,
          fontSize: 15,
          color: ShipmentTrackerColors.white,
          fontWeight: FontWeight.w500),
      backgroundColor: ShipmentTrackerColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)));

  List<Step> getSteps() => [
        Step(
          state: currentStep <= 0 ? StepState.indexed : StepState.complete,
          isActive: currentStep >= 0,
          title: Text(
            'Phone Number',
            style: TextStyle(color: ShipmentTrackerColors.white),
          ),
          content: Form(
            key: _msisdnFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  style: input_text_style,
                  controller: msisdnController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        // Border style and color
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color
                          width: 0.5, // Border width
                        )),
                    labelText: 'phone number',
                    labelStyle: input_text_style,
                    filled: true, // Set to true to fill the background
                    fillColor: const Color.fromARGB(255, 14, 21, 27),
                  ),
                  validator: (value) {
                    final msisdnPattern = RegExp(r'(254|0|)?[71]\d{8}');
                    if (value!.isEmpty) {
                      return 'MSISDN is required';
                    }
                    if (!msisdnPattern.hasMatch(value)) {
                      return 'Invalid MSISDN format';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
        Step(
          title:
              Text('Passwords', style: TextStyle(color: ShipmentTrackerColors.white)),
          state: currentStep <= 1 ? StepState.indexed : StepState.complete,
          isActive: currentStep >= 1,
          content: Form(
            key: _passwordFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  style: input_text_style,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        // Border style and color
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color
                          width: 0.5, // Border width
                        )),
                    labelText: 'Password',
                    labelStyle: input_text_style,
                    filled: true, // Set to true to fill the background
                    fillColor: const Color.fromARGB(255, 14, 21, 27),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white10,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !showPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 4)
                      return 'Password  Length must be greater or equal to 4';
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: input_text_style,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        // Border style and color
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color
                          width: 0.5, // Border width
                        )),
                    labelStyle: input_text_style,
                    filled: true, // Set to true to fill the background
                    fillColor: const Color.fromARGB(255, 14, 21, 27),
                    labelText: 'Confirm Password',
                    hintStyle:
                        input_text_style.copyWith(color: ShipmentTrackerColors.muted),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white10,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !showPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm Password is required';
                    }
                    if (value.length < 4)
                      return 'Password Length must be greater or equal to 4';
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
        Step(
          title:
              Text('Complete', style: TextStyle(color: ShipmentTrackerColors.white)),
          state: currentStep <= 1 ? StepState.indexed : StepState.complete,
          isActive: currentStep >= 2,
          content: Form(
            key: _referralCodeFormKey,
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                TextFormField(
                  controller: referralCodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        // Border style and color
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color
                          width: 0.5, // Border width
                        )),
                    labelText: 'Promo Code (optional)',

                    labelStyle: input_text_style,
                    filled: true, // Set to true to fill the background
                    fillColor: const Color.fromARGB(255, 14, 21, 27),
                  ),
                  validator: (value) {
                    return null; // Referral code is optional
                  },
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ];
  // Calculate the progress percentage
  double calculateProgress() {
    return (currentStep + 1) / getSteps().length;
  }

  // Get the appropriate message based on the current step
  String getStepMessage({progressNow, promosData}) {
    if (currentStep == 0) {
      return "You're $progressNow steps away from unlocking your $promosData gift";
    } else if (currentStep == 1) {
      return "Awesome! You're a step closer to unlocking your $promosData gift";
    } else {
      return "Congratulations! Now Click complete and get Ksh ${promosData} gift or if you have a promo code enter it before clicking complete";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ShipmentTrackerColors.bgColorScreen,
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            child: Column(children: [
              Text(
                'SIGNUP | CREATE A NEW ACCOUNT',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ShipmentTrackerColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 18),
            ]),
          ),
          SizedBox(height: 18),
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: LinearProgressIndicator(
                    value: calculateProgress(),
                    backgroundColor:
                        Colors.grey[400], // Customize the background color
                    valueColor: AlwaysStoppedAnimation<Color>(
                        calculateProgress() >= 1
                            ? Colors.green
                            : Colors.yellow), // Customize the progress color
                  ),
                ),

                // Progress Message
                SizedBox(height: 4),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    getStepMessage(progressNow: 2, promosData: '3000'),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: calculateProgress() >= 1
                            ? Colors.green
                            : Colors.cyanAccent.shade400),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              color: ShipmentTrackerColors.bgColorScreen,
              child: Theme(
                data: ThemeData(
                  canvasColor: ShipmentTrackerColors.bgColorScreen,
                  shadowColor: Colors.transparent,
                  indicatorColor: Colors.white,
                  primaryColor: Colors.white,
                  dividerColor: Colors.amber,
                ),
                child: Stepper(
                  margin: EdgeInsets.all(0),
                  connectorColor: currentStep < 2
                      ? MaterialStateProperty.all(Colors.blue)
                      : MaterialStateProperty.all(Colors.cyanAccent.shade400),
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepContinue: () {
                    final isLastStep = currentStep == getSteps().length - 1;

                    if (isLastStep) {
                      if (validateAndSaveForm()) {
                        // Print the values being submitted
                        print('MSISDN: ${msisdnController.text}');
                        print('Password: ${passwordController.text}');
                        print('Referral Code: ${referralCodeController.text}');

                        // Perform form submission
                        // Navigate to the login page
                        // Navigator.pushNamed(
                        //     context, '/login'); // Replace with your login page route
                      }
                    } else if (currentStep < 2) {
                      if (currentStep == 0) {
                        if (_msisdnFormKey.currentState!.validate()) {
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      } else if (currentStep == 1) {
                        if (_passwordFormKey.currentState!.validate()) {
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      }
                    }
                  },
                  onStepCancel: () {
                    if (currentStep == 0)
                      return null;
                    else if (currentStep > 0)
                      setState(() {
                        currentStep -= 1;
                      });
                  },
                  steps: getSteps(),
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.s,
                      children: <Widget>[
                        if (currentStep == 0)
                          Column(
                            children: [
                              ElevatedButton(
                                style: (!termsAndConditionsChecked
                                    ? btn_style_disabled
                                    : btn_style),
                                onPressed: !termsAndConditionsChecked
                                    ? () {}
                                    : details.onStepContinue,
                                child: Text(
                                  'Next',
                                  style:
                                      TextStyle(color: ShipmentTrackerColors.black),
                                ),
                              ),

                              SizedBox(height: 15),
                              Center(
                                child: GestureDetector(
                                    child: Container(
                                      child: Text(
                                        "Already have a verification code ?",
                                        style: TextStyle(
                                            color:
                                                ShipmentTrackerColors.defaultBtnColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  VerifyAccount())));
                                    }),
                              ),
                              SizedBox(height: 25),
                              Center(
                                child: Container(
                                  width: 300,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              value: termsAndConditionsChecked,
                                              onChanged: (value) {
                                                setState(() {
                                                  termsAndConditionsChecked =
                                                      value!;
                                                });
                                              }),
                                          Flexible(
                                            child: RichText(
                                              maxLines: 3,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '''By clicking Register you confirm to have read in detail, understood and agreed to the ''',
                                                    style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          ShipmentTrackerColors.muted,
                                                    ),
                                                  ),
                                                  WidgetSpan(
                                                    child: SizedBox(
                                                        width:
                                                            12.0), // Adjust the width as needed
                                                  ),
                                                  TextSpan(
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/terms-and-conditions');
                                                          },
                                                    text:
                                                        'Terms and Conditions, ',
                                                    style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ShipmentTrackerColors
                                                          .textAqua,
                                                    ),
                                                  ),
                                                  WidgetSpan(
                                                    child: SizedBox(
                                                        width:
                                                            12.0), // Adjust the width as needed
                                                  ),
                                                  TextSpan(
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/privacy-policy');
                                                          },
                                                    text: 'Privacy policy',
                                                    style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ShipmentTrackerColors
                                                          .textAqua,
                                                    ),
                                                  ),
                                                  WidgetSpan(
                                                    child: SizedBox(
                                                        width:
                                                            12.0), // Adjust the width as needed
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        'and also that you are over 18 years of age',
                                                    style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          ShipmentTrackerColors.muted,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Customize the continue button
                            ],
                          ),
                        if (currentStep != 0)
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              style: btn_style,
                              onPressed: details.onStepContinue,
                              child: currentStep == 2
                                  ? Text('Complete Sign Up',
                                      style: TextStyle(
                                          color: ShipmentTrackerColors.black))
                                  : Text('Next',
                                      style: TextStyle(
                                          color: ShipmentTrackerColors
                                              .black)), // Customize the continue button
                            ),
                          ),
                        if (currentStep != 0)
                          ElevatedButton(
                            style: btn_prev_style,
                            onPressed: details.onStepCancel,
                            child: Text('Previous',
                                style: TextStyle(
                                    color: ShipmentTrackerColors
                                        .black)), // Customize the cancel button
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSaveForm() {
    if (currentStep == 0 && _msisdnFormKey.currentState!.validate()) {
      _msisdnFormKey.currentState!.save();
    } else if (currentStep == 1 && _passwordFormKey.currentState!.validate()) {
      _passwordFormKey.currentState!.save();
    } else if (currentStep == 2) {
      _referralCodeFormKey.currentState!.save();
    }
    return true;
  }
}
