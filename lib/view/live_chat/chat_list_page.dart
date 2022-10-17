import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/ticket_services/support_messages_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/view/live_chat/chat_message_page.dart';
import 'package:qixer_seller/view/live_chat/components/chat_search.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.only(
                              right: 20, top: 20, bottom: 20),
                          child: const Icon(Icons.arrow_back_ios)),
                    ),
                    const Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                //Search bar

                const SizedBox(
                  height: 10,
                ),

                const ChatSearch(),

                const SizedBox(
                  height: 20,
                ),

                for (int i = 0; i < 5; i++)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const ChatMessagePage(
                            title: 'sdfdf',
                            buyerId: 1,
                            sellerId: 1,
                          ),
                        ),
                      );

                      //fetch message
                      Provider.of<SupportMessagesService>(context,
                              listen: false)
                          .fetchMessages(21);
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://cdn.pixabay.com/photo/2022/10/10/06/12/yellow-flower-7510901_960_720.jpg'),
                                      maxRadius: 25,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const <Widget>[
                                            Text(
                                              'SM Saleheen',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        CommonHelper().dividerCommon()
                      ],
                    ),
                  ),

                // ==============>
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
