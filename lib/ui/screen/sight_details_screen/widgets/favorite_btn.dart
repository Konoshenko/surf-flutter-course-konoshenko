import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/icons.dart';

class FavoriteBtn extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onClick;

  const FavoriteBtn({
    required this.isFavorite,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isFavorite ? iconHeartFull : iconHeart,
            color: lmSecondary2Color.withOpacity(0.56),
          ),
          const SizedBox(width: 8),
          Text(
            'В Избранное',
            style: Theme.of(context)
                .primaryTextTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
