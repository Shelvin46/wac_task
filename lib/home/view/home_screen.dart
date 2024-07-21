import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wac_task/home/view/widgets/banner_slider_widget.dart';

import 'package:wac_task/home/view/widgets/list_of_category_widget.dart';
import 'package:wac_task/home/view/widgets/list_of_products_widget.dart';
import 'package:wac_task/home/view/widgets/search_bar.dart';
import 'package:wac_task/home/view/widgets/single_banner_widget.dart';
import 'package:wac_task/home/view/widgets/titile_info_widget.dart';
import 'package:wac_task/home/view_model/home_view_model.dart';

///[HomeScreen] is a StatefulWidget class that is used to display the home screen of the application.
/// [HomeScreen] extends [StatefulWidget] class.
/// [HomeScreen] contains the [HomeScreenState] class.
/// [HomeScreen] is a State class that is used to store the state of the [HomeScreen] class.
/// [HomeScreen] contains the build method that returns a widget.
/// [HomeScreen] contains the [Consumer] widget that is used to listen to the changes in the [HomeViewModel].
/// [HomeScreen] contains the [SearchBarWidget] widget that is used to display the search bar.
/// [HomeScreen] contains the [BannerSliderWidget] widget that is used to display the banner slider.
/// [HomeScreen] contains the [ListOfProductsWidget] widget that is used to display the list of products.
/// [HomeScreen] contains the [SingleBannerWidget] widget that is used to display the single banner.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, model, child) {
      // Check if the data is loading
      if (model.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      //Check the API failure
      else if (model.apiFailureHandler != null) {
        return Column(
          children: [
            Center(
              child: Text(model.apiFailureHandler!.message),
            ),
            ElevatedButton(
              onPressed: () {
                model.getHomeData();
              },
              child: const Text('Retry'),
            ),
          ],
        );
      }
      // Check if the data is empty or not
      else if (model.products.isNotEmpty) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchBarWidget(),
              if (model.products.isNotEmpty) ...[
                BannerSliderWidget(
                  images: model.products[0].contents,
                ),
              ],
              10.heightBox,
              const TitleInfoWidget(title: "Most Popular"),
              10.heightBox,
              ListOfProductsWidget(
                products: model.products[1],
              ),
              17.heightBox,
              SingleBannerWidget(
                productDetails: model.products[2],
              ),
              11.heightBox,
              const TitleInfoWidget(title: "Categories"),
              11.heightBox,
              ListOfCategoryWidget(
                productDetails: model.products[3],
              ),
              11.heightBox,
              const TitleInfoWidget(title: "Featured Products"),
              10.heightBox,
              ListOfProductsWidget(
                products: model.products[4],
              ),
              11.heightBox,
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
