import 'package:flutter/material.dart';
import 'package:movie_app/Const/CustomColor.dart';

class Cast_detail_Shimmer extends StatefulWidget {
  const Cast_detail_Shimmer({Key? key}) : super(key: key);

  @override
  _Cast_detail_ShimmerState createState() => _Cast_detail_ShimmerState();
}

class _Cast_detail_ShimmerState extends State<Cast_detail_Shimmer> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: h,
      width: w,
      child: Stack(
        children: [
          Container(
            width: w,
            height: h,
            color: CustomColor().Darkgrey,
          ),
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              width: w,
              height: h * 0.35,
              color: CustomColor().Darkred,
            ),
          ),
          Positioned(
            left: w * 0.245,
            top: h * 0.08,
            child: CircleAvatar(
              backgroundColor: CustomColor().Lightgrey,
              radius: h * 0.14,
              child: CircleAvatar(
                backgroundColor: CustomColor().Lightgrey,
                radius: h * 0.132,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height);

    var firstControlPoint = new Offset(size.width * 0.025, size.height * 0.85);
    var firstEndPoint = new Offset(size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = new Offset(size.width * 0.975, size.height * 0.85);
    var secondEndPoint = new Offset(size.width, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width * 0.5, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
