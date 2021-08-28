import 'package:flutter/material.dart';
import 'package:iit_360/providers/auth_provider.dart';
import 'package:iit_360/screens/screen_event_reminder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var _prefs;
  var classAlarmButtonState = false;

  initializeButtonState() async {
    _prefs = await SharedPreferences.getInstance();
    classAlarmButtonState = (_prefs.getBool('classAlarmButtonState') == null)
        ? true
        : _prefs.getBool('classAlarmButtonState');
  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await initializeButtonState();
    setState(() {
      // invoked to trigger change
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Consumer<AuthProvider>(
      builder: (ctx, authProvider, _) => ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: authProvider.crStatus
                ? Text(
                    '${authProvider.displayName.toString()} (CR-${authProvider.crSemester.toString()})',
                  )
                : Text(
                    authProvider.displayName.toString(),
                  ),
            accountEmail: Text(authProvider.email.toString()),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(authProvider.photoUrl.toString()),
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
          ),
          // if (authProvider.crStatus)
          //   ListTile(
          //     leading: Icon(Icons.add_comment_rounded),
          //     title: Text('Change Routine'),
          //   ),
          ListTile(
            leading: Icon(Icons.alarm),
            title: Text('Class Alarm'),
            trailing: Switch(
              value: classAlarmButtonState,
              onChanged: (val) async {
                print(val);
                setState(() {
                  classAlarmButtonState = val;
                });
                await _prefs.setBool('classAlarmButtonState', val);
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.event,),
            title: Text('Add Event Reminder'),
            onTap: () {
              Navigator.of(context).pushNamed(EventReminderScreen.routeName);
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.calendar_today),
          //   title: Text('Class Calendar'),
          // ),
          authProvider.authStatus
              ? ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Logout'),
                  onTap: authProvider.onLogout,
                )
              : ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Login'),
                ),
        ],
      ),
    ));
  }
}
