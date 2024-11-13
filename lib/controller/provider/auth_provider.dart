import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totalx_project/view/pages/otp_verification_page.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController mobileController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String? _verificationId;

  String? get verificationId => _verificationId;

  Future<void> signInWithPhone(String phoneNumber, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException error) {
          String errorMessage = 'Verification failed';
          if (error.code == 'invalid-phone-number') {
            errorMessage = 'Invalid phone number format';
          }
          throw Exception(errorMessage);
        },
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          notifyListeners();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OTPVerificationPage(),
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
  void dispose(){
    super.dispose();
    mobileController.dispose();
  }
}
