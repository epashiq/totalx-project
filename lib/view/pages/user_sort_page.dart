import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/user_sort_provider.dart';

/// A page that allows sorting of users by age or showing all users.
class UserSortPage extends StatelessWidget {
  const UserSortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title for sorting users.
      appBar: AppBar(
        title: Text(
          'Sort',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0XFF000000),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page heading for sort options.
            const Text(
              'Sort',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Option for sorting all users.
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
            // Option for sorting users by elder age.
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
            // Option for sorting users by younger age.
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
            // Display the sorted user list.
            Expanded(
              child: Consumer<UserSortProvider>(
                builder: (context, userSortProvider, child) {
                  // Fetch data if it's not already fetched.
                  if (userSortProvider.users.isEmpty) {
                    userSortProvider.fetchData();
                  }

                  // Show loading indicator while data is loading.
                  if (userSortProvider.users.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Display the list of users based on sorting criteria.
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
