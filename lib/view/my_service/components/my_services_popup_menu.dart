import 'package:flutter/material.dart';

class MyServicesPopupMenu extends StatelessWidget {
  const MyServicesPopupMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List popupMenuList = ['Edit', 'Delete'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            for (int i = 0; i < popupMenuList.length; i++)
              PopupMenuItem(
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    navigate(i, context);
                  });
                },
                child: Text(popupMenuList[i]),
              ),
          ],
        )
      ],
    );
  }

  navigate(int i, BuildContext context) {
    if (i == 0) {
      // return Navigator.push(
      //   context,
      //   MaterialPageRoute<void>(
      //     builder: (BuildContext context) => EditJobPage(
      //       jobIndex: jobIndex,
      //       jobId: jobId,
      //     ),
      //   ),
      // );
    }
  }
}
