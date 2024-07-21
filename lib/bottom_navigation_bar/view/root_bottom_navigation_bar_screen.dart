import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wac_task/home/view_model/home_view_model.dart';

import 'package:wac_task/core/utils/app_constants.dart';
import 'package:wac_task/bottom_navigation_bar/viewmodel/bottom_navigation_bar_view_model.dart/bottom_navigation_bar_view_model.dart';

///
class RootBottomNavigationBarScreen extends StatefulWidget {
  const RootBottomNavigationBarScreen({super.key});

  @override
  State<RootBottomNavigationBarScreen> createState() =>
      _RootBottomNavigationBarScreenState();
}

class _RootBottomNavigationBarScreenState
    extends State<RootBottomNavigationBarScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).getHomeData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationViewModel(),
      child: Scaffold(
        body: Consumer<BottomNavigationViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.widgets[viewModel.selectedIndex];
          },
        ),
        bottomNavigationBar: Consumer<BottomNavigationViewModel>(
          builder: (context, viewModel, child) {
            return Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              color: AppConstants.tabBarColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabItem(
                    context,
                    viewModel,
                    0,
                    "assets/home-filled-svgrepo-com.svg",
                    "Home",
                  ),
                  _buildTabItem(
                    context,
                    viewModel,
                    1,
                    "assets/categories.svg",
                    "Category",
                  ),
                  _buildTabItem(
                    context,
                    viewModel,
                    2,
                    "assets/cart.svg",
                    "Cart",
                  ),
                  _buildTabItem(
                    context,
                    viewModel,
                    3,
                    "assets/offers.svg",
                    "Offers",
                  ),
                  _buildTabItem(
                    context,
                    viewModel,
                    4,
                    "assets/account.svg",
                    "Account",
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabItem(
      BuildContext context,
      BottomNavigationViewModel viewModel,
      int index,
      String iconPath,
      String label) {
    // bool isSelected = viewModel.selectedIndex == index;
    return GestureDetector(
      onTap: () {
        viewModel.onItemTapped(index);
      },
      child: RootBottomNavigationBarIcon(
        image: iconPath,
        pageName: label,
      ),
    );
  }
}

class RootBottomNavigationBarIcon extends StatelessWidget {
  const RootBottomNavigationBarIcon({
    super.key,
    this.image,
    this.color,
    required this.pageName,
  });

  final String? image;
  final String pageName;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          image ?? "",
          width: 15,
          height: 15,
          colorFilter: ColorFilter.mode(
              color ?? AppConstants.tabBarNotSelectedIconColor,
              BlendMode.srcIn),
          fit: BoxFit.contain,
        ),
        3.heightBox,
        Text(pageName, style: context.textTheme.headlineMedium)
      ],
    );
  }
}
