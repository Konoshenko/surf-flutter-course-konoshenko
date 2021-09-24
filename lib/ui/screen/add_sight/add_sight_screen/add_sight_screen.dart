import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/res/res.dart';
import 'package:places/res/text_style.dart';
import 'package:places/ui/components/add_signt_screen/components.dart';
import 'package:places/ui/components/label_text_widget.dart';
import 'package:places/ui/screen/add_sight/add_sight_screen/add_sight_screen_wm.dart';
import 'package:places/ui/screen/add_sight/add_sight_screen/add_sight_strings.dart';
import 'package:places/ui/screen/add_sight/add_sight_screen/change_notifire/add_sight_state_change_notifier.dart';
import 'package:places/ui/screen/add_sight/select_category_screen.dart';
import 'package:provider/provider.dart';

import '../../sight_search_screen/widgets/photo_gallery.dart';

class AddSightScreen extends CoreMwwmWidget<AddSightScreenWM> {
  static const String routeName = '/add_sight_screen';

  const AddSightScreen({
    Key? key,
    required WidgetModelBuilder<AddSightScreenWM> widgetModelBuilder,
  }) : super(key: key, widgetModelBuilder: widgetModelBuilder);

  @override
  WidgetState<CoreMwwmWidget<AddSightScreenWM>, AddSightScreenWM>
      createWidgetState() => _AddSightScreenState();
}

class _AddSightScreenState
    extends WidgetState<AddSightScreen, AddSightScreenWM> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => wm.state,
      child: Consumer<AddSightStateChangeNotifier>(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        AddSightStrings.cancel,
                        style: textMedium.copyWith(
                          color: lmSecondary2Color,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AddSightStrings.titleScreen,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  PhotoGallery(state.images),
                  Column(
                    children: [
                      LabelTextWidget(AddSightStrings.categoryTitle),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: wm.onSelectCategoryPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.category?.toText() ??
                                  AddSightStrings.defaultCategoryTitle,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle2!
                                  .copyWith(fontWeight: FontWeight.w300),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  LabelTextWidget(AddSightStrings.nameTitle),
                  const SizedBox(height: 16),
                  TextField(
                    focusNode: wm.focusNodeTitle,
                    controller: wm.textCtrlTitle,
                    decoration: InputDecoration(
                      hintText: AddSightStrings.textFieldNamePlace,
                      suffixIconConstraints: const BoxConstraints(
                        maxHeight: 40,
                        minWidth: 40,
                      ),
                      suffixIcon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: wm.focusNodeTitle.hasFocus
                            ? TextFieldCleanSuffix(wm.textCtrlTitle)
                            : const SizedBox.shrink(),
                      ),
                    ),
                    onSubmitted: (value) => wm.focusNodeLat.requestFocus(),
                    cursorHeight: 24,
                    cursorWidth: 1,
                    cursorColor: lmMainColor,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            LabelTextWidget(AddSightStrings.lonTitle),
                            const SizedBox(height: 16),
                            TextField(
                              focusNode: wm.focusNodeLat,
                              controller: wm.textCtrlLat,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              onSubmitted: (value) =>
                                  wm.focusNodeLon.requestFocus(),
                              decoration: InputDecoration(
                                hintText: AddSightStrings.textFieldHintText,
                                suffixIconConstraints:
                                    const BoxConstraints(maxHeight: 40),
                                suffixIcon: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: wm.focusNodeLat.hasFocus
                                      ? TextFieldCleanSuffix(wm.textCtrlTitle)
                                      : const SizedBox.shrink(),
                                ),
                              ),
                              cursorHeight: 24,
                              cursorWidth: 1,
                              cursorColor: lmMainColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            LabelTextWidget(AddSightStrings.latTitle),
                            const SizedBox(height: 16),
                            TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onSubmitted: (value) =>
                                  wm.focusNodeDescription.requestFocus(),
                              focusNode: wm.focusNodeLon,
                              controller: wm.textCtrlLon,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: AddSightStrings.textFieldHintText,
                                suffixIconConstraints: const BoxConstraints(
                                  maxHeight: 40,
                                  minWidth: 40,
                                ),
                                suffixIcon: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: wm.focusNodeLon.hasFocus
                                      ? TextFieldCleanSuffix(wm.textCtrlLon)
                                      : const SizedBox.shrink(),
                                ),
                              ),
                              cursorHeight: 24,
                              cursorWidth: 1,
                              cursorColor: lmMainColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AddSightStrings.selectFromMap,
                    style: textMedium.copyWith(color: lmGreenColor),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      LabelTextWidget(AddSightStrings.descriptionTitle),
                      const SizedBox(height: 16),
                      TextField(
                        focusNode: wm.focusNodeDescription,
                        controller: wm.textCtrlDescription,
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        minLines: 3,
                        decoration: InputDecoration(
                          hintText: AddSightStrings.textFieldHintText,
                          contentPadding: const EdgeInsets.all(16.0),
                          suffixIconConstraints: const BoxConstraints(
                            maxHeight: 40,
                            minWidth: 40,
                          ),
                          suffixIcon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: wm.focusNodeDescription.hasFocus
                                ? TextFieldCleanSuffix(
                                    wm.textCtrlDescription,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                        cursorHeight: 24,
                        cursorWidth: 1,
                        onSubmitted: (value) => wm.clearAllFocus(),
                        cursorColor: lmMainColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<bool>(
                stream: wm.btnStatus,
                builder: (context, snapshot) {
                  return ElevatedButton(
                    onPressed: snapshot.data ?? false
                        ? wm.onSavePressed
                        : null,
                    child: Text(
                      AddSightStrings.create,
                      style: textButtonElevation,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
