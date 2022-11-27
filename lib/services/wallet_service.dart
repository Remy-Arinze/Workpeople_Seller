// import 'package:flutter/material.dart';

// class WalletService with ChangeNotifier {
//   var walletHistory;

//   bool isloading = false;
//   bool hasWalletHistory = true;

//   setLoadingStatus(bool status) {
//     isloading = status;
//     notifyListeners();
//   }

//   // Fetch subscription history
//   // fetchWalletHistory(BuildContext context) async {
//   //   var connection = await checkConnection();
//   //   if (!connection) return;

//   //   if (walletHistory != null) return;

//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   var token = prefs.getString('token');

//   //   setLoadingStatus(true);

//   //   var header = {
//   //     //if header type is application/json then the data should be in jsonEncode method
//   //     "Accept": "application/json",
//   //     // "Content-Type": "application/json"
//   //     "Authorization": "Bearer $token",
//   //   };

//   //   var response = await http.get(
//   //       Uri.parse('$baseApi/seller/subscription/history'),
//   //       headers: header);

//   //   final decodedData = jsonDecode(response.body);

//   //   if (response.statusCode == 201 &&
//   //       decodedData['subscription_history'].isNotEmpty) {
//   //     final data = SubscriptionHistoryModel.fromJson(jsonDecode(response.body));
//   //     subsHistoryList = data.subscriptionHistory;
//   //     notifyListeners();
//   //   } else {
//   //     print('Error fetching subscription history' + response.body);

//   //     hasSubsHistory = false;
//   //     notifyListeners();
//   //   }
//   // }
// }
