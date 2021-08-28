import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iit_360/services/service_constants.dart' as Constants;

class InstructorModel {
  String? instructorId;
  String? instructorMail;
  String? instructorName;

  InstructorModel({
    required this.instructorId,
    required this.instructorMail,
    required this.instructorName,
  });
}

class InstructorProvider with ChangeNotifier {
  List<InstructorModel>? instructors = [];

  Future<void> fetchAndSetInstructors() {
    final url = Uri.parse('${Constants.host}/api/instructors');

    return http.get(url).then(
      (response) {
        final instructorData = json.decode(response.body) as List;
        final List<InstructorModel> loadedInstructors = [];

        instructorData.forEach((faculty) {
          loadedInstructors.add(InstructorModel(
            instructorId: faculty['instructorId'],
            instructorMail: faculty['instructorMail'],
            instructorName: faculty['instructorName'],
          ));
        });

        instructors = loadedInstructors;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
