import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wac_task/home/model/home_model_class.dart';
import 'package:wac_task/core/utils/extensions.dart';
import 'package:wac_task/home/view_model/carousel_provider.dart';

///[BannerSliderWidget] is a widget that displays a list of images in a carousel slider.
class BannerSliderWidget extends StatelessWidget {
  const BannerSliderWidget({
    super.key,
    required this.images,
  });

  final List<Content> images;

  @override
  Widget build(BuildContext context) {
    return Consumer<CarouselProvider>(
      builder: (context, carouselProvider, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: context.screenHeight * 0.150,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  carouselProvider.setCurrentIndex(index);
                },
              ),
              items: images
                  .map(
                    (item) => ClipRRect(
                      borderRadius: BorderRadius.zero,
                      child: CachedNetworkImage(
                        imageUrl: item.imageUrl ?? "",
                        fit: BoxFit.fill,
                        width: context.screenWidth,
                      ),
                    ),
                  )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => carouselProvider.setCurrentIndex(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: carouselProvider.currentIndex == entry.key
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ).paddingOnly(bottom: 10),
          ],
        );
      },
    );
  }
}
