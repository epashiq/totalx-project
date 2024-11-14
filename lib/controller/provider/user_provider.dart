import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'; // Import for basename
import 'package:flutter/services.dart';
import 'package:totalx_project/model/user_model.dart';

class UserProvider with ChangeNotifier {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? photo;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> addUser(BuildContext context) async {
    try {
      await firebaseFirestore.collection('user').doc(nameController.text).set({
        'name': nameController.text,
        'phone': ageController.text,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User added successfully')));
      log('User added successfully');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User added failed')));

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

  Future<void> saveImageUrlToFirestore(String userId, String imageUrl) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc()
        .update({'photo Url': imageUrl});
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

  Future<UserModel> getUserData(String userId) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('user');
    try {
      DocumentSnapshot documentSnapshot =
          await userCollection.doc(userId).get();
      if (documentSnapshot.exists) {
        var user =
            UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
        populateForm(user);
        return user;
      } else {
        log('Employee not found');
        return throw Exception('Employee not found');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void populateForm(UserModel user) {
    nameController.text = user.name;
    ageController.text = user.age;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
