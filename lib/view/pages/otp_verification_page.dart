import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/auth_provider.dart';
import 'package:totalx_project/view/pages/add_user_page.dart';
import 'package:totalx_project/view/widgets/custom_text_button_widget.dart';

/// A page for verifying OTP with a countdown timer and option to resend OTP.
class OTPVerificationPage extends StatefulWidget {
  final String verificationId;
  final int? resendToken;
  const OTPVerificationPage(
      {super.key, required this.verificationId, required this.resendToken});

  @override
  OTPVerificationPageState createState() => OTPVerificationPageState();
}

class OTPVerificationPageState extends State<OTPVerificationPage> {
  final _otpController = TextEditingController(); // Controller for OTP input
  int _seconds = 59; // Initial countdown time
  Timer? _timer; // Timer for OTP countdown

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start countdown timer on page load
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer on dispose
    _otpController.dispose(); // Dispose controller
    super.dispose();
  }

  // Starts a countdown timer to resend OTP
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 0) {
          _timer?.cancel(); // Stop timer at 0 seconds
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AuthProvider>(context); // Provider for auth actions
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 42),
              // Image at the top for visual representation
              Center(
                child: Image.asset('assets/images/object_otp.png'),
              ),
              const SizedBox(height: 16.0),
              // Title for OTP verification section
              Align(
                alignment: Alignment.bottomLeft,
                child: Text('OTP Verification',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF333333)),
                    )),
              ),
              const SizedBox(height: 16.0),
              // Information text about OTP
              Text(
                'Enter the verification code we just sent to your number +91 *****21.',
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF000000))),
              ),
              const SizedBox(height: 16.0),
              // OTP input field with custom styling
              Pinput(
                controller: _otpController,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Color(0XFFFF5454),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(width: 16),
              // Countdown timer display
              Center(
                child: Text(
                  '$_seconds Sec',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFFFF5454))),
                ),
              ),
              const SizedBox(height: 16.0),
              // Resend OTP prompt with clickable text
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Didn't Get OTP? ",
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFF333333)))),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            // Resend OTP logic and reset timer
                            setState(() {
                              _seconds = 59;
                              _startTimer();
                            });
                          },
                          child: Text('Resend',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0XFF2873F0)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Verify button to confirm OTP
              CustomElevatedButton(
                  text: 'Verify',
                  onPressed: () {
                    authProvider.verifyOtp(_otpController.text.trim());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddUserPage(),
                        ));
                  }),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
