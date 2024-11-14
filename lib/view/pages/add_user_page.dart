import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/user_provider.dart';
import 'package:totalx_project/view/pages/users_list_page.dart';
import 'package:totalx_project/view/widgets/custom_text_field.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
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
        onTap: () => FocusScope.of(context).unfocus,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 19),
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
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: userProvider.nameController,
                    hintText: 'Enter Name'),
                const SizedBox(height: 15),
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
                CustomTextFormField(
                  
                    controller: userProvider.ageController,
                    hintText: 'Enter Age'),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    Container(
                      height: 35,
                      width: 95,
                      decoration: BoxDecoration(
                        color: const Color(0XFF1782FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await userProvider.addUser(context);
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
