import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/screens/ResetPassword.dart';
import 'package:shipment_tracker/screens/Signup.dart';
import 'package:shipment_tracker/screens/home.dart';
import 'package:shipment_tracker/store/app_state.dart';
import 'package:shipment_tracker/thunk_actions/auth_thunk_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:toastification/toastification.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool isSwitched = false;
  var textValue = 'Switch is OFF';
  final Map<String, dynamic> _formData = {
    'msisdn': '',
    'password': '',
    'showPassword': false,
  };

  void _togglePasswordVisibility() {
    setState(() {
      _formData['showPassword'] = !_formData['showPassword'];
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle form submission here
      final store = StoreProvider.of<AppState>(context);
      final payload = {
        "msisdn": _formData['msisdn'],
        "password": _formData['password']
      };

      store.dispatch(loginUser(payload));
      // Clear form inputs
      _formKey.currentState!.reset();

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

      toastification.show(
          context: context,
          title: 'Success',
          icon: const Icon(Icons.check),
          description: 'Successful Login',
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          closeButtonShowType: CloseButtonShowType.always,
          autoCloseDuration: const Duration(seconds: 5));

      print(payload);
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
    color: ShipmentTrackerColors.black,
  );
  final TextStyle label_text_style = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: ShipmentTrackerColors.black,
  );

  final ButtonStyle btn_style = ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 45.0),
      textStyle: const TextStyle(
          fontFamily: 'Roboto', // Use the Roboto font family
          letterSpacing: 2,
          fontSize: 16,
          color: ShipmentTrackerColors.black,
          fontWeight: FontWeight.w500),
      backgroundColor: ShipmentTrackerColors.defaultBtnColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)));

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Remember Me';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Dont Remember Me!';
      });
      print('Switch Button is OFF');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child:
       Column(
        children: [
          // Container(
            // child: Column(children: [
              // Text(
              //   'LOGIN',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       color: ShipmentTrackerColors.black,
              //       fontSize: 20,
              //       fontWeight: FontWeight.w500),
              // ),
              // SizedBox(height: 18),
              // Center(
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 5),
              //     child: Text(
              //         'Enter your phone number and password below to Login to your existing account.',
              //         softWrap: true,
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           color: ShipmentTrackerColors.white,
              //           fontSize: 13,
              //           fontWeight: FontWeight.w500,
              //         )),
              //   ),
              // )
            // ]),
          // ),
          SizedBox(height: 18),
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: input_text_style,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                // Border style and color
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: ShipmentTrackerColors.textAqua, // Border color
                                  width: 0.5, // Border width
                                )),
                            labelStyle: input_text_style,
                            filled: true, // Set to true to fill the background
                            fillColor: const Color.fromARGB(255, 214, 205, 205),
                            labelText: 'Phone Number',
                            hintStyle: input_text_style.copyWith(
                                color: ShipmentTrackerColors.textAqua)),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          _formData['msisdn'] = value;
                        },
                        validator: (value) {
                          final msisdnPattern = RegExp(r'(254|0|)?[71]\d{8}');
                          if (value!.isEmpty) {
                            return 'MSISDN is required';
                          }
                          if (!msisdnPattern.hasMatch(value)) {
                            return 'Invalid Phone Number Please try again';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Switch(
                            onChanged: toggleSwitch,
                            value: isSwitched,
                            activeColor: ShipmentTrackerColors.textAqua,
                            activeTrackColor: ShipmentTrackerColors.textAqua,
                            inactiveThumbColor: ShipmentTrackerColors.textAqua,
                            inactiveTrackColor: ShipmentTrackerColors.muted,
                          ),
                          SizedBox(width: 18),
                          Container(
                            child: Text(
                              "Remember Me",
                              style: TextStyle(
                                  color: ShipmentTrackerColors.textAqua,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 9),
                      TextFormField(
                        style: input_text_style,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              // Border style and color
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: ShipmentTrackerColors.textAqua, // Border color
                                width: 2.0, // Border width
                              )),
                          filled: true, // Set to true to fill the background
                          fillColor: const Color.fromARGB(255, 214, 205, 205), // Background color
                          labelText: 'Password',
                          labelStyle: input_text_style,
                          hintStyle: input_text_style.copyWith(
                              color: ShipmentTrackerColors.textAqua),
                          suffixIcon: IconButton(
                            icon: Icon(
                              color: Colors.black54,
                              _formData['showPassword']
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        obscureText: !_formData['showPassword'],
                        onSaved: (value) {
                          _formData['password'] = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 4)
                            return 'Password Length must be greater or equal to 4';
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Forget Password",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: ShipmentTrackerColors.textAqua,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ResetPassword())));
                          }),
                      SizedBox(height: 15),
                      ElevatedButton(
                        style: btn_style,
                        onPressed: _submitForm,
                        child: Text('LOGIN',
                            style: TextStyle(color: ShipmentTrackerColors.black)),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: GestureDetector(
                            child: Container(
                              child: Text(
                                "Don't have an account! Register now",
                                style: TextStyle(
                                    color: ShipmentTrackerColors.textAqua,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Signup())));
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
