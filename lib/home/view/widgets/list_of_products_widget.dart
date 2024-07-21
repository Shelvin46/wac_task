import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wac_task/core/utils/app_constants.dart';
import 'package:wac_task/core/utils/extensions.dart';
import 'package:wac_task/home/model/home_model_class.dart';

class ListOfProductsWidget extends StatelessWidget {
  const ListOfProductsWidget({
    super.key,
    required this.products,
  });
  final ProductDetails products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductWidget(
            index: index,
            productDetails: products,
          ).paddingOnly(right: 8);
        },
        itemCount: 5,
        itemExtent: context.screenWidth * 0.3,
      ).paddingOnly(left: 16, right: 8),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.index,
    required this.productDetails,
  });
  final int index;
  final ProductDetails productDetails;

  @override
  Widget build(BuildContext context) {
    final product = productDetails.contents[index];

    // Remove all non-numeric characters from the price strings
    final actualPriceString =
        product.actualPrice?.replaceAll(RegExp(r'[^\d]'), '') ?? "0";
    final offerPriceString =
        product.offerPrice?.replaceAll(RegExp(r'[^\d]'), '') ?? "0";

    // Parse the cleaned strings to integers
    final actualPrice = int.parse(actualPriceString);
    final offerPrice = int.parse(offerPriceString);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppConstants.darkGrayColor),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  product.productImage ?? "",
                ),
                alignment: Alignment.bottomCenter,
                fit: BoxFit.fill,
              ),
            ),
          ).expanded(flex: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.heightBox,
              if (offerPrice > 0)
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppConstants.orangeColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Sale ${product.discount}",
                    style: context.textTheme.labelMedium,
                  ),
                ),
              7.heightBox,
              Text(
                maxLines: 2,
                product.productName ?? "",
                style: context.textTheme.labelMedium,
              ),
              5.heightBox,
              if (product.productRating != null)
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Icon(
                        Icons.star,
                        color: i < product.productRating!
                            ? AppConstants.lightYellowColor
                            : AppConstants.darkGrayColor,
                        size: 10,
                      )
                  ],
                ),
              5.heightBox,
              Row(
                children: [
                  if (actualPrice != offerPrice)
                    Text(
                      "₹$offerPrice",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  if (product.actualPrice != product.offerPrice) 8.widthBox,
                  Text(
                    "₹$actualPrice",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          decoration: product.actualPrice != product.offerPrice
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                  ),
                ],
              ),
              5.heightBox,
            ],
          ).paddingOnly(left: 8)
        ],
      ),
    );
  }
}
