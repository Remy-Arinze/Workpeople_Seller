import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/my_services/attribute_service.dart';
import 'package:qixer_seller/view/my_service/add_attribute_page.dart';
import 'package:qixer_seller/view/my_service/components/my_service_helper.dart';
import 'package:qixer_seller/view/my_service/edit_attribute_page.dart';
import 'package:qixer_seller/view/my_service/edit_service_page.dart';
import 'package:qixer_seller/view/my_service/show_attribute_page.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';

class MyServicesPopupMenu extends StatelessWidget {
  const MyServicesPopupMenu({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  final serviceId;

  @override
  Widget build(BuildContext context) {
    List popupMenuList = [
      ConstString.showAttrs,
      ConstString.editAttrs,
      ConstString.addAttrs,
      ConstString.deleteService,
      ConstString.editService
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            for (int i = 0; i < popupMenuList.length; i++)
              PopupMenuItem(
                onTap: () {
                  Future.delayed(
                    Duration.zero,
                    () {
                      navigate(
                        i,
                        context,
                        serviceId: serviceId,
                      );
                    },
                  );
                },
                child: Consumer<AppStringService>(
                    builder: (context, ln, child) =>
                        Text(ln.getString(popupMenuList[i]))),
              ),
          ],
        ),
      ],
    );
  }

  navigate(int i, BuildContext context, {required serviceId}) {
    if (i == 0) {
      Provider.of<AttributeService>(context, listen: false)
          .setAttrLodingStatus(true);
      Provider.of<AttributeService>(context, listen: false)
          .loadAttributes(context, serviceId: serviceId);
      //
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ShowAttributePage(
            serviceId: serviceId,
          ),
        ),
      );
    } else if (i == 1) {
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EditAttributePage(
            serviceId: serviceId,
          ),
        ),
      );
    } else if (i == 2) {
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => AddAttributePage(
            serviceId: serviceId,
          ),
        ),
      );
    } else if (i == 3) {
      //========>
      MyServiceHelper().deleteServicePopup(context, serviceId: serviceId);
    } else if (i == 4) {
      //========>
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EditServicePage(
            serviceId: serviceId,
          ),
        ),
      );
    }
  }
}
