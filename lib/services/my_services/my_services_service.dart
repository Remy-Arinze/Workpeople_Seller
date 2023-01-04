import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qixer_seller/model/my_service_list_model.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyServicesService with ChangeNotifier {
  //

  List myServiceListMap = [];

  late int totalPages;

  int currentPage = 1;
  var alreadyAddedtoFav = false;
  List averageRateList = [];
  List imageList = [];
  List ratingCountList = [];
  bool hasError = false;

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  setActiveStatus(bool status, int index) {
    myServiceListMap[index]['isServiceOn'] = status;
    notifyListeners();
  }

  fetchMyServiceList(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      myServiceListMap = [];
      notifyListeners();

      setCurrentPage(currentPage);
    } else {}

    var connection = await checkConnection();
    if (!connection) return;
    //if connection is ok

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await http.get(
        Uri.parse("$baseApi/seller/service/my-services?page=$currentPage"),
        headers: header);

    if (response.statusCode == 201) {
      var data = MyServiceListModel.fromJson(jsonDecode(response.body));

      setTotalPage(data.myServices!.lastPage);

      for (int i = 0; i < data.myServices!.data.length; i++) {
        String? serviceImage;

        if (data.serviceImage.length > i) {
          serviceImage = data.serviceImage[i].imgUrl;
        } else {
          serviceImage = null;
        }

        int totalRating = 0;
        List reviews = data.myServices!.data[i].reviewsForMobile;
        for (int j = 0; j < reviews.length; j++) {
          totalRating = (totalRating + reviews[j].rating!).toInt();
        }
        double averageRate = 0;

        if (reviews.isNotEmpty) {
          averageRate = (totalRating / reviews.length);
        }
        averageRateList.add(averageRate);
        imageList.add(serviceImage);
        ratingCountList.add(reviews.length);
      }

      if (isrefresh) {
        print('refresh true');
        //if refreshed, then remove all service from list and insert new data
        setServiceList(
          data.myServices!.data,
          false,
        );
      } else {
        print('add new data');

        //else add new data
        setServiceList(
          data.myServices!.data,
          true,
        );
      }

      currentPage++;
      setCurrentPage(currentPage);
      return true;
    } else {
      if (myServiceListMap.isEmpty) {
        hasError = true;
        notifyListeners();
      }
      notifyListeners();
      return false;
    }
  }

  //=============>
  setServiceList(
    data,
    bool addnewData,
  ) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      myServiceListMap = [];
      notifyListeners();
    }

    for (int i = 0; i < data.length; i++) {
      myServiceListMap.add({
        'serviceId': data[i].id,
        'title': data[i].title,
        'price': data[i].price,
        'queued': data[i].pendingOrderCount,
        'completed': data[i].completeOrderCount,
        'cancelled': data[i].cancelOrderCount,
        'isOnline': data[i].isServiceOnline == 1 ? 'Online' : 'Offline',
        'viewCount': data[i].view,
        'isServiceOn': data[i].isServiceOn == 1 ? true : false,
      });
    }
  }

  // ===========>
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

  //
}
