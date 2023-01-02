import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddAttributeService with ChangeNotifier {
  List includedList = [];

  addIncludedList(String title) {
    includedList.add({
      'title': title,
    });
    notifyListeners();
  }

  removeIncludedList(int index) {
    includedList.removeAt(index);
    notifyListeners();
  }

  // additional

  List additionalList = [];

  addAdditional(
      {required title,
      required price,
      required qty,
      required BuildContext context}) {
    additionalList.add({
      'title': title,
      'price': price,
      'qty': qty,
      'image': pickedAdditionalImage
    });
    notifyListeners();
  }

  removeAdditional(int index) {
    additionalList.removeAt(index);
    notifyListeners();
  }

  // ===========>
  var pickedAdditionalImage;

  final ImagePicker _picker = ImagePicker();

  Future pickAdditionalImage(BuildContext context) async {
    pickedAdditionalImage =
        await _picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }
}
