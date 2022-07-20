import 'package:flutter/material.dart';

class WithdrawService with ChangeNotifier {
  bool isLoading = false;
  //gateway dropdown
  var gatewayDropdownList = ['Paypal', 'Cashfree', 'Paytm'];
  var gatewayDropdownIndexList = ['Paypal', 'Cashfree', 'Paytm'];
  var selectedgateway = 'Paypal';
  var selectedgatewayId = '';

  setgatewayValue(value) {
    selectedgateway = value;
    notifyListeners();
  }

  setSelectedgatewayId(value) {
    selectedgatewayId = value;
    notifyListeners();
  }

  // fetchOrderDropdown(BuildContext context) async {
  //   hasOrder = true;
  //   Future.delayed(const Duration(microseconds: 500), () {
  //     notifyListeners();
  //   });
  //   var orders = await Provider.of<MyOrdersService>(context, listen: false)
  //       .fetchMyOrders();
  //   if (orders != 'error') {
  //     print('orders is $orders');
  //     for (int i = 0; i < orders.length; i++) {
  //       orderDropdownList.add('#${orders[i].id}');
  //       orderDropdownIndexList.add(orders[i].id);
  //     }
  //     selectedOrder = '#${orders[0].id}';
  //     selectedOrderId = orders[0].id;
  //     hasOrder = true;
  //     notifyListeners();
  //   } else {
  //     hasOrder = false;
  //     notifyListeners();
  //   }
  // }

  //create ticket ====>

  // createTicket(BuildContext context, subject, gateway, desc, orderId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? userId = prefs.getInt('userId');
  //   var token = prefs.getString('token');

  //   var header = {
  //     //if header type is application/json then the data should be in jsonEncode method
  //     "Accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Authorization": "Bearer $token",
  //   };

  //   var data = jsonEncode({
  //     'subject': subject,
  //     'gateway': gateway,
  //     'description': desc,
  //     'order_id': orderId
  //   });

  //   var connection = await checkConnection();
  //   if (connection) {
  //     isLoading = true;
  //     notifyListeners();
  //     //if connection is ok
  //     var response = await http.post(Uri.parse('$baseApi/user/ticket/create'),
  //         headers: header, body: data);
  //     isLoading = false;
  //     notifyListeners();
  //     if (response.statusCode == 201) {
  //       OthersHelper().showToast('Ticket created successfully', Colors.black);

  //       Provider.of<SupportTicketService>(context, listen: false)
  //           .addNewDataToTicketList(
  //               subject,
  //               jsonDecode(response.body)['ticket_info']['id'],
  //               gateway,
  //               'open');
  //       Navigator.pop(context);
  //     } else {
  //       OthersHelper().showToast('Something went wrong', Colors.black);
  //     }
  //   }
  // }
}
