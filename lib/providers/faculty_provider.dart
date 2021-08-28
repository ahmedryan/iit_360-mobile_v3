import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iit_360/services/service_constants.dart' as Constants;

class FacultyModel {
  String facultyId;
  String? facultyName;
  String? designation;
  String? qualification;
  String? links;
  String? status;
  String? aboutMe;
  String? teachings;
  String? facultyImageUrl;

  FacultyModel({
    required this.facultyId,
    required this.facultyName,
    required this.designation,
    required this.qualification,
    required this.links,
    required this.status,
    required this.aboutMe,
    required this.teachings,
    required this.facultyImageUrl,
  });
}

class FacultyProvider with ChangeNotifier {
  List<FacultyModel>? faculties;

  Future<void> fetchAndSetFaculties() {
    final url = Uri.parse('${Constants.host}/api/faculties');

    return http.get(url).then(
      (response) {
        final facultyData = json.decode(response.body) as List;
        final List<FacultyModel> loadedFaculties = [];

        facultyData.forEach((faculty) {
          loadedFaculties.add(FacultyModel(
            teachings: faculty['teachings'],
            status: faculty['status'],
            qualification: faculty['qualification'],
            designation: faculty['designation'],
            links: faculty['links'],
            aboutMe: faculty['aboutMe'],
            facultyName: faculty['name'],
            facultyId: faculty['facultyId'],
            facultyImageUrl:
                "${Constants.host}/api/images/${faculty['fkFacultyImage']}",
          ));
        });

        faculties = loadedFaculties;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
