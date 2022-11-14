import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/Const/CustomColor.dart';
import 'package:movie_app/Const/CustomFont.dart';
import 'package:movie_app/Screens/Home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: CustomColor().Black,
        appBar: AppBar(
          title: Text(
            "My Movies",
            style: CustomFont(CustomColor().Lightgrey, w * 0.06).semi(),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: CustomColor().Black,
        ),
        bottomNavigationBar: bottom(),
        body: _widgetOptions.elementAt(_selectedIndex));
  }

  Widget bottom() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      margin:
          EdgeInsets.only(bottom: h * 0.014, left: w * 0.05, right: w * 0.05),
      height: h * 0.08,
      decoration: BoxDecoration(
          color: CustomColor().Red,
          borderRadius: BorderRadius.all(
            Radius.circular(h * 0.02),
          )),
      child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: w * .02),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  HapticFeedback.lightImpact();
                });
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == _selectedIndex ? w * .4 : w * .18,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == _selectedIndex ? w * .12 : w * .32,
                      decoration: BoxDecoration(
                        color: index == _selectedIndex
                            ? CustomColor().Darkred
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == _selectedIndex ? w * .31 : w * .18,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == _selectedIndex ? w * .13 : 0,
                            ),
                            AnimatedOpacity(
                              opacity: index == _selectedIndex ? 1 : 0,
                              duration: Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: Text(
                                index == _selectedIndex
                                    ? "${listOfStrings[index]}"
                                    : "",
                                style: CustomFont(
                                        CustomColor().Lightgrey, w * 0.05)
                                    .medium(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == _selectedIndex ? w * .03 : 20,
                            ),
                            Icon(
                              listOfIcons[index],
                              size: w * .076,
                              color: index == _selectedIndex
                                  ? CustomColor().Lightgrey
                                  : CustomColor().Lightgrey,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_outlined,
    Icons.favorite_outline,
    Icons.people_outline
  ];
  List<String> listOfStrings = [
    'Home',
    'Like',
    'Profile',
  ];
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Center(
      child: Text(
        'Discover',
      ),
    ),
    Center(
      child: Text(
        'Camera',
      ),
    ),
  ];
}
