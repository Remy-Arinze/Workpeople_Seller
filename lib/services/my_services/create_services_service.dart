import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/category_subcat_dropdown_service.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateServicesService with ChangeNotifier {
  // ===========>
  var pickedImage;
  // List<XFile>? galleryImages = [];
  var galleryImage;

  final ImagePicker _picker = ImagePicker();

  Future pickMainImage(BuildContext context) async {
    pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }
  // ===========>

  Future pickGalleryImages(BuildContext context) async {
    galleryImage = await _picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }

  //Create service
  // ===============>

  bool createServiceLoading = false;

  setCreateLodingStatus(bool status) {
    createServiceLoading = status;
    notifyListeners();
  }

  createService(
    BuildContext context, {
    required bool isAvailableToAllCities,
    required description,
    required videoUrl,
    required title,
  }) async {
    //check internet connection
    var connection = await checkConnection();
    if (!connection) return false;

    if (createServiceLoading) return;

    if (pickedImage == null) {
      OthersHelper().showToast('You must select a main image', Colors.black);
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var categoryId =
        Provider.of<CategorySubCatDropdownService>(context, listen: false)
            .selectedCategoryId;
    var subCategoryId =
        Provider.of<CategorySubCatDropdownService>(context, listen: false)
            .selectedSubCategoryId;
    var childCategoryId =
        Provider.of<CategorySubCatDropdownService>(context, listen: false)
            .selectedChildCategoryId;

    setCreateLodingStatus(true);

    FormData formData;
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer $token";

    formData = FormData.fromMap({
      'category_id': categoryId,
      'subcategory_id': subCategoryId,
      'child_category_id': childCategoryId,
      'title': title,
      'description': description,
      'image': await MultipartFile.fromFile(pickedImage.path,
          filename: 'image$categoryId$childCategoryId$title.jpg'),
      'image_gallery': galleryImage != null
          ? await MultipartFile.fromFile(pickedImage.path,
              filename: 'galleryimage$categoryId$childCategoryId$title.jpg')
          : null,
      'video': videoUrl,
      'is_service_all_cities': isAvailableToAllCities ? 1 : 0,
    });

    var response = await dio.post(
      '$baseApi/seller/service/add-service',
      data: formData,
    );

    setCreateLodingStatus(false);

    print(response.data);
    print(response.statusCode);

    if (response.statusCode == 201) {
      //TODO
      // pop and load service list again
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
    }
  }
}
