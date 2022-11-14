import 'package:flutter/material.dart';
import 'package:movie_app/Const/CustomColor.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  const ShimmerWidget.curvedRectangular(
      {required this.height, required this.width, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CustomColor().Midgrey,
      highlightColor: CustomColor().Lightgrey,
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.height * height,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.height * radius))),
      ),
    );
  }
}
