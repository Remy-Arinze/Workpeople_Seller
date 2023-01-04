import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/my_services/attribute_service.dart';
import 'package:qixer_seller/view/my_service/show_attribute_page.dart';

class MyServicesPopupMenu extends StatelessWidget {
  const MyServicesPopupMenu({
    Key? key,
    required this.serviceId,
  }) : super(key: key);

  final serviceId;

  @override
  Widget build(BuildContext context) {
    List popupMenuList = ['Show attributes', 'Delete'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            for (int i = 0; i < popupMenuList.length; i++)
              PopupMenuItem(
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    navigate(i, context, serviceId: serviceId);
                  });
                },
                child: Text(popupMenuList[i]),
              ),
          ],
        )
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
    }
  }
}
