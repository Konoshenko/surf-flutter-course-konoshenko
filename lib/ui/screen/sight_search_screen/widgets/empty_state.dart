import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/res.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconSearch,
          color: const Color(0xff7C7E92).withOpacity(0.54),
          width: 50,
          height: 50,
        ),
        const SizedBox(height: 32),
        Text(
          'Ничего не найдено.',
          style: Theme.of(context)
              .primaryTextTheme
              .caption!
              .copyWith(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          'Попробуйте изменить параметры поиска',
          style: Theme.of(context).primaryTextTheme.caption,
        ),
      ],
    );
  }
}
