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
              padding: const EdgeInsets.only(top: 0, bottom: 10),
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
    bool isSelected = viewModel.selectedIndex == index;
    return GestureDetector(
      onTap: () {
        viewModel.onItemTapped(index);
      },
      child: RootBottomNavigationBarIcon(
        image: iconPath,
        pageName: label,
        color: isSelected
            ? AppConstants.whiteColor
            : AppConstants.tabBarNotSelectedIconColor,
        isSelected: isSelected,
      ),
    ).flexible();
  }
}

class RootBottomNavigationBarIcon extends StatelessWidget {
  const RootBottomNavigationBarIcon({
    super.key,
    this.image,
    this.color,
    this.isSelected = false,
    required this.pageName,
  });

  final String? image;
  final String pageName;
  final Color? color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: Offset(0, isSelected ? -20 : 0),
          child: AnimatedScale(
            alignment: Alignment.topCenter,
            scale: isSelected ? 1.4 : 1,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              padding: isSelected
                  ? const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 2)
                  : const EdgeInsets.all(0),
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppConstants.tabBarColor,
              ),
              child: CircleAvatar(
                backgroundColor:
                    isSelected ? AppConstants.greenColor : Colors.transparent,
                radius: 15,
                child: SvgPicture.asset(
                  image ?? "",
                  width: 15,
                  height: 15,
                  colorFilter: ColorFilter.mode(
                    color ?? AppConstants.tabBarNotSelectedIconColor,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Text(pageName, style: context.textTheme.headlineMedium)
      ],
    );
  }
}
