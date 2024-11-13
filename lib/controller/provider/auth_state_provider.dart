import 'package:flutter/material.dart';

class AuthStateProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _agreedToTerms = false;
  final formKey = GlobalKey<FormState>();

  bool get isLoading => _isLoading;
  bool get agreedToTerms => _agreedToTerms;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setAgreedToTerms(bool value) {
    _agreedToTerms = value;
    notifyListeners();
  }
}