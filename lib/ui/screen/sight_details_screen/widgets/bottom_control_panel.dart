import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/res/res.dart';
import 'package:provider/provider.dart';

import 'favorite_btn.dart';

const _marginDay = 100;

class BottomControlPanel extends StatefulWidget {
  final Place sight;

  const BottomControlPanel(this.sight, {Key? key}) : super(key: key);

  @override
  BottomControlPanelState createState() => BottomControlPanelState();
}

class BottomControlPanelState extends State<BottomControlPanel> {
  final _isFavorite = StreamController<bool>();

  @override
  void initState() {
    super.initState();
    final placeInteractor = context.read<PlaceRepository>();
    _isFavorite.add(placeInteractor.favorites.contains(widget.sight));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: _onClickPlanning,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconCalendar,
                  color: lmSecondary2Color.withOpacity(0.56),
                ),
                const SizedBox(width: 8),
                Text(
                  'Запланировать',
                  style: Theme.of(context).primaryTextTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: lmSecondary2Color.withOpacity(0.56),
                      ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<bool>(
            stream: _isFavorite.stream,
            builder: (context, snap) {
              return FavoriteBtn(
                onClick: () {
                  if (snap.data ?? false) {
                    context
                        .read<PlaceRepository>()
                        .favorites
                        .remove(widget.sight);
                  } else {
                    context.read<PlaceRepository>().favorites.add(widget.sight);
                  }

                  Navigator.pop(context);
                },
                isFavorite: snap.data ?? false,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _isFavorite.close();
    super.dispose();
  }

  void _onClickPlanning() {
    if (Platform.isIOS) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (_) => Container(
          color: Colors.white,
          height: 200,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (value) {
                    return;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: _marginDay)),
        lastDate: DateTime.now().add(const Duration(days: _marginDay)),
      ).then((value) =>
          showTimePicker(context: context, initialTime: TimeOfDay.now()));
    }
  }
}
