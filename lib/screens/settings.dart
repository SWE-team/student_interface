import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                SettingsTile.switchTile(
                  title: 'Reset Password',
                  leading: Icon(Icons.fingerprint),
                  switchValue: false,
                  onToggle: (bool value) {},
                ),
                SettingsTile(
                  title: 'Logout',
                  leading: Icon(Icons.logout),
                  onPressed: (BuildContext context) {
                    saveValue("status", false);
                    //Navigator.pushReplacementNamed(context, '/');
                    Navigator.popAndPushNamed(context, '/');
                  },
                )
              ],
            ),
          ],
        ));
  }
}

saveValue(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("set $key as $value");
  prefs.setBool(key, value);
}
