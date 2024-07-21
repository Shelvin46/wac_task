import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wac_task/core/utils/app_constants.dart';

/// [SearchBar] is a widget that displays a search bar with a shopping cart icon and a notification icon.

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10),
      color: AppConstants.greenColor,
      child: SafeArea(
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/shopping-cart-14-svgrepo-com.svg',
              height: 26,
              width: 26,
            ),
            22.widthBox,
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                enabled: true,
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: AppConstants.whiteColor,
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppConstants.lightGrayColor,
                ),
                constraints: const BoxConstraints(
                  maxHeight: 35, // Adjust the max height as needed
                ),
              ),
            ).expanded(),
            38.widthBox,
            const Icon(
              Icons.notifications_none,
              color: AppConstants.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
