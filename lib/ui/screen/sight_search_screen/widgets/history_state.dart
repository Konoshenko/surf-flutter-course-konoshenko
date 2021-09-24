import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/redux/action/search_action.dart';
import 'package:places/redux/app_state.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_style.dart';
import 'package:places/ui/components/label_text_widget.dart';

class HistoryState extends StatefulWidget {
  final SearchInteractor searchInteractor;

  const HistoryState(this.searchInteractor, {Key? key}) : super(key: key);

  @override
  _HistoryStateState createState() => _HistoryStateState();
}

class _HistoryStateState extends State<HistoryState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            LabelTextWidget(
              widget.searchInteractor.history.isNotEmpty
                  ? 'Вы искали'
                  : 'История поиска пуста',
            ),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: widget.searchInteractor.history.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.searchInteractor.history[index],
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff7C7E92),
                                ),
                          ),
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            iconClose,
                            color: const Color(0xff7C7E92),
                            width: 20,
                          ),
                          onPressed: () {
                            StoreProvider.of<AppState>(context).dispatch(
                              RemoveRequestFromHistoryAction(index),
                            );
                          },
                        ),
                      ],
                    ),
                    if (index != widget.searchInteractor.history.length - 1)
                      const Divider(),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(ClearHistorySearchAction());
              },
              child: widget.searchInteractor.history.isNotEmpty
                  ? Text(
                      'Очистить историю',
                      style: textMedium.copyWith(color: lmGreenColor),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
