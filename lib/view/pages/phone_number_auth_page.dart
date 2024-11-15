import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/auth_provider.dart';
import 'package:totalx_project/view/widgets/custom_text_button_widget.dart';

/// A page for phone number authentication where users enter their phone number to receive an OTP.
class PhoneNumberAuthPage extends StatelessWidget {
  PhoneNumberAuthPage({super.key});

  // Key for form validation.
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Access AuthProvider for authentication operations.
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      // Provides a safe area for UI to avoid system intrusions.
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Adds spacing and an image for visual purpose.
                const SizedBox(height: 61),
                Center(child: Image.asset('assets/images/OBJECTS_phone.png')),
                const SizedBox(height: 49.26),

                // Displaying the phone number input label.
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Enter Phone Number',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0XFF333333),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Input field for phone number with validation.
                TextFormField(
                  controller: authProvider.mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixText: '+91 ',
                    hintText: '10-digit mobile number',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  // Validates the phone number format and displays an error if invalid.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // A link to Terms and Conditions that opens when tapped.
                InkWell(
                  onTap: () {
                    // Navigate to Terms and Conditions page.
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By Continuing, I agree to TotalX\'s ',
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0XFF000000),
                          ),
                        ),
                        TextSpan(
                          text: 'Terms and Conditions & Privacy Policy',
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0XFF2873F0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Button to initiate OTP retrieval on form validation.
                CustomElevatedButton(
                  text: 'Get OTP',
                  onPressed: () async {
                    // Validates the form before sending OTP.
                    if (formKey.currentState?.validate() ?? false) {
                      try {
                        // Calls sign-in with phone number on AuthProvider.
                        await authProvider.signInWithPhone(
                          authProvider.mobileController.text,
                          context,
                        );
                      } catch (e) {
                        // Shows an error message if sign-in fails.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        log('Error during phone authentication: ${e.toString()}');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
