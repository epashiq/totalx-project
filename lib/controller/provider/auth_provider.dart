import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totalx_project/view/pages/otp_verification_page.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FirebaseAuth auth = FirebaseAuth.instance;
  String? _verificationId;

  String? get verificationId => _verificationId;

  // Future<void> signInWithPhone(String phoneNumber, BuildContext context) async {
  //   if (!RegExp(r'^\+91\d{10}$').hasMatch(phoneNumber)) {
  //   log('Invalid phone number format');
  //   throw Exception('Please enter a valid 10-digit phone number with country code +91.');
  // }
  //   try {
  //     await auth.verifyPhoneNumber(
  //       timeout: const Duration(seconds: 60),
  //       phoneNumber: '+91 ${phoneNumber}',
  //       verificationCompleted: (phoneAuthCredential) async {
  //         log('verification completed');
  //         await auth.signInWithCredential(phoneAuthCredential);
  //         notifyListeners();
  //       },
  //       verificationFailed: (FirebaseAuthException error) {
  //         log('verification failed ${error.toString()}');
  //         String errorMessage = 'Verification failed';
  //         if (error.code == 'invalid-phone-number') {
  //           errorMessage = 'Invalid phone number format';
  //         }
  //         throw Exception(errorMessage);
  //       },
  //       codeSent: (verificationId, forceResendingToken) {
  //         log('code send ');
  //         _verificationId = verificationId;
  //         notifyListeners();
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => OTPVerificationPage(
  //                 verificationId: verificationId,
  //                 resendToken: forceResendingToken,
  //               ),
  //             ));
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         _verificationId = verificationId;
  //         log('SMS code auto retrieval timeout');
  //       },
  //     );
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

   Future<void> signInWithPhone(String phoneNumber, BuildContext context) async {
    try {
      // Remove any spaces or special characters from the phone number
      final cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      
      if (cleanPhoneNumber.length != 10) {
        throw Exception('Please enter a valid 10-digit phone number');
      }

      final formattedNumber = '+91$cleanPhoneNumber';

      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: formattedNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('Verification completed automatically');
          await _handleCredential(credential);
        },
        verificationFailed: (FirebaseAuthException error) {
          log('Verification failed: ${error.toString()}');
          String errorMessage = 'Verification failed';
          
          switch (error.code) {
            case 'invalid-phone-number':
              errorMessage = 'Invalid phone number format';
              break;
            case 'too-many-requests':
              errorMessage = 'Too many attempts. Please try again later';
              break;
            case 'network-request-failed':
              errorMessage = 'Network error. Please check your connection';
              break;
          }
          
          throw Exception(errorMessage);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          log('Verification code sent');
          _verificationId = verificationId;
          notifyListeners();
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPVerificationPage(
                verificationId: verificationId,
                resendToken: forceResendingToken,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          log('SMS auto-retrieval timeout');
        },
      );
    } catch (e) {
      log('Error in signInWithPhone: ${e.toString()}');
      rethrow; // Rethrow to handle in UI
    }
  }

  Future<void> _handleCredential(PhoneAuthCredential credential) async {
    try {
      await auth.signInWithCredential(credential);
      notifyListeners();
    } catch (e) {
      log('Error signing in with credential: ${e.toString()}');
      throw Exception('Failed to verify OTP. Please try again.');
    }
  }

  Future<UserCredential> verifyOtp(String otp) async {
    if (_verificationId == null) {
      throw Exception('Verification ID is null');
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);

      final usetCredential = await auth.signInWithCredential(credential);
      notifyListeners();
      return usetCredential;
    } catch (e) {
      log('OTP verification error: ${e.toString()}');
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
    mobileController.dispose();
  }
}



