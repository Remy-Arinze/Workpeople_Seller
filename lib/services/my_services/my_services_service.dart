import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyServicesService with ChangeNotifier {
  //
  late int totalPages;
  int currentPage = 1;

  List myServiceListMap = [];

  setActiveStatus(bool status, int index) {
    myServiceListMap[index]['isActive'] = status;
    notifyListeners();
  }

  var pickedImage;
  List<XFile>? galleryImages = [];

  final ImagePicker _picker = ImagePicker();

  Future pickMainImage(BuildContext context) async {
    pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }
  // ===========>

  Future pickGalleryImages(BuildContext context) async {
    galleryImages = await _picker.pickMultiImage();

    notifyListeners();
  }

  fetchMyServiceList(BuildContext context) {
    return true;
  }
}
