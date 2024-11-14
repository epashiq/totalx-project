// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class UsersListPage extends StatelessWidget {
//   const UsersListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.location_pin,
//               color: Color(0XFFFFFFFF),
//             )),
//         backgroundColor: Colors.black,
//         title: Text(
//           'Nilambur',
//           style: GoogleFonts.montserrat(
//               textStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0XFFFFFFFF))),
//         ),
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const SizedBox(
//                   height: 100,
//                 ),
//                 SizedBox(
//                   height: 44,
//                   width: 297,
//                   child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.search),
//                         hintText: 'search by name',
//                         hintStyle: GoogleFonts.montserrat(
//                             textStyle: const TextStyle(
//                                 fontSize: 13, fontWeight: FontWeight.w400)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: const BorderSide(color: Colors.grey),
//                         )),
//                   ),
//                 ),
//                 Image.asset('assets/images/sort_image.png')
//               ],
//             ),
//             Expanded(
//                 child: StreamBuilder(
//               stream: FirebaseFirestore.instance.collection('user').snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const LinearProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.hasError}');
//                 } else {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       final user = snapshot.data!.docs[index];
//                       return Card(
//                         elevation: 5,
//                         child: ListTile(
//                           leading: const CircleAvatar(),
//                           title: Text(
//                             user['name'],
//                             style: GoogleFonts.montserrat(
//                                 textStyle: const TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0XFF000000))),
//                           ),
//                           subtitle: Text(
//                             'age :,${user['phone']}',
//                             style: GoogleFonts.montserrat(
//                                 textStyle: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0XFF000000))),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ))
//           ],
//         ),
//       )),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allUsers = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchUsers);
    _fetchUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchUsers() {
    FirebaseFirestore.instance
        .collection('user')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _allUsers = snapshot.docs;
        _filteredUsers = _allUsers; // initially show all users
      });
    });
  }

  void _searchUsers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        final name = user['name'].toString().toLowerCase();
        final age = user['phone'].toString().toLowerCase();
        return name.contains(query) || age.contains(query);
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
      body: SafeArea(
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
                  Image.asset('assets/images/sort_image.png'),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: _filteredUsers.isEmpty
                    ? const Center(child: Text('No users found'))
                    : ListView.builder(
                        itemCount: _filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = _filteredUsers[index];
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              leading: const CircleAvatar(),
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
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
