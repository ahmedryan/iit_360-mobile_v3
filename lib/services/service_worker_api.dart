import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:iit_360/providers/routine_provider.dart';
import 'package:iit_360/services/service_notification_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() async {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case 'CheckRoutineUpdate':
        var _prefs = await SharedPreferences.getInstance();
        var _flnp = NotificationServiceApi.initialize();

        // setting default choice of alarm wanted to true if not specified by user
        if (!_prefs.containsKey('classAlarmButtonState')) {
          _prefs.setBool('classAlarmButtonState', true);
        }

        var isClassAlarmWanted = _prefs.getBool('classAlarmButtonState')!;
        // if alarm not wanted, break
        if (_prefs.getBool('classAlarmButtonState') == false) {
          print('..........alarm not wanted..........');
          NotificationServiceApi.cancelAllNotifications();
          return Future.value(true);
        }

        final ioc = new HttpClient();
        ioc.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        final http = new IOClient(ioc);

        print('..........Called on date time.......... ${DateTime.now()}');

        NotificationServiceApi.showNotification(
            'Workmanager',
            'I am running in the background and firing after every 15 minutes',
            'payload',
            _flnp);

        var usermail = _prefs.getString('usermail') == null
            ? ''
            : _prefs.getString('usermail');

        print("..........usermail: " + usermail.toString());

        var response = await http.get(Uri.parse(
            'https://10.0.2.2:5001/api/routines/earliestclass/$usermail'));
        print('..........${response.body}..........');
        var responseData = json.decode(response.body) as List;
        var earliestClassData = [];
        responseData.forEach(
          (element) {
            earliestClassData.add(
              RoutineModel(
                routineId: element['routineId'],
                routineDate: DateTime.parse(element['date']),
                courseCode: element['courseCode'],
                beginTime: element['beginTime'],
                endTime: element['endTime'],
                semester: element['semester'],
                dayName: element['dayname'],
                instructorCode: element['fkInstructorId'],
              ),
            );
          },
        );
        var earliestClass = earliestClassData.length != 0
            ? earliestClassData.elementAt(0)
            : null;

        print('..........earliest class.......... $earliestClass');
        if (earliestClass != null) {
          // Condition 1: Check if begin time has already passed
          TimeOfDay _timeOfDay = TimeOfDay(
            hour: int.parse(earliestClass.beginTime!.split(':')[0]),
            minute: int.parse(earliestClass.beginTime!.split(':')[1]),
          );
          var _isClassTimeOver = (_timeOfDay.hour * 60 + _timeOfDay.minute) <
              (TimeOfDay.now().hour * 60 + TimeOfDay.now().minute);

          if (_isClassTimeOver) {
            var _flnp = NotificationServiceApi.initialize();
            // kept for demonstration purpose only
            NotificationServiceApi.showNotification(
                'Class Manager',
                'Class time is over, time to get some fresh air!',
                'payload',
                _flnp);
            _prefs.remove('courseCode');
            _prefs.remove('beginTime');
            return Future.value(true);
          }

          // Condition 2: Check if alarm of this class has already been set
          var previousCourseCode = _prefs.getString('courseCode') == null
              ? ''
              : _prefs.getString('courseCode');
          var previousBeginTime = _prefs.getString('beginTime') == null
              ? ''
              : _prefs.getString('beginTime');
          var currentCourseCode = earliestClass.courseCode.toString();
          var currentBeginTime = earliestClass.beginTime.toString();

          if (previousCourseCode == currentCourseCode &&
              previousBeginTime == currentBeginTime) {
            var _flnp = NotificationServiceApi.initialize();
            // kept for demonstration purpose only
            NotificationServiceApi.showNotification('Class Manager',
                'Class alarm has already been set!', 'payload', _flnp);
            return Future.value(true);
          }

          // Condition 3: Passing 1 and 2 means that new routine is available
          // var _flnp = NotificationServiceApi.initialize();
          NotificationServiceApi.showNotification('Class Manager',
              'Hello good people, routine has been updated!', 'payload', _flnp);

          _prefs.setString('courseCode', earliestClass.courseCode.toString());
          _prefs.setString('beginTime', earliestClass.beginTime.toString());

          var year = earliestClass.routineDate.year;
          var month = earliestClass.routineDate.month;
          var day = earliestClass.routineDate.day;
          var hour =
              int.parse(earliestClass.beginTime.toString().substring(0, 2));
          var minute =
              int.parse(earliestClass.beginTime.toString().substring(3, 5));

          NotificationServiceApi.showScheduledNotification(
            title: 'Class Alarm',
            body: 'Wakeup buddy, it is almost class time!',
            payload: 'payload',
            flnp: NotificationServiceApi.initialize(),
            scheduledDate: DateTime(year, month, day, hour, minute),
          );
        } else {
          print('..........entered earlist class as null..........');
          if (_prefs.containsKey('courseCode') &&
              _prefs.containsKey('beginTime')) {
            _prefs.remove('courseCode');
            _prefs.remove('beginTIme');
          }
          // var _flnp = NotificationServiceApi.initialize();
          NotificationServiceApi.cancelAllNotifications();
          // kept only for demonstration purpose
          NotificationServiceApi.showNotification('Class Manager',
              'Hello people, no more classes today, yaay!', 'payload', _flnp);
        }
    }
    return Future.value(true);
  });
}
