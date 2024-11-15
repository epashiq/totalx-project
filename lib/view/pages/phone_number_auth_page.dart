// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:totalx_project/controller/provider/auth_provider.dart';
// import 'package:totalx_project/view/pages/otp_verification_page.dart';
// import 'package:totalx_project/view/widgets/custom_text_button_widget.dart';

// class PhoneNumberAuthPage extends StatelessWidget {
//   const PhoneNumberAuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final phoneController = TextEditingController();
//     // final formKey = GlobalKey<FormState>();
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 61,
//             ),
//             Center(child: Image.asset('assets/images/object_otp.png')),
//             const SizedBox(
//               height: 49.26,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Text('Enter Phone Number',
//                     style: GoogleFonts.montserrat(
//                       textStyle: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0XFF333333)),
//                     )),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               controller: phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 hintText: 'Enter Phone Number * ',
//                 hintStyle: GoogleFonts.montserrat(
//                     textStyle: const TextStyle(
//                         fontSize: 12, fontWeight: FontWeight.w400)),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Colors.grey),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               onTap: () {},
//               child: RichText(
//                   text: TextSpan(children: [
//                 TextSpan(
//                     text: 'By Continuing, I agree to TotalX’s',
//                     style: GoogleFonts.montserrat(
//                         textStyle: const TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0XFF000000)))),
//                 TextSpan(
//                     text: 'Terms and condition &privacy policy',
//                     style: GoogleFonts.montserrat(
//                         textStyle: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0XFF2873F0))))
//               ])),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             CustomElevatedButton(
//                 text: 'Get OTP',
//                 onPressed: () {
//                   try {
//                     authProvider.signInWithPhone(
//                         authProvider.mobileController.text, context);
//                   } catch (e) {
//                     log(e.toString());
//                   }
//                 })
//           ],
//         ),
//       )),
//     );
//   }
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/auth_provider.dart';
import 'package:totalx_project/view/widgets/custom_text_button_widget.dart';

class PhoneNumberAuthPage extends StatelessWidget {
  PhoneNumberAuthPage({super.key});

  final formKey = GlobalKey<FormState>(); // Moved outside build

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 61),
                Center(child: Image.asset('assets/images/object_otp.png')),
                const SizedBox(height: 49.26),
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
                InkWell(
                  onTap: () {
                    // Navigate to Terms and Conditions
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
                CustomElevatedButton(
                  text: 'Get OTP',
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      try {
                        await authProvider.signInWithPhone(
                          authProvider.mobileController.text,
                          context,
                        );
                      } catch (e) {
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
