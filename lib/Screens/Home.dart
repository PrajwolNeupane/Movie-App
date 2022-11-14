import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Const/CustomColor.dart';
import 'package:movie_app/Const/CustomFont.dart';
import 'package:movie_app/Const/ShimmerWidget.dart';
import 'package:movie_app/Services/Movies_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> type = ["Up Coming", "Popular", "Now Playing", "Top Rated"];
  int _selectedindex = 1;
  String _selectedtype = "Popular";
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
        child: ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(left: w * 0.05),
          child: Text(
            "Suggested for you",
            style: CustomFont(CustomColor().Lightgrey, w * 0.06).semi(),
          ),
        ),
        SizedBox(height: h * 0.012),
        middlePart(),
        bottomPart(convert(_selectedtype)),
      ],
    ));
  }

  String convert(String value) {
    if (value == "Up Coming") {
      return value.toLowerCase().replaceAll(" ", "");
    } else if (value == "Popular") {
      return value.toLowerCase().replaceAll(" ", "");
    } else {
      return value.toLowerCase().replaceAll(" ", "_");
    }
  }

  Widget bottomPart(String type) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: getMovieListData(type),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return ListView.separated(
                padding: EdgeInsets.only(
                    left: w * 0.05, right: w * 0.05, top: h * 0.02),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) => shimmer(),
                separatorBuilder: (context, index) =>
                    SizedBox(height: h * 0.02),
                itemCount: 3);
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.length,
              padding: EdgeInsets.only(bottom: h * 0.02),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/detail", arguments: {
                      "title": snapshot.data[index].name,
                      "imgurl": snapshot.data[index].back_imgurl,
                      "date": snapshot.data[index].date,
                      "genre": snapshot.data[index].genre,
                      "vote": snapshot.data[index].vote,
                      "des": snapshot.data[index].des,
                      "id": snapshot.data[index].id,
                      "vote": snapshot.data[index].vote,
                    });
                  },
                  child: customTile(
                    snapshot.data[index].imgUrl,
                    snapshot.data[index].name,
                    snapshot.data[index].date,
                    snapshot.data[index].genre,
                    snapshot.data[index].vote,
                  ),
                );
              },
            );
          }
        });
  }

  Widget shimmer() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Row(
      children: [
        ShimmerWidget.curvedRectangular(
            height: 0.19, width: 0.27, radius: 0.019),
        Spacer(),
        Column(
          children: [
            ShimmerWidget.curvedRectangular(
                height: 0.05, width: 0.5, radius: 0.01),
            SizedBox(
              height: h * 0.02,
            ),
            ShimmerWidget.curvedRectangular(
                height: 0.12, width: 0.5, radius: 0.012),
          ],
        ),
      ],
    );
  }

  Widget customTile(
    String imgUrl,
    String name,
    String date,
    String genre,
    int vote,
  ) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Container(
            margin: EdgeInsets.only(top: h * 0.02),
            width: w * 0.27,
            height: h * 0.19,
            decoration: BoxDecoration(
                color: CustomColor().Black,
                borderRadius: BorderRadius.circular(h * 0.019)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(h * 0.019),
              child: Image.network(
                "https://image.tmdb.org/t/p/original" + imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: w * 0.6,
              child: AutoSizeText(
                name,
                style: TextStyle(
                    fontSize: w * 0.06,
                    fontFamily: "S",
                    height: w * 0.003,
                    color: CustomColor().Lightgrey),
                maxLines: 2,
              ),
            ),
            Text(
              date,
              style: CustomFont(CustomColor().Midgrey, w * 0.04).regular(),
            ),
            star(vote),
            SizedBox(height: h * 0.005),
            Container(
              width: w * 0.6,
              child: AutoSizeText(
                genre,
                style: TextStyle(
                    fontSize: w * 0.04,
                    fontFamily: "R",
                    height: w * 0.003,
                    color: CustomColor().Midgrey),
                maxLines: 2,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget star(int vote) {
    if (vote == 0) {
      return Row(
        children: [
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey)
        ],
      );
    } else if (vote == 1) {
      return Row(
        children: [
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey)
        ],
      );
    } else if (vote == 2) {
      return Row(
        children: [
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey)
        ],
      );
    } else if (vote == 3) {
      return Row(
        children: [
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Darkgrey),
          Icon(Icons.star, color: CustomColor().Darkgrey)
        ],
      );
    } else if (vote == 4) {
      return Row(
        children: [
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Darkgrey)
        ],
      );
    } else {
      return Row(
        children: [
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow),
          Icon(Icons.star, color: CustomColor().Yellow)
        ],
      );
    }
  }

  Widget middlePart() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: h * 0.05,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: type.length,
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(() {
                  _selectedindex = index;
                  _selectedtype = type[index];
                });
              },
              child: custombox(index, _selectedindex))),
    );
  }

  Widget custombox(int index, int _selectedindex) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    if (index == 0) {
      return Container(
        margin: EdgeInsets.only(left: w * 0.05),
        width: w * 0.4,
        decoration: BoxDecoration(
            color: index == _selectedindex
                ? CustomColor().Red
                : CustomColor().Darkgrey,
            borderRadius: BorderRadius.all(Radius.circular(h * 0.013))),
        child: Center(
          child: Text(
            type[index],
            style: CustomFont(
                    index == _selectedindex
                        ? CustomColor().Lightgrey
                        : CustomColor().Midgrey,
                    w * 0.045)
                .medium(),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: w * 0.03),
        width: w * 0.4,
        decoration: BoxDecoration(
            color: index == _selectedindex
                ? CustomColor().Red
                : CustomColor().Darkgrey,
            borderRadius: BorderRadius.all(Radius.circular(h * 0.013))),
        child: Center(
          child: Text(
            type[index],
            style: CustomFont(
                    index == _selectedindex
                        ? CustomColor().Lightgrey
                        : CustomColor().Midgrey,
                    w * 0.045)
                .medium(),
          ),
        ),
      );
    }
  }
}
