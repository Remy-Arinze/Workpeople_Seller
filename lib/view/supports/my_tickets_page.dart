import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/ticket_services/support_ticket_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/constant_styles.dart';
import 'package:qixer_seller/view/orders/orders_helper.dart';
import 'package:qixer_seller/view/supports/components/support_status_change.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({Key? key}) : super(key: key);

  @override
  _MyTicketsPageState createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  @override
  void initState() {
    super.initState();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Support ticket', context, () {
          Navigator.pop(context);
        }),
        body: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown: context.watch<SupportTicketService>().currentPage > 1
              ? false
              : true,
          onRefresh: () async {
            final result =
                await Provider.of<SupportTicketService>(context, listen: false)
                    .fetchTicketList(context);
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result =
                await Provider.of<SupportTicketService>(context, listen: false)
                    .fetchTicketList(context);
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
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Consumer<AppStringService>(
              builder: (context, ln, child) => Consumer<SupportTicketService>(
                  builder: (context, provider, child) => provider
                          .ticketList.isNotEmpty
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: screenPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < provider.ticketList.length;
                                  i++)
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 3,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: cc.borderColor),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //title and ticket number
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            provider.goToMessagePage(
                                                context,
                                                provider.ticketList[i]
                                                    ['subject'],
                                                provider.ticketList[i]['id']);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        ln.getString(
                                                                'Ticket ID') +
                                                            ':' +
                                                            ' ${provider.ticketList[i]['id']}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color:
                                                                cc.primaryColor,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),

                                                  // put the hamburger icon here
                                                  PopupMenuButton(
                                                    // initialValue: 2,
                                                    child: const Icon(
                                                        Icons.more_vert),
                                                    itemBuilder: (context) {
                                                      return List.generate(1,
                                                          (index) {
                                                        return PopupMenuItem(
                                                          onTap: () async {
                                                            await Future
                                                                .delayed(
                                                                    Duration
                                                                        .zero);
                                                            provider.goToMessagePage(
                                                                context,
                                                                provider.ticketList[
                                                                        i]
                                                                    ['subject'],
                                                                provider.ticketList[
                                                                    i]['id']);
                                                          },
                                                          value: index,
                                                          child: Text(
                                                              ln.getString(
                                                                  'Chat')),
                                                        );
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),

                                              //Ticket title
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              CommonHelper().titleCommon(
                                                  provider.ticketList[i]
                                                      ['subject']),

                                              //Divider
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 17, bottom: 12),
                                                child: CommonHelper()
                                                    .dividerCommon(),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //Capsules
                                        Row(
                                          children: [
                                            OrdersHelper().statusCapsule(
                                                provider.ticketList[i]
                                                    ['priority'],
                                                cc.greyThree),
                                            const SizedBox(
                                              width: 11,
                                            ),

                                            //status
                                            InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) =>
                                                        SupportStatusChange(
                                                            ticketId: provider
                                                                    .ticketList[
                                                                i]['id']));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 8),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: cc.borderColor),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      provider.ticketList[i]
                                                          ['status'],
                                                      style: TextStyle(
                                                          color: cc.greyThree,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: cc.greyThree,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                )
                            ],
                          ),
                        )
                      : CommonHelper().nothingfound(context, "No ticket")),
            ),
          ),
        ));
  }
}
