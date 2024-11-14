import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserSortProvider with ChangeNotifier {
  String _sortBy = 'all';
  List<Map<String, dynamic>> _users = [];

  String get sortBy => _sortBy;
  List<Map<String, dynamic>> get users => _users;

  // Method to fetch Firestore data as a list
  Future<void> fetchData() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('user').get();
    _users = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    _sortData(); // Sort immediately after fetching data
    notifyListeners(); // Notify listeners when data is fetched
  }

  // Method to set sorting criteria
  void setSortBy(String value) {
    _sortBy = value;
    _sortData();
    notifyListeners(); // Notify listeners when sortBy changes
  }

  // Method to sort data based on the selected criteria
  void _sortData() {
    switch (_sortBy) {
      case 'elder':
        _users.sort((a, b) => b['phone'].compareTo(a['phone'])); // Modify according to your field
        break;
      case 'younger':
        _users.sort((a, b) => a['phone'].compareTo(b['phone'])); // Modify according to your field
        break;
      default:
        // If no sorting, do not change order
        break;
    }
  }
}
