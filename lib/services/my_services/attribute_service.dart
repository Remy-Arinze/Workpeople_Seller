import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qixer_seller/model/attributes_model.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AttributeService with ChangeNotifier {
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
  //===========>

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

  //benefits of package
  //===========>

  List benefitsList = [];

  addBenefits(String title) {
    benefitsList.add({
      'title': title,
    });
    notifyListeners();
  }

  removeBenefits(int index) {
    benefitsList.removeAt(index);
    notifyListeners();
  }

  //FAQ
  //===========>

  List faqList = [];

  addFaq(String title, String desc) {
    faqList.add({'title': title, 'desc': desc});
    notifyListeners();
  }

  removeFaq(int index) {
    faqList.removeAt(index);
    notifyListeners();
  }

  //Show attributes of a service
  // =================>

  var attributes;
  bool attrLoading = false;

  setAttrLodingStatus(bool status) {
    attrLoading = status;
    notifyListeners();
  }

  loadAttributes(BuildContext context, {required serviceId}) async {
    //check internet connection
    var connection = await checkConnection();
    if (!connection) return;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    setAttrLodingStatus(true);

    var response = await http.get(
      Uri.parse('$baseApi/seller/service/attributes/show/$serviceId'),
      headers: header,
    );

    setAttrLodingStatus(false);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      attributes = AttributesModel.fromJson(jsonDecode(response.body));
      notifyListeners();
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
    }
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
