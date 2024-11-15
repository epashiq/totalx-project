import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalx_project/view/pages/user_sort_page.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allUsers = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filteredUsers = [];
  bool _isLoading = false;
  bool _hasMore = true;
  DocumentSnapshot<Map<String, dynamic>>? _lastDocument;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchUsers);
    _fetchUsers(); // Initial fetch of data
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fetch users in batches of 10
  Future<void> _fetchUsers() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      Query<Map<String, dynamic>> query =
          FirebaseFirestore.instance.collection('user').limit(10);
      if (_lastDocument != null) {
        query = query.startAfterDocument(
            _lastDocument!); // Start after the last document from previous fetch
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
        setState(() {
          _allUsers.addAll(snapshot.docs.cast<
              QueryDocumentSnapshot<
                  Map<String, dynamic>>>()); // Correct casting
          _filteredUsers = _allUsers; // Initially show all users
        });
      } else {
        _hasMore = false; // No more data to load
      }
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Search function for filtering users based on name or phone
  void _searchUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        final name = user['name'].toString().toLowerCase();
        final phone = user['phone'].toString().toLowerCase();
        return name.contains(query) || phone.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.location_pin, color: Color(0XFFFFFFFF)),
        ),
        backgroundColor: Colors.black,
        title: Text(
          'Nilambur',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0XFFFFFFFF)),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 100),
                    SizedBox(
                      height: 44,
                      width: 297,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search by name or age',
                          hintStyle: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserSortPage(),
                              ));
                        },
                        child: Image.asset('assets/images/sort_image.png')),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _filteredUsers.isEmpty
                      ? const Center(child: Text('No users found'))
                      : ListView.builder(
                          itemCount: _filteredUsers.length +
                              (_isLoading
                                  ? 1
                                  : 0), // Add one for the loading indicator
                          itemBuilder: (context, index) {
                            if (index == _filteredUsers.length) {
                              // Show loading indicator if it's the last item
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final user = _filteredUsers[index];
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                leading: const CircleAvatar(
                                  radius: 30,
                                ),
                                title: Text(
                                  user['name'],
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF000000)),
                                  ),
                                ),
                                subtitle: Text(
                                  'Age: ${user['phone']}',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0XFF000000)),
                                  ),
                                ),
                              ),
                            );
                          },
                          controller: ScrollController()
                            ..addListener(() {
                              // Check if user has reached the bottom
                              if (_isLoading || !_hasMore) return;
                              if (_filteredUsers.isNotEmpty &&
                                  _filteredUsers.length == _allUsers.length) {
                                _fetchUsers(); // Fetch more data
                              }
                            }),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
