import 'package:flutter/material.dart';



class EnrolledCourses extends StatefulWidget {
  @override
  _EnrolledCoursesState createState() => _EnrolledCoursesState();
}

class _EnrolledCoursesState extends State<EnrolledCourses> {
  @override
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
                        color: Colors.amber,
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