import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/user_provider.dart';
import 'package:totalx_project/view/pages/users_list_page.dart';
import 'package:totalx_project/view/widgets/custom_text_field.dart';

/// A page where users can add a new user with a photo, name, and age.
class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Accesses UserProvider to handle user-related operations.
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      // App bar with title for adding a new user.
      appBar: AppBar(
        title: Text(
          'Add A New User',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0XFF000000),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        // Closes the keyboard when tapping outside of input fields.
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 19),
                // Displays user's photo or a default image and triggers image picker.
                Center(
                  child: InkWell(
                    onTap: () {
                      userProvider.showImagePickerOptions(context);
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: userProvider.photo != null
                          ? FileImage(userProvider.photo!)
                          : null,
                      child: userProvider.photo == null
                          ? Image.asset(
                              'assets/images/user.png',
                              fit: BoxFit.contain,
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Displays the 'Name' label above the input field.
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Name',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF333333),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Input field for entering user's name.
                CustomTextFormField(
                    controller: userProvider.nameController,
                    hintText: 'Enter Name'),
                const SizedBox(height: 15),
                // Displays the 'Age' label above the input field.
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Age',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF333333),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Input field for entering user's age.
                CustomTextFormField(
                    controller: userProvider.ageController,
                    hintText: 'Enter Age'),
                const SizedBox(height: 15),
                // Row with Cancel and Save buttons.
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Cancel button to return to the previous page.
                    Container(
                      height: 35,
                      width: 95,
                      decoration: BoxDecoration(
                        color: const Color(0XFFCCCCCC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Save button to add the user and navigate to UsersListPage.
                    Container(
                      height: 35,
                      width: 95,
                      decoration: BoxDecoration(
                        color: const Color(0XFF1782FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          // Calls addUser method to save the user data.
                          await userProvider.addUser(context);
                          // Navigates to UsersListPage after saving.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UsersListPage(),
                              ));
                        },
                        child: Text(
                          'Save',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
