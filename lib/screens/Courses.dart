import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {

  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue[50],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: ListView.builder(
              itemCount: 5,
              padding: const EdgeInsets.all(8),
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.deepPurple,
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Container(
                          padding: EdgeInsets.all(50),
                          height: 152,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ));
  }
}
