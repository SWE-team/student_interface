import 'package:student_interface/Models/FutureResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HandleNetworking
{
  Future<FutureResponse> registerStudent(String studentEmail,String studentName,String studentPassword,int year) async {

    final http.Response response = await http.post(
      "https://signin-rest-api.herokuapp.com/student/register",

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': studentEmail,
        'yearOfStudying' : year,
        'password': studentPassword,
        'name': studentName,
      })

    );
      print(response.body);
      if(response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 500)
        return FutureResponse.fromJson(jsonDecode(response.body));
      else
        return null;


  }

  Future<FutureResponse> loginStudent(String studentEmail,String studentPassword) async {

    final http.Response response = await http.post(
        "https://signin-rest-api.herokuapp.com/student/login",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': studentEmail,
          'password': studentPassword,
        })

    );
    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 500)
      return FutureResponse.fromJson(jsonDecode(response.body));
    else
      return null;



  }
}