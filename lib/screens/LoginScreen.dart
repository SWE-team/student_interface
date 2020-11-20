import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:student_interface/HandleNetworking.dart';
import 'package:student_interface/Models/FutureResponse.dart';
import 'package:student_interface/components/ReusableButton.dart';
import 'package:student_interface/screens/StudentHomePage.dart';

class LoginScreen extends StatefulWidget {

  final String msg;
  LoginScreen({this.msg});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final HandleNetworking handleNetworking =  HandleNetworking();
  String email;
  String password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 100,),
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "images/logo.jpeg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  TextField(
                    onChanged: (String value){
                      email = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Email",
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),

                    ),
                  ),
                  SizedBox(height: 25.0),
                  TextField(
                    onChanged: (String value){
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Password",
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),

                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Builder(
                      builder: (BuildContext context){
                        return GestureDetector(
                          child: ReusableButton('Login'),
                          onTap: () async{

                            if(email == null || password == null)
                            {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Invalid input"),
                              ));

                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });

                            FutureResponse result = await handleNetworking.loginStudent(email, password);

                            setState(() {
                              isLoading = false;
                            });

                            if(result != null)
                            {
                              if(result.err)
                              {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(result.msg),
                                ));
                              }
                              else
                              {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(result.msg),
                                ));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => StudentHomePage()),
                                );
                              }
                            }
                            else
                            {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("something went wrong please try again later"),
                              ));
                            }

                          },
                        );
                      }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 18.0),
                    child: Text(
                      widget.msg,
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
