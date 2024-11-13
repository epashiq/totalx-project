// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UserProvider with ChangeNotifier{
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//     final ImagePicker picker = ImagePicker();
//     File? photo;

//   final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   FirebaseStorage storage = FirebaseStorage.instance;
      
//   Future addUser()async{
//     try {
//       await firebaseFirestore.collection('user').doc('').set({
//         'name': nameController.text,
//       'phone':phoneController.text,
//       'imageUrl':'',
//       });
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//    Future<void> pickImageFromGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       photo = File(pickedFile.path);
//       notifyListeners();
//     } else {
    
//     }
//   }

//    Future<void> pickImageFromCamera() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       photo = File(pickedFile.path);
//       notifyListeners();
//     } else {
//     }
//   }

//    Future<String?> uploadImage() async {
//     if (photo == null) return null;
//     try {
//       final fileName = basname(photo!.path);
//       final destination = 'images/$fileName';
//       final ref = storage.ref(destination);

//       // Read image file as Uint8List for uploading
//       Uint8List uint8list = await photo!.readAsBytes();
//       await ref.putData(uint8list);

//       final downloadUrl = await ref.getDownloadURL();
//       log('Image uploaded successfully: $downloadUrl');
//       return downloadUrl;
//     } catch (e) {
//       log('Image upload failed: ${e.toString()}');
//       return null;
//     }
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'; // Import for basename
import 'package:flutter/services.dart';

class UserProvider with ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? photo;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> addUser(String? imageUrl) async {
    try {
      await firebaseFirestore.collection('user').add({
        'name': nameController.text,
        'phone': phoneController.text,
        'imageUrl': imageUrl ?? '', // Pass uploaded image URL
      });
      log('User added successfully');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<String?> uploadImage() async {
    if (photo == null) return null;
    try {
      final fileName = basename(photo!.path);
      final destination = 'images/$fileName';
      final ref = storage.ref(destination);

      // Read image file as Uint8List for uploading
      Uint8List uint8list = await photo!.readAsBytes();
      await ref.putData(uint8list);

      final downloadUrl = await ref.getDownloadURL();
      log('Image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      log('Image upload failed: ${e.toString()}');
      return null;
    }
  }

   Future<String?> getImageUrl() async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('Employee image')
          .child('${nameController.text}.jpg');
      final imageUrl = storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return null;
    }
  }
  Future<void> saveImageUrlToFirestore(
      String employeeId, String imageUrl) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(employeeId)
        .update({'photo Url': imageUrl});
  }

  Future<void> saveUserData() async {
    String? imageUrl = await uploadImage();
    await addUser(imageUrl); // Save user with image URL
  }

   Future<void> showImagePickerOptions(BuildContext context) async {
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
                  pickImageFromGallery(); // Ensure this function returns void
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  pickImageFromCamera(); // Ensure this function returns void
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
