import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wac_task/core/utils/app_constants.dart';
import 'package:wac_task/core/utils/extensions.dart';
import 'package:wac_task/home/model/home_model_class.dart';

class ListOfCategoryWidget extends StatelessWidget {
  const ListOfCategoryWidget({
    super.key,
    required this.productDetails,
  });

  final ProductDetails productDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < productDetails.contents.length; i++)
          CategoryWidget(
            index: i,
            content: productDetails.contents,
          ),
      ],
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.index,
    required this.content,
  });
  final int index;
  final List<Content> content;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.screenHeight * 0.100,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppConstants.darkGrayColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          12.heightBox,
          CachedNetworkImage(
            height: context.screenHeight * 0.060,
            imageUrl: content[index].imageUrl ?? "",
            fit: BoxFit.fitHeight,
          ),
          4.heightBox,
          Text(
            "${content[index].title}",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    ).flexible();
  }
}
