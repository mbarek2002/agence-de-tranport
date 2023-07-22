import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FileController extends GetxController {
  // Variable to store the selected file
  Rx<File?> selectedFile = Rx<File?>(null);

  // Function to handle file selection from file picker
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf','png','jpg']);

    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  // Function to upload the selected file to Firebase Storage
  Future<void> uploadFileToFirebase() async {
    if (selectedFile.value == null) {
      // Show an error message or dialog if no file is selected.
      return;
    }

    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref();
      final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.pdf';
      final fileRef = storageRef.child('files/$fileName');

      await fileRef.putFile(selectedFile.value!);

      // You can do something here after the file is successfully uploaded,
      // like displaying a success message or refreshing the UI.
      // For example, you can store the file URL in Firebase Database for future access.

      print('File uploaded successfully!');
    } catch (error) {
      print('Error uploading file: $error');
      // Handle the error appropriately, e.g., show an error message or log it.
    }
  }
}
