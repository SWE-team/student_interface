import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_interface/screens/BottomNavBar.dart';
import 'package:student_interface/screens/Courses.dart';
import 'package:student_interface/screens/EnrolledCourses.dart';
import 'package:student_interface/screens/settings.dart';

class StudentHomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: Text('Are you sure you want to quit?'),
                  actions: <Widget>[
                    RaisedButton(
                        child: Text('exit'),
                        onPressed: () => SystemNavigator.pop()),
                    RaisedButton(
                        child: Text('cancel'),
                        onPressed: () => Navigator.of(context).pop(false)),
                  ])),
      child: Scaffold(
          backgroundColor: Colors.lightBlue[50],
          // appBar: AppBar(
          //   backgroundColor: Colors.blueAccent,
          //   automaticallyImplyLeading: false,
          //   title: Text('AMS'),
          // ),
          body: PageView(
              controller: _pageController,
              physics: new NeverScrollableScrollPhysics(),
              children: <Widget>[EnrolledCourses(), Courses(), settings()],
              onPageChanged: (int index) {
                setState(() {
                  //_pageController.jumpToPage(index);
                });
              }),
          bottomNavigationBar: CurvedNavigationBar(
            height: 55.0,
            color: Colors.blueAccent,
            backgroundColor: Colors.transparent,
            animationDuration: Duration(
              milliseconds: 150,
            ),

            //animationCurve: Curves.bounceInOut,
            items: <Widget>[
              Icon(Icons.home, size: 35),
              Icon(Icons.format_list_bulleted, size: 35),
              Icon(Icons.account_circle_outlined, size: 35),
            ],
            onTap: (index) {
              //Handle button tap
              setState(() {
                _pageController.jumpToPage(index);
              });
            },
          )),
    );
  }
}
