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

  Future<void> signInWithPhone(String phoneNumber, BuildContext context) async {
    if (!RegExp(r'^\+91\d{10}$').hasMatch(phoneNumber)) {
    log('Invalid phone number format');
    throw Exception('Please enter a valid 10-digit phone number with country code +91.');
  }
    try {
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: '+91 ${phoneNumber}',
        verificationCompleted: (phoneAuthCredential) async {
          log('verification completed');
          await auth.signInWithCredential(phoneAuthCredential);
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException error) {
          log('verification failed ${error.toString()}');
          String errorMessage = 'Verification failed';
          if (error.code == 'invalid-phone-number') {
            errorMessage = 'Invalid phone number format';
          }
          throw Exception(errorMessage);
        },
        codeSent: (verificationId, forceResendingToken) {
          log('code send ');
          _verificationId = verificationId;
          notifyListeners();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPVerificationPage(
                  verificationId: verificationId,
                  resendToken: forceResendingToken,
                ),
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          log('SMS code auto retrieval timeout');
        },
      );
    } catch (e) {
      log(e.toString());
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

   Future<(String, int?)> verifyPhoneNumber(String number, [int? resendToken]) async {
  if (number.isEmpty) {
    throw Exception("Please enter a valid phone number.");
  }

  try {
    final verificationIdCompleter = Completer<String>();
    final resendTokenCompleter = Completer<int?>();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      forceResendingToken: resendToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        log('Verification completed');
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification failed: ${e.message}');
        if (e.code == 'invalid-phone-number') {
          throw Exception("The provided phone number is not valid.");
        } else {
          throw Exception("Phone number verification failed. Please try again.");
        }
      },
      codeSent: (String verificationId, int? newResendToken) {
        verificationIdCompleter.complete(verificationId);
        resendTokenCompleter.complete(newResendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('Code retrieval timeout');
      },
    );

    final verificationId = await verificationIdCompleter.future;
    final newResendToken = await resendTokenCompleter.future;
    return (verificationId, newResendToken);
  } catch (e) {
    throw Exception("An error occurred during phone verification. Please try again later.");
  }
}

}



