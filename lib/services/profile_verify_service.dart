// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileVerifyService with ChangeNotifier {
  var pickedAddressImage;
  var pickedNidImage;

  final ImagePicker _picker = ImagePicker();

  Future pickAddressImage(BuildContext context) async {
    pickedAddressImage = await _picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }

  Future pickNidImage(BuildContext context) async {
    pickedNidImage = await _picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }
}
