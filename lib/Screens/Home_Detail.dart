import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Const/CustomColor.dart';
import 'package:movie_app/Const/CustomFont.dart';
import 'package:movie_app/Const/ShimmerWidget.dart';
import 'package:movie_app/Services/cast.dart';

class Home_Detail extends StatefulWidget {
  const Home_Detail({Key? key}) : super(key: key);

  @override
  _Home_DetailState createState() => _Home_DetailState();
}

class _Home_DetailState extends State<Home_Detail> {
  var Data;
  @override
  Widget build(BuildContext context) {
    Data =
        Data != null ? Data : ModalRoute.of(context)!.settings.arguments as Map;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColor().Black,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            width: w,
            height: h * 0.45,
            child: Stack(
              children: [
                Container(
                  color: CustomColor().Black,
                  child: Image.network(
                    "https://image.tmdb.org/t/p/original" + Data["imgurl"],
                    fit: BoxFit.cover,
                  ),
                  width: w,
                  height: h * 0.45,
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.02, top: h * 0.01),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: CustomColor().Lightgrey,
                      size: w * 0.08,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: h * 0.005,
            width: w,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                  CustomColor().Black,
                  CustomColor().Red,
                  CustomColor().Black
                ])),
          ),
          Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
            child: Container(
              width: w,
              height: h * 0.5,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: w * 0.05),
                  Center(
                    child: AutoSizeText(
                      Data["title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: CustomColor().Lightgrey,
                          fontFamily: "S",
                          height: w * 0.0025,
                          fontSize: w * 0.08),
                      maxLines: 2,
                    ),
                  ),
                  Center(
                    child: Text(
                      Data["date"],
                      style:
                          CustomFont(CustomColor().Midgrey, w * 0.05).medium(),
                    ),
                  ),
                  star(Data["vote"]),
                  Center(
                    child: Text(
                      Data["genre"],
                      style: CustomFont(CustomColor().Lightgrey, w * 0.05)
                          .regular(),
                    ),
                  ),
                  Center(
                    child: AutoSizeText(
                      Data["des"],
                      style: CustomFont(CustomColor().Lightgrey, w * 0.05)
                          .regular(),
                      maxLines: 25,
                    ),
                  ),
                  Text(
                    "Cast",
                    style: CustomFont(CustomColor().Lightgrey, w * 0.05).semi(),
                  ),
                  Container(
                      width: w,
                      height: h * 0.32,
                      child: FutureBuilder(
                        future: getCastData(Data["id"]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return ListView.separated(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        ShimmerWidget.curvedRectangular(
                                            height: 0.2,
                                            width: 0.25,
                                            radius: 0.02),
                                        SizedBox(height: h * 0.01),
                                        ShimmerWidget.curvedRectangular(
                                            height: 0.05,
                                            width: 0.25,
                                            radius: 0.01),
                                      ],
                                    ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: w * 0.045),
                                itemCount: 3);
                          } else {
                            return ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                      width: w * 0.045,
                                    ),
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      dynamic result =
                                          await Navigator.pushNamed(
                                              context, "/cast_detail",
                                              arguments: {
                                            "castId":
                                                snapshot.data[index].castId,
                                          });
                                      setState(() {
                                        Data = result;
                                      });
                                    },
                                    child: cast_box(snapshot.data[index].name,
                                        snapshot.data[index].profile_url),
                                  );
                                });
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget star(int vote) {
    if (vote == 0) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey)
          ],
        ),
      );
    } else if (vote == 1) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey)
          ],
        ),
      );
    } else if (vote == 2) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey)
          ],
        ),
      );
    } else if (vote == 3) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Darkgrey),
            Icon(Icons.star, color: CustomColor().Darkgrey)
          ],
        ),
      );
    } else if (vote == 4) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Darkgrey)
          ],
        ),
      );
    } else {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow),
            Icon(Icons.star, color: CustomColor().Yellow)
          ],
        ),
      );
    }
  }

  Widget cast_box(String name, String profile_url) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: w * 0.25,
          height: h * 0.2,
          decoration: BoxDecoration(
              color: CustomColor().Black,
              borderRadius: BorderRadius.circular(h * 0.02)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(h * 0.02),
            child: Image.network(
              "https://image.tmdb.org/t/p/original" + profile_url,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: h * 0.01),
        Container(
          width: w * 0.25,
          child: AutoSizeText(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "M",
                color: CustomColor().Lightgrey,
                fontSize: w * 0.04,
                height: w * 0.003),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
