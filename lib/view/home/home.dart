import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:provider/provider.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/dashboard_service.dart';
import 'package:qixer_seller/services/push_notification_service.dart';
import 'package:qixer_seller/services/recent_orders_service.dart';
import 'package:qixer_seller/services/rtl_service.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:qixer_seller/view/home/chart_dashboard.dart';
import 'package:qixer_seller/view/home/components/sidebar_drawer.dart';
import 'package:qixer_seller/view/home/home_helper.dart';
import 'package:qixer_seller/view/orders/all_orders_page.dart';
import 'package:qixer_seller/view/profile/profile_page.dart';

import '../../services/order_details_service.dart';
import '../../services/profile_service.dart';
import '../orders/order_details_page.dart';
import 'components/section_title.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    runAtStart(context);
    initPusherBeams(context);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? currentBackPressTime;

  //Notification alert
  //=================>
  initPusherBeams(BuildContext context) async {
    if (!kIsWeb) {
      // Let's see our current interests
      print(await PusherBeams.instance.getDeviceInterests());

      await PusherBeams.instance
          .onInterestChanges((interests) => {print('Interests: $interests')});
      await PusherBeams.instance
          .onMessageReceivedInTheForeground(_onMessageReceivedInTheForeground);
    }
    await _checkForInitialMessage(context);
  }

  Future<void> _checkForInitialMessage(BuildContext context) async {
    final initialMessage = await PusherBeams.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotificationService().notificationAlert(
          context, 'Initial Message Is:', initialMessage.toString());
    }
  }

  void _onMessageReceivedInTheForeground(Map<Object?, Object?> data) {
    PushNotificationService().notificationAlert(
        context, data["title"].toString(), data["body"].toString());
  }

  @override
  Widget build(BuildContext context) {
    //fetch data
    Provider.of<DashboardService>(context, listen: false).fetchData();
    Provider.of<RecentOrdersService>(context, listen: false)
        .fetchRecentOrders();

    ConstantColors cc = ConstantColors();
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: const SidebarDrawer(),
        body: Consumer<AppStringService>(
          builder: (context, ln, child) => WillPopScope(
            onWillPop: () {
              DateTime now = DateTime.now();
              if (currentBackPressTime == null ||
                  now.difference(currentBackPressTime!) >
                      const Duration(seconds: 2)) {
                currentBackPressTime = now;
                OthersHelper().showToast(
                    ln.getString("Press again to exit"), Colors.black);
                return Future.value(false);
              }
              return Future.value(true);
            },
            child: SafeArea(
              child: SingleChildScrollView(
                physics: physicsCommon,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //profile image and name ========>
                        // const NameImage(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 40, bottom: 12),
                                    child: Icon(
                                      Icons.menu,
                                      color: cc.greyFour,
                                    ))),
                            Consumer<ProfileService>(
                              builder: (context, profileProvider, child) =>
                                  profileProvider.profileDetails != null
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const ProfilePage(),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                ln.getString('Welcome!'),
                                                style: TextStyle(
                                                  color: cc.greyParagraph,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                profileProvider
                                                        .profileDetails.name ??
                                                    '',
                                                style: TextStyle(
                                                  color: cc.greyFour,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                            )
                          ],
                        ),

                        //cards ==========>
                        Consumer<DashboardService>(
                          builder: (context, dProvider, child) => dProvider
                                  .dashboardDataList.isNotEmpty
                              ? GridView.builder(
                                  clipBehavior: Clip.none,
                                  gridDelegate: const FlutterzillaFixedGridView(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 19,
                                      crossAxisSpacing: 19,
                                      height: 100),
                                  padding: const EdgeInsets.only(top: 12),
                                  itemCount: HomeHelper().cardTitles.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: HomeHelper().cardColors[index],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              dProvider.dashboardDataList[index]
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            AutoSizeText(
                                              ln.getString(HomeHelper()
                                                  .cardTitles[index]),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            )
                                          ]),
                                    );
                                  },
                                )
                              : Container(),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        const ChartDashboard(),
                        // const ChartLineDashboard(),
                        // const SizedBox(
                        //   height: 200,
                        //   child: LineChartMrx(),
                        // ),

                        const SizedBox(
                          height: 20,
                        ),

                        //Recent orders
                        Consumer<RtlService>(
                          builder: (context, rtlP, child) =>
                              Consumer<RecentOrdersService>(
                            builder: (context, rProvider, child) => rProvider
                                        .recentOrdersData !=
                                    null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (rProvider.recentOrdersData
                                          .recentOrders.isNotEmpty)
                                        SectionTitle(
                                          cc: cc,
                                          title: ln.getString('Recent Orders'),
                                          pressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const AllOrdersPage(),
                                              ),
                                            );
                                          },
                                        ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ListView.builder(
                                          itemCount: rProvider.recentOrdersData
                                              .recentOrders.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                Provider.of<OrderDetailsService>(
                                                        context,
                                                        listen: false)
                                                    .fetchOrderDetails(rProvider
                                                        .recentOrdersData
                                                        .recentOrders[index]
                                                        .id);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const OrderDetailsPage(),
                                                    ));
                                              },
                                              child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 2,
                                                      vertical: 18),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(.2),
                                                      width: 1.0,
                                                    ),
                                                  )),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${ln.getString("Order ID:")} ${rProvider.recentOrdersData.recentOrders[index].id}",
                                                              style: TextStyle(
                                                                color: cc
                                                                    .primaryColor,
                                                                fontSize: 12,
                                                                height: 1.4,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            Text(
                                                              rProvider
                                                                  .recentOrdersData
                                                                  .recentOrders[
                                                                      index]
                                                                  .name
                                                                  .toString(),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: cc
                                                                      .greyFour,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 60,
                                                        child: Text(
                                                          "${rtlP.currency}${rProvider.recentOrdersData.recentOrders[index].total}",
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              color:
                                                                  cc.greyFour,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            );
                                          }),
                                    ],
                                  )
                                : OthersHelper().showLoading(cc.primaryColor),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
