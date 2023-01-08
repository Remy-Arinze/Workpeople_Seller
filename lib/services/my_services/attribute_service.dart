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

  addIncludedList(String title, String price) {
    includedList.add({'title': title, 'price': price, 'qty': '1'});
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

  Future<bool> loadAttributes(BuildContext context,
      {required serviceId}) async {
    //check internet connection
    var connection = await checkConnection();
    if (!connection) return false;
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

    if (response.statusCode == 201) {
      attributes = AttributesModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      return true;
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
      return false;
    }
  }

  //Show attributes of a service
  // =================>

  bool addAttrLoading = false;

  setAddAttrLodingStatus(bool status) {
    addAttrLoading = status;
    notifyListeners();
  }

  addAttribute(BuildContext context, {required serviceId}) async {
    //check internet connection
    var connection = await checkConnection();
    if (!connection) return;

    if (addAttrLoading) return;

    if (includedList.isEmpty ||
        additionalList.isEmpty ||
        benefitsList.isEmpty) {
      OthersHelper().showToast(
          'Make sure you have added include, additional, benefits',
          Colors.black);
      return;
    }

    // include service
    List incList = [];
    List addiList = [];
    List beniList = [];
    List fqList = [];

    for (int i = 0; i < includedList.length; i++) {
      incList.add({
        "service_id": serviceId,
        "include_service_title": includedList[i]['title'],
        "include_service_quantity": includedList[i]['qty'],
        "include_service_price": includedList[i]['price'],
      });
    }

    for (int i = 0; i < additionalList.length; i++) {
      addiList.add({
        "service_id": serviceId,
        "additional_service_title": additionalList[i]['title'],
        "additional_service_quantity": additionalList[i]['qty'],
        "additional_service_price": additionalList[i]['price'],
      });
    }

    for (int i = 0; i < benefitsList.length; i++) {
      beniList.add({
        "service_id": serviceId,
        "benifits": benefitsList[i]['title'],
      });
    }

    for (int i = 0; i < faqList.length; i++) {
      fqList.add({
        "service_id": serviceId,
        "title": faqList[i]['title'],
        "description": faqList[i]['desc'],
      });
    }

    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    print('service id $serviceId');

    var data = jsonEncode({
      "all_include_service": jsonEncode({"all_include_service": incList}),
      "all_additional_service":
          jsonEncode({"all_additional_service": addiList}),
      "service_benifits": jsonEncode({"service_benifits": beniList}),
      "online_service_faqs": jsonEncode({"online_service_faqs": fqList}),
    });

    setAddAttrLodingStatus(true);

    var response = await http.post(
        Uri.parse(
            '$baseApi/seller/service/add-service-attributes-by-id/$serviceId'),
        headers: header,
        body: data);

    setAddAttrLodingStatus(false);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      Navigator.pop(context);
      OthersHelper().showToast('Service attribute added', Colors.black);
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
    }
  }

  //delete attribute
  // =================>

  bool deleteAttrLoading = false;

  setDeleteAttrLodingStatus(bool status) {
    deleteAttrLoading = status;
    notifyListeners();
  }

  deleteAttribute(BuildContext context,
      {required attributeId,
      bool deleteInclude = false,
      bool deleteAdditional = false,
      bool deleteBenefit = false,
      required serviceId}) async {
    //check internet connection
    var connection = await checkConnection();
    if (!connection) return;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    String apiLink;

    if (deleteInclude) {
      apiLink = '$baseApi/seller/service/delete/include-service/$attributeId';
    } else if (deleteAdditional) {
      apiLink =
          '$baseApi/seller/service/delete/additional-service/$attributeId';
    } else {
      // delete benefit
      apiLink = '$baseApi/seller/service/delete/benefits/$attributeId';
    }

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    setDeleteAttrLodingStatus(true);

    var response = await http.post(
      Uri.parse(apiLink),
      headers: header,
    );

    print(response.body);
    print(response.statusCode);

    //refresh the page
    await loadAttributes(context, serviceId: serviceId);

    setDeleteAttrLodingStatus(false);
    Navigator.pop(context);

    if (response.statusCode == 201) {
      OthersHelper().showToast('Attribute deleted', Colors.black);

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
