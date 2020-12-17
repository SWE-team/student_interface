import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_interface/AvailableCourses.dart';
import 'package:student_interface/EnrolledList.dart';
import 'package:student_interface/Models/FutureResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HandleNetworking {
  final String url2 = "https://ams-swe.herokuapp.com";

  Future<FutureResponse> registerStudent(String studentEmail,
      String studentName, String studentPassword, int year) async {
    final http.Response response = await http.post(
        "https://signin-rest-api.herokuapp.com/student/register",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': studentEmail,
          'yearOfStudying': year,
          'password': studentPassword,
          'name': studentName,
        }));
    print(response.body);
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 500)
      return FutureResponse.fromJson(jsonDecode(response.body));
    else
      return null;
  }

  Future<FutureResponse> loginStudent(
      String studentEmail, String studentPassword) async {
    final http.Response response =
        await http.post("https://signin-rest-api.herokuapp.com/student/login",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'email': studentEmail,
              'password': studentPassword,
            }));
    print(response.body);
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 500)
      return FutureResponse.fromJson(jsonDecode(response.body));
    else
      return null;
  }

  Future<FutureResponse> resetPassword(
      String studentEmail, String newPassword) async {
    final http.Response response = await http.post(
        "https://signin-rest-api.herokuapp.com/student/resetPassword",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': studentEmail,
          'password': newPassword,
        }));
    print(response.body);
    if (response.statusCode == 200 ||
        response.statusCode == 400 ||
        response.statusCode == 500)
      return FutureResponse.fromJson(jsonDecode(response.body));
    else
      return null;
  }

  Future<List<AvailableCourses>> getAvailableCourses() async {
    final http.Response response = await http.get(url2 + "/api/student/all");

    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);
      int length = jsonRes.length;
      //print(length);

      List<AvailableCourses> availableCoursesList = [];
      int i = 0;
      while (i < length) {
        var courses = jsonRes[i];
        availableCoursesList.add(AvailableCourses(
            courses['_id'],
            courses['name'],
            courses['admin_id'],
            courses['sessioncount'],
            courses['session'],
            courses['allowEnroll'],
            courses['course_id']));

        //print(availableCoursesList[i].courseName);
        i++;
      }
      print(availableCoursesList[0].courseId);
      return availableCoursesList;
    } else {
      throw Exception('Failed to get available courses');
    }
  }

  Future<List<EnrolledList>> getEnrolledCourses(String id) async {
    final http.Response response =
        await http.get(url2 + "/api/student/home/" + id);

    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);
      int length = jsonRes['Id'].length;

      List<EnrolledList> enrolled = [];
      int i = 0;

      while (i < length) {
        var attendance = jsonRes['attendance'][i];
        if (attendance == null) {
          attendance = 0;
        }
        enrolled.add(EnrolledList(
            jsonRes['Id'][i], jsonRes['names'][i], attendance.toDouble()));
        i++;
      }
      print(jsonRes['attendance'][0].toDouble());
      return enrolled;
    } else {
      throw Exception('Failed to get available courses');
    }
  }

  Future<String> enroll(String cid, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sid = prefs.getString("id");

    final http.Response response =
        await http.post(url2 + "/api/student/enroll/$sid/$cid/$code");

    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);

      if (jsonRes['success'] == true) {
        return "true";
      } else {
        return jsonRes['message'];
      }
    } else {
      throw Exception('Failed to get available courses');
    }
  }

  Future<String> attend(String cid, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sid = prefs.getString("id");

    final http.Response response =
        await http.post(url2 + "/api/student/attend/$sid/$cid/$code");

    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);
      //print(jsonRes);

      if (jsonRes['success'] == true) {
        return "true";
      } else {
        return jsonRes['message'];
      }
    } else {
      throw Exception('Failed to get available courses');
    }
  }
}
