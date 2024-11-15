import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/auth_provider.dart';
import 'package:totalx_project/view/pages/add_user_page.dart';
import 'package:totalx_project/view/widgets/custom_text_button_widget.dart';

class OTPVerificationPage extends StatefulWidget {
  final String verificationId;
  final int? resendToken;
  const OTPVerificationPage(
      {super.key, required this.verificationId, required this.resendToken});

  @override
  OTPVerificationPageState createState() => OTPVerificationPageState();
}

class OTPVerificationPageState extends State<OTPVerificationPage> {
  final _otpController = TextEditingController();
  int _seconds = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        if (_seconds == 0) {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 42),
              Center(
                child: Image.asset('assets/images/object_otp.png'),
              ),
              const SizedBox(height: 16.0),
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
              Text(
                'Enter the verification code we just sent to your number +91 *****21.',
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0XFF000000))),
              ),
              const SizedBox(height: 16.0),
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
                            // Add logic for resending OTP here
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
