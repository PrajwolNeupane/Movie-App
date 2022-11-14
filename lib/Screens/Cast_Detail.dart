import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Const/CustomColor.dart';
import 'package:movie_app/Const/CustomFont.dart';
import 'package:movie_app/Const/ShimmerWidget.dart';
import 'package:movie_app/Services/cast_detail.dart';
import 'package:movie_app/ShimmerScreens/cast_detail_shimmer.dart';

class Cast_Detail extends StatefulWidget {
  const Cast_Detail({Key? key}) : super(key: key);

  @override
  _Cast_DetailState createState() => _Cast_DetailState();
}

class _Cast_DetailState extends State<Cast_Detail> {
  String base = "https://image.tmdb.org/t/p/original";
  var Data;

  @override
  Widget build(BuildContext context) {
    Data = ModalRoute.of(context)!.settings.arguments as Map;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cast Profile",
          style: CustomFont(CustomColor().Lightgrey, w * 0.06).semi(),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: CustomColor().Darkred,
      ),
      body: FutureBuilder(
        future: getCast_Detail(Data["castId"]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Cast_detail_Shimmer();
          } else {
            return body(
                snapshot.data[0].name,
                snapshot.data[0].popularity,
                base + snapshot.data[0].imgUrl,
                snapshot.data[0].gender,
                snapshot.data[0].job);
          }
        },
      ),
    );
  }

  Widget body(String name, double popularity, String imgUrl, String gender,
      String job) {
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
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  Center(
                      child: Container(
                    margin: EdgeInsets.only(top: h * 0.4),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontFamily: "B",
                          fontSize: w * 0.06,
                          color: CustomColor().Lightgrey,
                          height: w * 0.0003),
                    ),
                  )),
                  Center(
                    child: Text(
                      job,
                      style:
                          CustomFont(CustomColor().Midgrey, w * 0.045).medium(),
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Gender",
                              style:
                                  CustomFont(CustomColor().Lightgrey, w * 0.05)
                                      .semi(),
                            ),
                            Text(gender,
                                style: TextStyle(
                                    fontFamily: "M",
                                    fontSize: w * 0.045,
                                    height: w * 0.002,
                                    color: CustomColor().Midgrey))
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Popularity",
                              style:
                                  CustomFont(CustomColor().Lightgrey, w * 0.05)
                                      .semi(),
                            ),
                            Text("$popularity",
                                style: TextStyle(
                                    fontFamily: "M",
                                    fontSize: w * 0.045,
                                    height: w * 0.0025,
                                    color: CustomColor().Midgrey))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                    child: Text(
                      "Movies Played",
                      style:
                          CustomFont(CustomColor().Lightgrey, w * 0.06).semi(),
                    ),
                  ),
                  Container(
                      width: w,
                      height: h * 0.28,
                      child: FutureBuilder(
                        future: getCast_Detail(Data["castId"]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return shimmerTile(index);
                                });
                          } else {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data[0].movies_title.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context, {
                                        "imgurl": snapshot
                                            .data[0].moviesback_imgurl[index],
                                        "title": snapshot
                                            .data[0].movies_title[index],
                                        "date": snapshot
                                            .data[0].release_date[index],
                                        "vote": snapshot.data[0].vote[index],
                                        "genre": snapshot.data[0].genre[index],
                                        "des": snapshot.data[0].des[index],
                                        "id": snapshot.data[0].movie_id[index],
                                      });
                                    },
                                    child: customTile(
                                        index,
                                        snapshot.data[0].movies_title[index],
                                        base +
                                            snapshot
                                                .data[0].movies_imgurl[index]),
                                  );
                                });
                          }
                        },
                      )),
                ],
              )),
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
                backgroundColor: CustomColor().Red,
                radius: h * 0.132,
                backgroundImage: NetworkImage(imgUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customTile(int index, String title, String movie_imgUrl) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: index == 0
              ? EdgeInsets.only(left: w * 0.1)
              : EdgeInsets.only(left: w * 0.05),
          height: h * 0.2,
          width: w * 0.3,
          decoration: BoxDecoration(
              color: CustomColor().Darkgrey,
              borderRadius: BorderRadius.circular(h * 0.018)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(h * 0.018),
              child: Image.network(
                movie_imgUrl,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(height: h * 0.01),
        Container(
          margin: index == 0
              ? EdgeInsets.only(left: w * 0.1)
              : EdgeInsets.only(left: w * 0.05),
          width: w * 0.3,
          child: AutoSizeText(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.04,
                fontFamily: "S",
                height: w * 0.0025,
                color: CustomColor().Lightgrey),
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget shimmerTile(index) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: index == 0
              ? EdgeInsets.only(left: w * 0.1)
              : EdgeInsets.only(left: w * 0.05),
          child: ShimmerWidget.curvedRectangular(
              height: h * 0.2, width: w * 0.3, radius: h * 0.018),
        ),
        SizedBox(height: h * 0.01),
        Container(
          margin: index == 0
              ? EdgeInsets.only(left: w * 0.1)
              : EdgeInsets.only(left: w * 0.05),
          child: ShimmerWidget.curvedRectangular(
              height: h * 0.05, width: w * 0.3, radius: h * 0.005),
        ),
      ],
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
