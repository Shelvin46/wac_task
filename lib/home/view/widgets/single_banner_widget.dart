import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wac_task/core/utils/extensions.dart';
import 'package:wac_task/home/model/home_model_class.dart';

class SingleBannerWidget extends StatelessWidget {
  const SingleBannerWidget({
    super.key,
    required this.productDetails,
  });

  final ProductDetails productDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * 0.150,
      margin: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: CachedNetworkImageProvider(productDetails.imageUrl ?? ""),
            fit: BoxFit.fill),
      ),
    );
  }
}
