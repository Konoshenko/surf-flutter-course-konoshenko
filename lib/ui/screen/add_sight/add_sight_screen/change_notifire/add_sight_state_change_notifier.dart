import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:places/ui/screen/add_sight/select_category_screen.dart';

class AddSightStateChangeNotifier extends ChangeNotifier {
  Set<String> images = {};
  SightCategory? category;

  FutureOr<SightCategory?> changeCategory(SightCategory? value) {
    category = value;
    notifyListeners();
  }

  void addImage(String value) {
    images.add(value);
    notifyListeners();
  }

  void removeImage(String value) {
    images.remove(value);
    notifyListeners();
  }
}
