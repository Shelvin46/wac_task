import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wac_task/home/view_model/home_view_model.dart';
import 'package:wac_task/core/utils/app_constants.dart';
import 'package:wac_task/bottom_navigation_bar/view/root_bottom_navigation_bar_screen.dart';
import 'package:wac_task/bottom_navigation_bar/viewmodel/bottom_navigation_bar_view_model.dart/bottom_navigation_bar_view_model.dart';
import 'package:wac_task/home/view_model/carousel_provider.dart';

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  TextTheme textTheme = TextTheme(
    headlineLarge: AppConstants.headingTextStyle,
    headlineMedium: AppConstants.subHeadingTextStyle,
    labelLarge: AppConstants.labelTextStyle,
    labelMedium: AppConstants.labelMediumTextStyle,
  );

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CarouselProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WAC Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: textTheme,
        ),
        home: const RootBottomNavigationBarScreen(),
      ),
    );
  }
}
