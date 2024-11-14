// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:totalx_project/controller/provider/user_provider.dart';

// class AddUserPage extends StatelessWidget {
//   const AddUserPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Add A New User',
//           style: GoogleFonts.montserrat(
//               textStyle: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0XFF000000))),
//         ),
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 19,
//             ),
//             Center(
//                 child: InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (BuildContext bc) {
//                           return SafeArea(
//                             child: Wrap(
//                               children: [
//                                 ListTile(
//                                   leading: const Icon(Icons.photo_library),
//                                   title: const Text('Gallery'),
//                                   onTap: () {
//                                     userProvider
//                                         .pickImageFromGallery(); // Ensure this function returns void
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                                 ListTile(
//                                   leading: const Icon(Icons.camera),
//                                   title: const Text('Camera'),
//                                   onTap: () {
//                                     userProvider
//                                         .pickImageFromCamera(); // Ensure this function returns void
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: CircleAvatar(
//                       radius: 50,
//                     )
//                     //  Image.asset('assets/images/user.png')
//                     )),
//             const SizedBox(
//               height: 15,
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Text(
//                 'Name',
//                 style: GoogleFonts.montserrat(
//                     textStyle: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0XFF333333))),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             TextFormField(
//               controller: userProvider.nameController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 hintText: 'Enter Name ',
//                 hintStyle: GoogleFonts.montserrat(
//                     textStyle: const TextStyle(
//                         fontSize: 12, fontWeight: FontWeight.w400)),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Colors.grey),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Text(
//                 'Age',
//                 style: GoogleFonts.montserrat(
//                     textStyle: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0XFF333333))),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             TextFormField(
//               controller: userProvider.phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 hintText: 'Enter Age ',
//                 hintStyle: GoogleFonts.montserrat(
//                     textStyle: const TextStyle(
//                         fontSize: 12, fontWeight: FontWeight.w400)),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Colors.grey),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Container(
//                   height: 30,
//                   width: 95,
//                   decoration: BoxDecoration(
//                       color: const Color(0XFFCCCCCC),
//                       borderRadius: BorderRadius.circular(8)),
//                   child: TextButton(
//                       onPressed: () {},
//                       child: Text(
//                         'Cancel',
//                         style: GoogleFonts.montserrat(
//                             textStyle: const TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0XFF000000))),
//                       )),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   height: 30,
//                   width: 95,
//                   decoration: BoxDecoration(
//                       color: const Color(0XFF1782FF),
//                       borderRadius: BorderRadius.circular(8)),
//                   child: TextButton(
//                       onPressed: () {
//                         userProvider.addUser();
//                       },
//                       child: Text(
//                         'Cancel',
//                         style: GoogleFonts.montserrat(
//                             textStyle: const TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0XFFFFFFFF))),
//                       )),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx_project/controller/provider/user_provider.dart';
import 'package:totalx_project/view/pages/users_list_page.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 19),
              Center(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return SafeArea(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Gallery'),
                                onTap: () {
                                  userProvider.pickImageFromGallery();
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Camera'),
                                onTap: () {
                                  userProvider.pickImageFromCamera();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: userProvider.photo != null
                        ? FileImage(userProvider.photo!)
                        : null,
                    child: userProvider.photo == null
                        ? const Icon(Icons.person, size: 50)
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
              const SizedBox(height: 15),
              TextFormField(
                controller: userProvider.nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
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
              TextFormField(
                controller: userProvider.ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Age',
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
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
                    height: 30,
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
                        // userProvider.nameController.dispose();
                        // userProvider.ageController.dispose();
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
    );
  }
}
