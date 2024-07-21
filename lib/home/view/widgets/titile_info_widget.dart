import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class TitleInfoWidget extends StatelessWidget {
  const TitleInfoWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const Spacer(),
        Text(
          "View All",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}
