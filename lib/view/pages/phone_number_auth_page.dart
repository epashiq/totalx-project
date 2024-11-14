import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/auth_provider.dart';
import 'package:totalx_project/view/widgets/custom_text_button_widget.dart';

class PhoneNumberAuthPage extends StatelessWidget {
  const PhoneNumberAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final phoneController = TextEditingController();
    // final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 61,
            ),
            Center(child: Image.asset('assets/images/object_otp.png')),
            const SizedBox(
              height: 49.26,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('Enter Phone Number',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF333333)),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter Phone Number * ',
                hintStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'By Continuing, I agree to TotalX’s',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF000000)))),
                TextSpan(
                    text: 'Terms and condition &privacy policy',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF2873F0))))
              ])),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
                text: 'Get OTP',
                onPressed: () {
                  try {
                    authProvider
                        .verifyPhoneNumber(authProvider.mobileController.text);
                  } catch (e) {
                    log(e.toString());
                  }
                })
          ],
        ),
      )),
    );
  }
}
