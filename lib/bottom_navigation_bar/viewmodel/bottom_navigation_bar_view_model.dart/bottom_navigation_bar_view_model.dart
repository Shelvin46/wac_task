import 'package:flutter/material.dart';
import 'package:wac_task/account/account_screen.dart';
import 'package:wac_task/cart/cart_screen.dart';
import 'package:wac_task/category/category_scree.dart';
import 'package:wac_task/home/view/home_screen.dart';
import 'package:wac_task/offers/offers_screen.dart';

class BottomNavigationViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  List<Widget> widgets = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const OffersScreen(),
    const AccountScreen(),
  ];

  void onItemTapped(int index) {
    _selectedIndex = widgets.indexOf(widgets[index]);
    notifyListeners();
  }

  List<Widget> get screens => widgets;

  int get selectedIndex => _selectedIndex;
}
