import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/my_services/attribute_service.dart';

class EditAttributeService with ChangeNotifier {
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
    additionalList.add({'title': title, 'price': price, 'qty': qty});
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

//===========>
//=========>

  fillAttributes(BuildContext context) {
    includedList = [];
    additionalList = [];
    benefitsList = [];
    faqList = [];

    var attributes =
        Provider.of<AttributeService>(context, listen: false).attributes;

    //include
    for (int i = 0; i < attributes.includeServices.length; i++) {
      includedList.add({
        'title': attributes.includeServices[i].includeServiceTitle,
        'price': attributes.includeServices[i].includeServicePrice,
        'qty': attributes.includeServices[i].includeServiceQuantity
      });
    }

    //additional
    for (int i = 0; i < attributes.additionalService.length; i++) {
      additionalList.add({
        'title': attributes.additionalService[i].additionalServiceTitle,
        'price': attributes.additionalService[i].additionalServicePrice,
        'qty': attributes.additionalService[i].additionalServiceQuantity
      });
    }

    //benefit
    for (int i = 0; i < attributes.serviceBenifit.length; i++) {
      benefitsList.add({'title': attributes.serviceBenifit[i].benifits});
    }

    //faq
    // for (int i = 0; i < attributes.serviceBenifit.length; i++) {
    //   benefitsList.add({'title': attributes.serviceBenifit[i].benifits});
    // }

    //
  }
}
