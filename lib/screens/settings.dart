import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_interface/HandleNetworking.dart';
import 'package:student_interface/screens/LoginScreen.dart';
import 'package:student_interface/screens/changePasswordScreen.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue[50],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SettingsSection(
              title: 'Account',
              titleTextStyle: TextStyle(fontSize: 18),
              tiles: [
                SettingsTile(
                  title: 'Email',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile(
                  title: 'Reset Password',
                  leading: Icon(Icons.fingerprint),
                  onPressed: (BuildContext context) {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen()),
                        );
                  },

                ),
                SettingsTile(
                  title: 'Logout',
                  leading: Icon(Icons.logout),
                  onPressed: (BuildContext context) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: Text('Are you sure you want to quit?'),
                                actions: <Widget>[
                                  RaisedButton(
                                      child: Text('exit'),
                                      onPressed: () => Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/',
                                              (Route<dynamic> route) => false)),
                                  RaisedButton(
                                      child: Text('cancel'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false)),
                                ]));
                  },
                )
              ],
            ),
          ],
        ));
  }
}

