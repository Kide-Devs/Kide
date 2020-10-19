import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarLoading extends StatelessWidget {
  final double width;
  final double height;

  const AvatarLoading(this.width, this.height, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingIndicatorTopOffset = height * 0.3;
    final loadingIndicatorLeftOffset = width * 0.32;
    final loadingIndicatorHeight = height * 0.67;
    final loadingIndicatorWidth = width * 1.15;

    return Stack(
      children: [
        Positioned(
          top: loadingIndicatorTopOffset,
          left: loadingIndicatorLeftOffset,
          child: SizedBox(
            height: loadingIndicatorHeight,
            width: loadingIndicatorWidth,
            child: CircularProgressIndicator(),
          ),
        ),
        SvgPicture.asset(
          './lib/assets/blank_avatar.svg',
          height: height,
          width: width,
          alignment: Alignment.topLeft,
        ),
      ],
    );
  }
}
