import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/res.dart';
import 'package:places/ui/screen/add_sight/add_sight_screen/add_sight_screen.dart';

class AddSightBtn extends StatelessWidget {
  const AddSightBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AddSightScreen.routeName);
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xffFCDD3D), Color(0xff4CAF50)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(
                    iconPlus,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Новое место'.toUpperCase(),
                  style: textButtonElevation.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
