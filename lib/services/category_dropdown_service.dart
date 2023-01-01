// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer_seller/model/categoryModel.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';

class CategoryDropdownService with ChangeNotifier {
  var categoryDropdownList = [];
  var categoryDropdownIndexList = [];
  var selectedCategory;
  var selectedCategoryId;

  setCategoryValue(value) {
    selectedCategory = value;
    notifyListeners();
  }

  setSelectedCategoryId(value) {
    selectedCategoryId = value;
    print('selected category id $selectedCategoryId');
    notifyListeners();
  }

  // ==========>

  var subCategoryDropdownList = ["Select Subcategory"];
  var subCategoryDropdownIndexList = ["0"];
  var selectedSubCategory = "Select Subcategory";
  var selectedSubCategoryId = "0";

  setSubCategoryValue(value) {
    selectedSubCategory = value;
    notifyListeners();
  }

  setSelectedSubCategoryId(value) {
    selectedSubCategoryId = value;
    print('selected subcategory id $selectedSubCategoryId');
    notifyListeners();
  }

  fetchCategory() async {
    if (categoryDropdownList.isNotEmpty) return;

    var connection = await checkConnection();
    if (!connection) return;

    var response = await http.get(Uri.parse('$baseApi/category'));

    if (response.statusCode == 201) {
      var data = CategoryModel.fromJson(jsonDecode(response.body));

      for (int i = 0; i < data.category.length; i++) {
        categoryDropdownList.add(data.category[i].name);
        categoryDropdownIndexList.add(data.category[i].id);
      }

      selectedCategory = data.category[0].name;
      selectedCategoryId = data.category[0].id;

      notifyListeners();
    } else {
      //Something went wrong
      categoryDropdownList = ['Select Category'];
      categoryDropdownIndexList = [0];
      selectedCategory = 'Select Category';
      selectedCategoryId = 0;
    }
  }

  // sub category
  fetchSubCategory() async {
    var connection = await checkConnection();
    if (!connection) return;

    var response = await http.get(Uri.parse('$baseApi/category'));

    if (response.statusCode == 201) {
      // var data = CategoryModel.fromJson(jsonDecode(response.body));

      // for (int i = 0; i < data.category.length; i++) {
      //   categoryDropdownList.add(data.category[i].name);
      //   categoryDropdownIndexList.add(data.category[i].id);
      // }

      // selectedCategory = data.category[0].name;
      // selectedCategoryId = data.category[0].id;

      notifyListeners();
    } else {
      //Something went wrong
      subCategoryDropdownList = ['Select Subcategory'];
      categoryDropdownIndexList = [0];
      selectedCategory = 'Select Subcategory';
      selectedCategoryId = 0;
    }
  }
}
