// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/live_chat/chat_message_service.dart';
import 'package:qixer_seller/services/push_notification_service.dart';
import 'package:qixer_seller/services/rtl_service.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/others_helper.dart';

class ChatMessagePage extends StatefulWidget {
  const ChatMessagePage({
    Key? key,
    required this.title,
    required this.receiverId,
    required this.currentUserId,
    required this.userName,
  }) : super(key: key);

  final String title;
  final receiverId;
  final currentUserId;
  final userName;

  @override
  State<ChatMessagePage> createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  @override
  void initState() {
    super.initState();

    apiKey =
        Provider.of<PushNotificationService>(context, listen: false).apiKey;
    secret =
        Provider.of<PushNotificationService>(context, listen: false).secret;

    cluster = Provider.of<PushNotificationService>(context, listen: false)
        .pusherCluster;

    connectToPusher();
    channelName = 'private-chat-message.${widget.currentUserId}';
  }

  bool firstTimeLoading = true;

  TextEditingController sendMessageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  late String apiKey;
  late String secret;
  var cluster;
  late String channelName;
  final eventName = 'client-message.sent';

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 10,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  void connectToPusher() async {
    try {
      await pusher.init(
          apiKey: apiKey,
          cluster: cluster,
          onEvent: onEvent,
          onSubscriptionSucceeded: onSubscriptionSucceeded,
          onConnectionStateChange: onConnectionStateChange,
          onAuthorizer: onAuthorizer);
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    } catch (e) {
      //if already initialized then just connect to the channel
      print("ERROR: $e");
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    }
  }

//========>
  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    var stringToSign = '$socketId:$channelName';

    var hmacSha256 = Hmac(sha256, utf8.encode(secret)); // HMAC-SHA256
    var digest = hmacSha256.convert(utf8.encode(stringToSign));

    return {
      "auth": "$apiKey:$digest",
      "user_data": "{\"id\":\"1\"}",
    };
  }

  void onEvent(PusherEvent event) {
    // print('message received::: $event');
    //add message to message list to show in the ui
    final messageReceived = jsonDecode(event.data)['message']['message'];
    final receivedUserId = jsonDecode(event.data)['message']['from_user']['id'];
    if (receivedUserId == widget.receiverId) {
      Provider.of<ChatMessagesService>(context, listen: false)
          .addNewMessage(messageReceived, null, receivedUserId);
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Provider.of<ChatMessagesService>(context, listen: false)
                        .setMessageListDefault();
                    pusher.disconnect();
                    pusher.unsubscribe(channelName: channelName);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: cc.greyParagraph,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.userName.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          Provider.of<ChatMessagesService>(context, listen: false)
              .setMessageListDefault();

          pusher.disconnect();
          pusher.unsubscribe(channelName: channelName);
          return Future.value(true);
        },
        child: Consumer<AppStringService>(
          builder: (context, ln, child) => Consumer<ChatMessagesService>(
              builder: (context, provider, child) {
            if (provider.messagesList.isNotEmpty &&
                provider.sendLoading == false) {
              Future.delayed(const Duration(milliseconds: 500), () {
                _scrollDown();
              });
            }
            return Stack(
              children: [
                provider.isloading == false
                    ?
                    //chat messages
                    Container(
                        margin: const EdgeInsets.only(bottom: 60),
                        child: SmartRefresher(
                          controller: refreshController,
                          reverse: true,
                          enablePullUp: true,
                          enablePullDown:
                              context.watch<ChatMessagesService>().currentPage >
                                      1
                                  ? false
                                  : true,
                          onRefresh: () async {
                            final result =
                                await Provider.of<ChatMessagesService>(context,
                                        listen: false)
                                    .fetchMessages(context,
                                        receiverId: widget.receiverId);
                            if (result) {
                              refreshController.refreshCompleted();
                            } else {
                              refreshController.refreshFailed();
                            }
                          },
                          onLoading: () async {
                            final result =
                                await Provider.of<ChatMessagesService>(context,
                                        listen: false)
                                    .fetchMessages(context,
                                        receiverId: widget.receiverId);
                            if (result) {
                              debugPrint('loadcomplete ran');
                              //loadcomplete function loads the data again
                              refreshController.loadComplete();
                            } else {
                              debugPrint('no more data');
                              refreshController.loadNoData();

                              Future.delayed(const Duration(seconds: 1), () {
                                //it will reset footer no data state to idle and will let us load again
                                refreshController.resetNoData();
                              });
                            }
                          },
                          child: Container(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: provider.messagesList.length,
                              shrinkWrap: true,
                              reverse: true,
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              physics: physicsCommon,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      provider.messagesList[index]
                                                  ['fromUser'] !=
                                              widget.currentUserId
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Consumer<RtlService>(
                                        builder: (context, rtlP, child) =>
                                            Container(
                                          padding: EdgeInsets.only(
                                              left: provider.messagesList[index]
                                                          ['fromUser'] !=
                                                      widget.currentUserId
                                                  ? rtlP.direction == 'ltr'
                                                      ? 10
                                                      : 90
                                                  : rtlP.direction == 'ltr'
                                                      ? 90
                                                      : 10,
                                              right:
                                                  provider.messagesList[index]
                                                              ['type'] ==
                                                          "seller"
                                                      ? rtlP.direction == 'ltr'
                                                          ? 90
                                                          : 10
                                                      : rtlP.direction == 'ltr'
                                                          ? 10
                                                          : 90,
                                              top: 10,
                                              bottom: 10),
                                          child: Align(
                                            alignment:
                                                (provider.messagesList[index]
                                                            ['fromUser'] !=
                                                        widget.currentUserId
                                                    ? Alignment.topLeft
                                                    : Alignment.topRight),
                                            child: Column(
                                              crossAxisAlignment:
                                                  (provider.messagesList[index]
                                                              ['fromUser'] !=
                                                          widget.currentUserId
                                                      ? CrossAxisAlignment.start
                                                      : CrossAxisAlignment.end),
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: (provider.messagesList[
                                                                    index]
                                                                ['fromUser'] !=
                                                            widget.currentUserId
                                                        ? Colors.grey.shade200
                                                        : cc.primaryColor),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  //message =====>
                                                  child: Text(
                                                    provider.messagesList[index]
                                                            ['message']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: (provider.messagesList[
                                                                        index][
                                                                    'fromUser'] !=
                                                                widget
                                                                    .currentUserId
                                                            ? Colors.grey[800]
                                                            : Colors.white)),
                                                  ),
                                                ),
                                                // provider.messagesList[index]
                                                //             ['attachment'] !=
                                                //         null
                                                // ? Container(
                                                //     margin: const EdgeInsets.only(
                                                //         top: 11),
                                                //     child: provider.messagesList[
                                                //                     index]
                                                //                 ['imagePicked'] ==
                                                //             false
                                                //         ? InkWell(
                                                //             onTap: () {
                                                //               Navigator.push(
                                                //                 context,
                                                //                 MaterialPageRoute<
                                                //                     void>(
                                                //                   builder: (BuildContext
                                                //                           context) =>
                                                //                       ImageBigPreviewPage(
                                                //                     networkImgLink:
                                                //                         provider.messagesList[
                                                //                                 index]
                                                //                             [
                                                //                             'attachment'],
                                                //                   ),
                                                //                 ),
                                                //               );
                                                //             },
                                                //             child:
                                                //                 CachedNetworkImage(
                                                //               imageUrl: provider
                                                //                               .messagesList[
                                                //                           index][
                                                //                       'attachment'] ??
                                                //                   placeHolderUrl,
                                                //               placeholder:
                                                //                   (context, url) {
                                                //                 return Image.asset(
                                                //                     'assets/images/placeholder.png');
                                                //               },
                                                //               height: 150,
                                                //               width: screenWidth /
                                                //                       2 -
                                                //                   50,
                                                //               fit:
                                                //                   BoxFit.fitWidth,
                                                //             ),
                                                //           )
                                                //         : InkWell(
                                                //             onTap: () {
                                                //               Navigator.push(
                                                //                 context,
                                                //                 MaterialPageRoute<
                                                //                     void>(
                                                //                   builder: (BuildContext
                                                //                           context) =>
                                                //                       ImageBigPreviewPage(
                                                //                     assetImgLink:
                                                //                         provider.messagesList[
                                                //                                 index]
                                                //                             [
                                                //                             'attachment'],
                                                //                   ),
                                                //                 ),
                                                //               );
                                                //             },
                                                //             child: Image.file(
                                                //               File(provider
                                                //                           .messagesList[
                                                //                       index]
                                                //                   ['attachment']),
                                                //               height: 150,
                                                //               width: screenWidth /
                                                //                       2 -
                                                //                   50,
                                                //               fit: BoxFit.cover,
                                                //             ),
                                                //           ),
                                                //   )
                                                // : Container()
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // provider.messagesList[index].type == "seller"
                                    //     ? Container(
                                    //         margin: const EdgeInsets.only(
                                    //           right: 13,
                                    //         ),
                                    //         width: 15,
                                    //         height: 15,
                                    //         decoration: const BoxDecoration(
                                    //             shape: BoxShape.circle,
                                    //             color: Colors.white),
                                    //         child: ClipRRect(
                                    //           borderRadius: BorderRadius.circular(100),
                                    //           child: Image.network(
                                    //             'https://cdn.pixabay.com/photo/2016/09/08/13/58/desert-1654439__340.jpg',
                                    //             fit: BoxFit.cover,
                                    //           ),
                                    //         ),
                                    //       )
                                    //     : Container(),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : OthersHelper().showLoading(cc.primaryColor),

                //write message section
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, bottom: 10, top: 10, right: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        pickedImage != null
                            ? Image.file(
                                File(pickedImage!.path),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              )
                            : Container(),
                        const SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          child: TextField(
                            controller: sendMessageController,
                            decoration: InputDecoration(
                                hintText: "${ln.getString("Write message")}...",
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        //pick image =====>
                        // IconButton(
                        //     onPressed: () async {
                        //       pickedImage = await provider.pickImage();
                        //       setState(() {});
                        //     },
                        //     icon: const Icon(Icons.attachment)),

                        //send message button
                        const SizedBox(
                          width: 13,
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            if (sendMessageController.text.isNotEmpty) {
                              //hide keyboard
                              FocusScope.of(context).unfocus();
                              //send message

                              provider.sendMessage(
                                  widget.receiverId,
                                  sendMessageController.text.trim(),
                                  null,
                                  context);
                              //clear input field
                              sendMessageController.clear();
                              //clear image
                              setState(() {
                                pickedImage = null;
                              });
                            } else {
                              OthersHelper().showToast(
                                  'Please write a message first', Colors.black);
                            }
                          },
                          child: provider.sendLoading == false
                              ? const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 18,
                                )
                              : const SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1.5,
                                  ),
                                ),
                          backgroundColor: cc.primaryColor,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}