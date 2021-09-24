import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_style.dart';

class SelectCategoryScreen extends StatefulWidget {
  static const String routeName = '/select_category_screen';

  const SelectCategoryScreen({Key? key}) : super(key: key);

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  SightCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Категория',
          style: Theme.of(context)
              .primaryTextTheme
              .subtitle1!
              .copyWith(fontSize: 18),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedCategory = SightCategory.values[index];
                  });
                },
                child: ListTile(
                  title: Text(SightCategory.values[index].toText()),
                  trailing: selectedCategory == SightCategory.values[index]
                      ? SvgPicture.asset(
                          iconTick,
                          color: Colors.green,
                        )
                      : const SizedBox.shrink(),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 0.5,
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                  thickness: 0.5,
                ),
              );
            },
            itemCount: SightCategory.values.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: selectedCategory != null
                ? () {
                    Navigator.pop<SightCategory>(context, selectedCategory);
                  }
                : null,
            child: Text(
              'Сохранить'.toUpperCase(),
              style: textButtonElevation,
            ),
          ),
        ),
      ]),
    );
  }
}

enum SightCategory {
  hotel,
  restaurant,
  specialPlace,
  park,
  museum,
  cafe,
}

extension SightCategoryExt on SightCategory {
  String toText() {
    switch (this) {
      case SightCategory.hotel:
        return 'Отель';

      case SightCategory.restaurant:
        return 'Ресторан';
      case SightCategory.specialPlace:
        return 'Особое место';
      case SightCategory.park:
        return 'Парк';
      case SightCategory.museum:
        return 'Музей';
      case SightCategory.cafe:
        return 'Кафе';
      default:
        return '';
    }
  }
}
