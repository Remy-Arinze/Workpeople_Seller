import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/dashboard_service.dart';
import 'package:qixer_seller/view/home/home_helper.dart';

class HomeCards extends StatelessWidget {
  const HomeCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //cards ==========>
        Consumer<AppStringService>(
      builder: (context, ln, child) => Consumer<DashboardService>(
        builder: (context, dProvider, child) =>
            dProvider.dashboardDataList.isNotEmpty
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dProvider.dashboardDataList[index].toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              AutoSizeText(
                                ln.getString(HomeHelper().cardTitles[index]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            ]),
                      );
                    },
                  )
                : Container(),
      ),
    );
  }
}
