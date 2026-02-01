import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loanfrontend/core/theme/app_color.dart';

class CustomLoading extends StatelessWidget {
  final Color color;
  final double size;

  const CustomLoading({
    Key? key,
    this.color = TheColors.errorColor, // Default color
    this.size = 32, // Default size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: TheColors.red,
        rightDotColor: TheColors.green,
        size: size,
      ),
    );
  }
}
