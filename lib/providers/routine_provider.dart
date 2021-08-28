import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/services/service_constants.dart' as Constants;

class RoutineModel {
  int routineId;
  DateTime routineDate;
  String? courseCode;
  String? beginTime;
  String? endTime;
  String? semester;
  String? dayName;
  String? instructorCode;

  RoutineModel({
    required this.routineId,
    required this.routineDate,
    required this.courseCode,
    required this.beginTime,
    required this.endTime,
    required this.semester,
    required this.dayName,
    required this.instructorCode,
  });
}

class RoutineProvider with ChangeNotifier {
  String? studentEmail;
  List<RoutineModel> weekRoutine = [];

  List<RoutineModel> sunRoutine = [];
  List<RoutineModel> monRoutine = [];
  List<RoutineModel> tueRoutine = [];
  List<RoutineModel> wedRoutine = [];
  List<RoutineModel> thuRoutine = [];
  List<RoutineModel> friRoutine = [];
  List<RoutineModel> satRoutine = [];

  List<String>? courses = [];
  int? requestStatusCode;
  String? token;

  RoutineProvider({this.studentEmail, this.token});

  Future<void> fetchAndSetWeekRoutine() {
    final url =
        Uri.parse('${Constants.host}/api/routines/weekroutine/$studentEmail');

    return http.get(url).then(
      (response) {
        final routineData = json.decode(response.body) as List;
        final List<RoutineModel> loadedRoutine = [];

        final List<RoutineModel> sunLoadedRoutine = [];
        final List<RoutineModel> monLoadedRoutine = [];
        final List<RoutineModel> tueLoadedRoutine = [];
        final List<RoutineModel> wedLoadedRoutine = [];
        final List<RoutineModel> thuLoadedRoutine = [];
        final List<RoutineModel> friLoadedRoutine = [];
        final List<RoutineModel> satLoadedRoutine = [];

        routineData.forEach((element) {
          var model = RoutineModel(
            routineId: element['routineId'],
            routineDate: DateTime.parse(element['date']),
            courseCode: element['courseCode'],
            beginTime: element['beginTime'],
            endTime: element['endTime'],
            semester: element['semester'],
            dayName: element['dayname'],
            instructorCode: element['fkInstructorId'],
          );

          loadedRoutine.add(model);
          print(model.courseCode);
          print(model.dayName);
          print(model.routineDate);
          print('..........');

          if (model.dayName == 'Sun') sunLoadedRoutine.add(model);
          if (model.dayName == 'Mon') monLoadedRoutine.add(model);
          if (model.dayName == 'Tue') tueLoadedRoutine.add(model);
          if (model.dayName == 'Wed') wedLoadedRoutine.add(model);
          if (model.dayName == 'Thu') thuLoadedRoutine.add(model);
          if (model.dayName == 'Fri') friLoadedRoutine.add(model);
          if (model.dayName == 'Sat') satLoadedRoutine.add(model);
        });

        weekRoutine = loadedRoutine;

        sunRoutine = sunLoadedRoutine;
        monRoutine = monLoadedRoutine;
        tueRoutine = tueLoadedRoutine;
        wedRoutine = wedLoadedRoutine;
        thuRoutine = thuLoadedRoutine;
        friRoutine = friLoadedRoutine;
        satRoutine = satLoadedRoutine;

        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetCourses() {
    final url =
        Uri.parse('${Constants.host}/api/routines/getcourse/$studentEmail');

    return http.get(url).then(
      (response) {
        final courseData = json.decode(response.body) as List;
        final List<String> loadedCourses = [];

        courseData.forEach((element) {
          loadedCourses.add(element);
        });

        courses = loadedCourses;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> cancelClass(String courseCode, String classDate) {
    final url = Uri.parse('${Constants.host}/api/routines/cancelclass');

    print(url);
    print(token);
    print(studentEmail);
    print(courseCode);
    print(classDate);

    return http.delete(url,
        body: json.encode({
          "token": token,
          "mail_id": studentEmail,
          "course_code": courseCode,
          "date": classDate,
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        }).then(
      (response) {
        print(response.statusCode);
        print(response.body);
        requestStatusCode = response.statusCode;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });

    notifyListeners();
  }

  Future<void> extraClass(
    String courseCode,
    String classDate,
    String beginTime,
    String endTime,
    String instructorCode,
  ) {
    final url = Uri.parse('${Constants.host}/api/routines/extraclass');

    print(studentEmail);
    print(courseCode);
    print(classDate);
    print(beginTime);
    print(endTime);
    print(instructorCode);

    print(url);

    return http.post(url,
        body: json.encode({
          "token": token,
          "mail_id": studentEmail,
          "cc": courseCode,
          "date": classDate,
          "begin": beginTime,
          "end": endTime,
          "ic": instructorCode
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        }).then(
      (response) {
        print(response.statusCode);
        print(response.body);
        print(response.request);

        requestStatusCode = response.statusCode;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> rescheduleClass(String courseCode, String oldDate,
      String newDate, String beginTime, String endTime) {
    final url = Uri.parse('${Constants.host}/api/routines/reschedule');

    print(url);

    return http.post(url,
        body: json.encode({
          "token": token,
          "mail_id": studentEmail,
          "cc": courseCode,
          "oldDate": oldDate,
          "newDate": newDate,
          "begin": beginTime,
          "end": endTime,
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        }).then(
      (response) {
        print(response.statusCode);
        print(response.body);

        requestStatusCode = response.statusCode;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> swapClass(String courseCode1, String courseCode2,
      String classDate1, String classDate2) {
    final url = Uri.parse('${Constants.host}/api/routines/swapclass');

    print(url);

    return http.put(url,
        body: json.encode({
          "token": token,
          "mail_id": studentEmail,
          "cc1": courseCode1,
          "d1": classDate1,
          "cc2": courseCode2,
          "d2": classDate2
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        }).then(
      (response) {
        print(response.statusCode);
        print(response.body);

        requestStatusCode = response.statusCode;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
