import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

import '../select_category_screen.dart';
import 'change_notifire/add_sight_state_change_notifier.dart';

class AddSightScreenWM extends WidgetModel {
  final AddSightStateChangeNotifier state = AddSightStateChangeNotifier();

  final TextEditingController textCtrlTitle = TextEditingController();
  final TextEditingController textCtrlDescription = TextEditingController();
  final TextEditingController textCtrlLat = TextEditingController();
  final TextEditingController textCtrlLon = TextEditingController();

  final FocusNode focusNodeTitle = FocusNode();
  final FocusNode focusNodeDescription = FocusNode();
  final FocusNode focusNodeLat = FocusNode();
  final FocusNode focusNodeLon = FocusNode();

  final _btnStatusController = StreamController<bool>();

  final BuildContext _context;

  Stream<bool> get btnStatus => _btnStatusController.stream;

  AddSightScreenWM(this._context) : super(const WidgetModelDependencies());

  @override
  void onLoad() {
    super.onLoad();

    textCtrlTitle.addListener(_isValid);
    textCtrlDescription.addListener(_isValid);
    textCtrlLat.addListener(_isValid);
    textCtrlLon.addListener(_isValid);
  }

  @override
  void dispose() {
    _btnStatusController.close();

    textCtrlTitle.dispose();
    textCtrlDescription.dispose();
    textCtrlLat.dispose();
    textCtrlLon.dispose();
    super.dispose();
  }

  void onSelectCategoryPressed() {
    Navigator.push<SightCategory?>(
      _context,
      MaterialPageRoute(builder: (_) => const SelectCategoryScreen()),
    ).then<SightCategory?>(state.changeCategory);
    _isValid();
  }

  void clearAllFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onSavePressed() {
    // TODO(konoshenko): Add API call after add map with images
    Navigator.pop(_context);
  }

  void _isValid() {
    final isValid = state.category != null &&
        textCtrlDescription.text.isNotEmpty &&
        textCtrlLon.text.isNotEmpty &&
        textCtrlLat.text.isNotEmpty &&
        textCtrlTitle.text.isNotEmpty;

    _btnStatusController.add(isValid);
  }
}

AddSightScreenWM createAddSightScreenWM(BuildContext context) =>
    AddSightScreenWM(context);
