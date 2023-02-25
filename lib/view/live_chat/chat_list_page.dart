import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/live_chat/chat_list_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:qixer_seller/view/live_chat/chat_message_page.dart';
import 'package:qixer_seller/view/live_chat/components/chat_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: physicsCommon,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Consumer<AppStringService>(
              builder: (context, ln, child) => Consumer<ChatListService>(
                  builder: (context, provider, child) => Column(
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
                              Text(
                                ln.getString("Conversations"),
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          provider.isLoading == false
                              ? provider.chatList.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //Search bar

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        const ChatSearch(),

                                        const SizedBox(
                                          height: 20,
                                        ),

                                        for (int i = 0;
                                            i < provider.chatList.length;
                                            i++)
                                          InkWell(
                                            onTap: () async {
                                              print(
                                                  'clicked on user ID ${provider.chatList[i].buyerList.id}');

                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var currentUserId =
                                                  prefs.getInt('userId')!;

                                              //======>
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ChatMessagePage(
                                                    title: provider.chatList[i]
                                                        .buyerList.name,
                                                    receiverId: provider
                                                        .chatList[i]
                                                        .buyerList
                                                        .id,
                                                    currentUserId:
                                                        currentUserId,
                                                    userName: provider
                                                        .chatList[i]
                                                        .buyerList
                                                        .name,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: <Widget>[
                                                            CircleAvatar(
                                                              backgroundImage: NetworkImage(provider
                                                                          .chatListImage[
                                                                      i] is List
                                                                  ? userPlaceHolderUrl
                                                                  : (provider.chatListImage[i]['img_url'] !=
                                                                              null &&
                                                                          provider.chatListImage[i]['img_url'] !=
                                                                              "")
                                                                      ? provider
                                                                              .chatListImage[i]
                                                                          [
                                                                          'img_url']
                                                                      : userPlaceHolderUrl),
                                                              maxRadius: 25,
                                                            ),
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                color: Colors
                                                                    .transparent,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      provider
                                                                          .chatList[
                                                                              i]
                                                                          .buyerList
                                                                          .name
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16),
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
                                      ],
                                    )
                                  : Container(
                                      height: screenHeight - 200,
                                      alignment: Alignment.center,
                                      child: Text(ln.getString(
                                          'You do not have any active conversation')))
                              : SizedBox(
                                  height: screenHeight - 200,
                                  child: OthersHelper()
                                      .showLoading(cc.primaryColor),
                                ),
                        ],
                      )),
            ),
          ),
        ),
      ),
    );
  }
}