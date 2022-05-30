import 'package:flutter/material.dart';
import 'package:great_places/providers/change_theme.dart';
import 'package:great_places/pages/place_form_page.dart';
import 'package:great_places/pages/places_list_page.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChangeTheme(),
        ),
        ChangeNotifierProvider(
          create: (_) => GreatPlaces(),
        ),
      ],
      child: Consumer<ChangeTheme>(builder: (ctx, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: provider.themeData.copyWith(
            colorScheme: provider.themeData.colorScheme.copyWith(
              primary: Colors.indigo,
              secondary: Colors.amber,
            ),
          ),
          routes: {
            AppRoutes.HOME: (context) => const PlacesListPage(),
            AppRoutes.PLACE_FORM: (context) => const PlaceFormPage(),
          },
        );
      }),
    );
  }
}
