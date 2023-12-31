import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';

import 'package:qixer_seller/services/live_chat/chat_list_service.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';

class ChatSearch extends StatelessWidget {
  const ChatSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ln = Provider.of<AppStringService>(context, listen: false);
    final searchController = TextEditingController();
    return Consumer<ChatListService>(
      builder: (context, provider, child) => Container(
          decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            controller: searchController,
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {}
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                provider.searchUser(value);
              } else {
                provider.setLoadedChatList();
              }
            },
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                hintText: ln.getString(ConstString.search),
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15)),
          )),
    );
  }
}
