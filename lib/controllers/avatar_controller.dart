import 'package:flutter/cupertino.dart';

class AvatarController extends ChangeNotifier {
  String profile = '';
  int selectedIndex = -1;

  void setProfile(String profile) {
    this.profile = profile;
    print('profile set to ' + profile);
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    print('selectedIndex set to ' + index.toString());
    notifyListeners();
  }
}
