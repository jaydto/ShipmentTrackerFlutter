import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/screens/Signup.dart';
import 'package:shipment_tracker/screens/home.dart';
import 'package:shipment_tracker/store/app_state.dart';
import 'package:shipment_tracker/thunk_actions/auth_thunk_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  bool _showMsisdnInput = true; // Flag to toggle visibility of MSISDN input
  String? _password;
  bool _showPasswordInputs =
      false; // Flag to toggle visibility of Password and Confirm Password inputs

  final Map<String, dynamic> _formData = {
    'id': '',
    'msisdn': '',
    'code': '',
    'password': '',
    'repeat_password': '',
    'showPassword': false,
  };

  void _togglePasswordVisibility() {
    setState(() {
      _formData['showPassword'] = !_formData['showPassword'];
    });
  }

  void _toggleMsisdnVisibility() {
    setState(() {
      _showMsisdnInput = !_showMsisdnInput;
    });
  }

  void _togglePasswordVisibilityAvailability() {
    setState(() {
      _showPasswordInputs = !_showPasswordInputs;
    });
  }

  void _submitMsisdnForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Handle sending OTP to MSISDN here
      final store = StoreProvider.of<AppState>(context);
      final payload = {"mobile": _formData['msisdn']};
      store.dispatch(resendCode(payload));

      _toggleMsisdnVisibility(); // Hide MSISDN input
      _togglePasswordVisibilityAvailability(); // Show Password and Confirm Password inputs
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Check if the passwords match
      if (_formData['password'] != _formData['repeat_password']) {
        // _formKey.currentState!.reset(); // Reset the form
        toastification.show(
          context: context,
          title: 'Error',
          icon: const Icon(Icons.error),
          description: 'Passwords do not match',
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          closeButtonShowType: CloseButtonShowType.always,
          autoCloseDuration: const Duration(seconds: 5),
        );
        return; // Exit the function without submitting
      }

      // Set the _password variable with the password value
      _password = _formData['password'];
      // Handle form submission here
      final store = StoreProvider.of<AppState>(context);
      final payload = {
        "mobile": _formData['msisdn'],
        "code": _formData['code'],
        "password": _formData['password'],
      };

      store.dispatch(forgotPassword(payload));
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
    color: ShipmentTrackerColors.muted,
  );
  final TextStyle label_text_style = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    color: ShipmentTrackerColors.muted,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Container(
            child: Column(children: [
              Text(
                'RECOVER YOUR ACCOUNT',
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
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_showMsisdnInput)
                    TextFormField(
                      style: input_text_style,
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
                          labelText: 'Phone Number',
                          hintStyle: input_text_style.copyWith(
                              color: ShipmentTrackerColors.muted)),
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
                  SizedBox(height: 18),
                  if (_showPasswordInputs)
                    TextFormField(
                      style: input_text_style,
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
                          labelText: 'OTP',
                          hintStyle: input_text_style.copyWith(
                              color: ShipmentTrackerColors.muted)),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        _formData['code'] = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'OTP code required';
                        }
                        if (value.length < 4) {
                          return 'OTP Length must be greater or equal to 4';
                        }
                        return null;
                      },
                    ),
                  if (_showPasswordInputs) SizedBox(height: 15),
                  if (_showPasswordInputs)
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
                        filled: true, // Set to true to fill the background
                        fillColor: const Color.fromARGB(
                            255, 14, 21, 27), // Background color
                        labelText: 'Password',
                        labelStyle: input_text_style,
                        hintStyle: input_text_style.copyWith(
                            color: ShipmentTrackerColors.white),
                        suffixIcon: IconButton(
                          icon: Icon(
                            color: Colors.white,
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
                  if (_showPasswordInputs) SizedBox(height: 15),
                  if (_showPasswordInputs)
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
                        filled: true, // Set to true to fill the background
                        fillColor: const Color.fromARGB(
                            255, 14, 21, 27), // Background color
                        labelText: 'Confirm Password',
                        labelStyle: input_text_style,
                        hintStyle: input_text_style.copyWith(
                            color: ShipmentTrackerColors.white),
                        suffixIcon: IconButton(
                          icon: Icon(
                            color: Colors.white,
                            _formData['showPassword']
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: !_formData['showPassword'],
                      onSaved: (value) {
                        _formData['repeat_password'] = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Confirm Password is required';
                        }
                        if (value.length < 4)
                          return 'Password Length must be greater or equal to 4';

                        return null;
                      },
                    ),
                  SizedBox(height: 15),
                  SizedBox(height: 15),
                  if (_showMsisdnInput)
                    ElevatedButton(
                      style: btn_style,
                      onPressed: _submitMsisdnForm,
                      child: Text('Send OTP',
                          style: TextStyle(color: ShipmentTrackerColors.black)),
                    ),
                  if (_showPasswordInputs)
                    ElevatedButton(
                      style: btn_style,
                      onPressed: _submitForm,
                      child: Text('Submit',
                          style: TextStyle(color: ShipmentTrackerColors.black)),
                    ),
                  SizedBox(height: 15),
                  Center(
                    child: GestureDetector(
                        child: Container(
                          child: Text(
                            "Don't have an account! Register now",
                            style: TextStyle(
                                color: ShipmentTrackerColors.defaultBtnColor,
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
          ),
        ],
      ),
    );
  }
}
