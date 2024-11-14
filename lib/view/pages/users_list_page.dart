import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.location_pin,
              color: Color(0XFFFFFFFF),
            )),
        backgroundColor: Colors.black,
        title: Text(
          'Nilambur',
          style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFFFFFFFF))),
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
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 44,
                  width: 297,
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'search by name',
                        hintStyle: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey),
                        )),
                  ),
                ),
                Image.asset('assets/images/sort_image.png')
              ],
            )
          ],
        ),
      )),
    );
  }
}
