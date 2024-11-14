// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class UserSortPage extends StatefulWidget {
//   const UserSortPage({super.key});

//   @override
//   UserSortPageState createState() => UserSortPageState();
// }

// class UserSortPageState extends State<UserSortPage> {
//   String _sortBy = 'all';

//   // Method to fetch Firestore data as a list
//   Future<List<Map<String, dynamic>>> _fetchData() async {
//     final querySnapshot =
//         await FirebaseFirestore.instance.collection('user').get();
//     return querySnapshot.docs
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .toList();
//   }

//   // Method to sort data based on the selected criteria
//   List<Map<String, dynamic>> _sortData(List<Map<String, dynamic>> data) {
//     switch (_sortBy) {
//       case 'elder':
//         return data..sort((a, b) => b['phone'].compareTo(a['phone']));
//       case 'younger':
//         return data..sort((a, b) => a['phone'].compareTo(b['phone']));
//       default:
//         return data;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sorting Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Sort',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Radio<String>(
//                   value: 'all',
//                   groupValue: _sortBy,
//                   onChanged: (value) => setState(() => _sortBy = value!),
//                 ),
//                 const Text('All'),
//               ],
//             ),
//             const SizedBox(width: 16),
//             Row(
//               children: [
//                 Radio<String>(
//                   value: 'elder',
//                   groupValue: _sortBy,
//                   onChanged: (value) => setState(() => _sortBy = value!),
//                 ),
//                 const Text('Age: Elder'),
//               ],
//             ),
//             const SizedBox(width: 16),
//             Row(
//               children: [
//                 Radio<String>(
//                   value: 'younger',
//                   groupValue: _sortBy,
//                   onChanged: (value) => setState(() => _sortBy = value!),
//                 ),
//                 const Text('Age: Younger'),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: FutureBuilder<List<Map<String, dynamic>>>(
//                 future: _fetchData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text('No users available.'));
//                   } else {
//                     final data = snapshot.data!;
//                     final sortedData = _sortData(data);

//                     return ListView.builder(
//                       itemCount: sortedData.length,
//                       itemBuilder: (context, index) {
//                         final item = sortedData[index];
//                         return Card(
//                           elevation: 5,
//                           child: ListTile(
//                             title: Text(item['name']),
//                             subtitle: Text('Age: ${item['phone']}'),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/user_sort_provider.dart';

class UserSortPage extends StatelessWidget {
  const UserSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sort',
          style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF000000))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sort',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Radio<String>(
                  value: 'all',
                  groupValue: context.watch<UserSortProvider>().sortBy,
                  onChanged: (value) {
                    context.read<UserSortProvider>().setSortBy(value!);
                  },
                ),
                const Text('All'),
              ],
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                Radio<String>(
                  value: 'elder',
                  groupValue: context.watch<UserSortProvider>().sortBy,
                  onChanged: (value) {
                    context.read<UserSortProvider>().setSortBy(value!);
                  },
                ),
                const Text('Age: Elder'),
              ],
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                Radio<String>(
                  value: 'younger',
                  groupValue: context.watch<UserSortProvider>().sortBy,
                  onChanged: (value) {
                    context.read<UserSortProvider>().setSortBy(value!);
                  },
                ),
                const Text('Age: Younger'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<UserSortProvider>(
                builder: (context, userSortProvider, child) {
                  // Fetch data if it's not already fetched
                  if (userSortProvider.users.isEmpty) {
                    userSortProvider.fetchData();
                  }

                  if (userSortProvider.users.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: userSortProvider.users.length,
                    itemBuilder: (context, index) {
                      final item = userSortProvider.users[index];
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(item['name']),
                          subtitle: Text('Age: ${item['phone']}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
