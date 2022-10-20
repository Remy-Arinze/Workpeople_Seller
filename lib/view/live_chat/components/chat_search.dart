import 'package:flutter/material.dart';

class ChatSearch extends StatelessWidget {
  const ChatSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(5)),
        child: TextFormField(
          controller: searchController,
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {}
          },
          onChanged: (value) {
            if (value.isNotEmpty) {}
          },
          style: const TextStyle(fontSize: 14),
          decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 15)),
        ));
  }
}
