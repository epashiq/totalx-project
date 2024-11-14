import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserSearchProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allUsers = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filteredUsers = [];

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get filteredUsers =>
      _filteredUsers;

  UserProvider() {
    searchController.addListener(_searchUsers);
    _fetchUsers();
  }

  void _fetchUsers() {
    FirebaseFirestore.instance
        .collection('user')
        .snapshots()
        .listen((snapshot) {
      _allUsers = snapshot.docs;
      _filteredUsers = _allUsers; // Initially show all users
      notifyListeners();
    });
  }

  void _searchUsers() {
    final query = searchController.text.toLowerCase();
    _filteredUsers = _allUsers.where((user) {
      final name = user['name'].toString().toLowerCase();
      final age = user['phone'].toString().toLowerCase();
      return name.contains(query) || age.contains(query);
    }).toList();
    notifyListeners();
  }
}
