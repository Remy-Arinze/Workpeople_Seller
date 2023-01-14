import 'package:flutter/widgets.dart';

class PermissionsService with ChangeNotifier {
  bool jobPermission = false;
  bool subsPermission = false;
  bool chatPermission = false;
  bool walletPermission = false;
}
