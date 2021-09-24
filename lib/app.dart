import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/redux/app_state.dart';
import 'package:places/ui/screen/add_sight/add_sight_screen/add_sight_screen_wm.dart';
import 'package:places/ui/screen/add_sight/select_category_screen.dart';
import 'package:places/ui/screen/filter_screen/filters_screen.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/ui/screen/sight_search_screen/sight_search_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

import 'data/interactor/place_interactor.dart';
import 'data/interactor/search_interactor.dart';
import 'data/interactor/setting_interactor.dart';
import 'data/repository/place_repository.dart';
import 'res/themes.dart';
import 'service/api_client.dart';
import 'ui/screen/add_sight/add_sight_screen/add_sight_screen.dart';

class App extends StatefulWidget {
  final Store<AppState> store;

  const App(this.store, {Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

ChangeNotifier themeNotifier = ChangeNotifier();
SettingInteractor settingInteractor = SettingInteractor();

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    themeNotifier.addListener(() {
      setState(() {
        settingInteractor.changeTheme();
      });
    });

    return StoreProvider<AppState>(
      store: widget.store,
      child: MultiProvider(
        providers: [
          Provider<SettingInteractor>(create: (_) => settingInteractor),
          Provider<SearchInteractor>(create: (_) => SearchInteractor()),
          Provider<PlaceInteractor>(create: (_) => PlaceInteractor()),
          Provider<PlaceRepository>(
              create: (_) => PlaceRepository(ApiClient().createDio()),),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: settingInteractor.isDarkMode ? darkTheme : lightTheme,
          routes: {
            '/': (context) => const SplashScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            FiltersScreen.routeName: (context) => const FiltersScreen(),
            AddSightScreen.routeName: (context) => const AddSightScreen(
                  widgetModelBuilder: createAddSightScreenWM,
                ),
            SelectCategoryScreen.routeName: (context) =>
                const SelectCategoryScreen(),
            SightSearchScreen.routeName: (context) => const SightSearchScreen(),
            OnboardingScreen.routeName: (context) => const OnboardingScreen(),
          },
          initialRoute: '/',
        ),
      ),
    );
  }
}
