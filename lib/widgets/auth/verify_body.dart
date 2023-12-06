import 'package:shipment_tracker/constants/Theme.dart';
import 'package:shipment_tracker/screens/home.dart';
import 'package:shipment_tracker/store/app_state.dart';
import 'package:shipment_tracker/thunk_actions/auth_thunk_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:toastification/toastification.dart';

class VerifyForm extends StatefulWidget {
  const VerifyForm({Key? key}) : super(key: key);

  @override
  _VerifyFormState createState() => _VerifyFormState();
}

class _VerifyFormState extends State<VerifyForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'mobile': '',
    'code': '',
  };

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle form submission here
      final store = StoreProvider.of<AppState>(context);
      final payload = {
        "mobile": _formData['mobile'],
        "code": _formData['code']
      };

      store.dispatch(verifyCode(payload));
      // Clear form inputs
      _formKey.currentState!.reset();

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

      toastification.show(
          context: context,
          title: 'Success',
          icon: const Icon(Icons.check),
          description: 'Successful Verification',
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

  Future<void> onResendCode(resenddata) async {
    final store = StoreProvider.of<AppState>(context);

    final resendData = {'mobile': resenddata};

    // store.dispatch(action);
    store.dispatch(resendCode(resendData));
  }

  final ButtonStyle btn_resend_style = ElevatedButton.styleFrom(
      minimumSize: Size(35, 30.0),
      textStyle: const TextStyle(
          fontFamily: 'Roboto', // Use the Roboto font family

          letterSpacing: 2,
          fontSize: 15,
          color: ShipmentTrackerColors.white,
          fontWeight: FontWeight.w500),
      backgroundColor: Colors.green.shade600,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ShipmentTrackerColors.bgColorScreen,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Container(
            child: Column(children: [
              Text(
                'VERIFY YOUR PHONE NUMBER',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ShipmentTrackerColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
            ]),
          ),
          SizedBox(height: 18),
          Expanded(
            child: Form(
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
                      _formData['mobile'] = value;
                    },
                    validator: (value) {
                      final msisdnPattern = RegExp(r'(254|0|)?[71]\d{8}');
                      if (value!.isEmpty) {
                        return 'Mobile Number is required';
                      }
                      if (!msisdnPattern.hasMatch(value)) {
                        return 'Invalid Phone Number Please try again';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Did'nt Receive code? Resend Code",
                          style: TextStyle(
                              color: ShipmentTrackerColors.defaultBtnColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      ElevatedButton(
                          style: btn_resend_style,
                          onPressed: () => onResendCode(_formData['mobile']),
                          child: Text(
                            'Resend Code',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ))
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
                            color: Colors.blue, // Border color
                            width: 2.0, // Border width
                          )),
                      filled: true, // Set to true to fill the background
                      fillColor: const Color.fromARGB(
                          255, 14, 21, 27), // Background color
                      labelText: 'OTP CODE',
                      labelStyle: input_text_style,
                      hintStyle: input_text_style.copyWith(
                          color: ShipmentTrackerColors.white),
                    ),
                    onSaved: (value) {
                      _formData['code'] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'code is Required';
                      }
                      if (value.length < 4)
                        return 'OTP Length must be greater or equal to 4';
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  SizedBox(height: 15),
                  ElevatedButton(
                    style: btn_style,
                    onPressed: _submitForm,
                    child: Text('VERIFY ACCOUNT',
                        style: TextStyle(color: ShipmentTrackerColors.black)),
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
