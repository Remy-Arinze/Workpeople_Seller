import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/dashboard_service.dart';
import 'package:qixer_seller/services/recent_orders_service.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:qixer_seller/view/home/components/sidebar_drawer.dart';
import 'package:qixer_seller/view/home/home_helper.dart';
import 'package:qixer_seller/view/orders/all_orders_page.dart';

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
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        body: SafeArea(
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
                        // Icon(
                        //   Icons.notifications_none_outlined,
                        //   color: cc.greyFour,
                        // )
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
                                      borderRadius: BorderRadius.circular(10)),
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
                                        Text(
                                          HomeHelper().cardTitles[index],
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

                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // const ChartDashboard(),

                    const SizedBox(
                      height: 30,
                    ),
                    SectionTitle(
                      cc: cc,
                      title: 'Recent Orders',
                      pressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const AllOrdersPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //Recent orders
                    Consumer<RecentOrdersService>(
                      builder: (context, rProvider, child) => rProvider
                                  .recentOrdersData !=
                              null
                          ? ListView.builder(
                              itemCount: rProvider
                                  .recentOrdersData.recentOrders.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        //                   <--- right side
                                        color: Colors.grey.withOpacity(.2),
                                        width: 1.0,
                                      ),
                                    )),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            rProvider.recentOrdersData
                                                .recentOrders[index].name
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: cc.greyFour,
                                                fontSize: 15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Text(
                                            "\$${rProvider.recentOrdersData.recentOrders[index].total}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: cc.greyFour,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ));
                              })
                          : OthersHelper().showLoading(cc.primaryColor),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
