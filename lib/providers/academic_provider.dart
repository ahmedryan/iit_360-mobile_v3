import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iit_360/services/service_constants.dart' as Constants;

class AcademicModel {
  int academicId;
  String academicSection;
  String academicProgram;
  String academicInformation;
  String academicAdmission;

  AcademicModel({
    required this.academicId,
    required this.academicSection,
    required this.academicProgram,
    required this.academicInformation,
    required this.academicAdmission,
  });
}

class AcademicProvider with ChangeNotifier {
  List<AcademicModel>? undergradProgramBsse = [];
  List<AcademicModel>? gradProgramMsse = [];
  List<AcademicModel>? gradProgramMit = [];
  List<AcademicModel>? gradProgramPgdit = [];
  List<AcademicModel>? trainingProgramWebDesign = [];
  List<AcademicModel>? trainingProgramWebProgramming = [];
  List<AcademicModel>? trainingProgramOfficeApplication = [];
  List<AcademicModel>? trainingProgramMatlabOriginLatex = [];
  List<AcademicModel>? trainingProgramMobileApplication = [];

  Future<void> fetchAndSetUndergradProgram() {
    final url = Uri.parse('${Constants.host}/api/academics/getacademic/ugs');

    return http.get(url).then(
      (response) {
        final undergradProgramData = json.decode(response.body) as List;
        final List<AcademicModel> loadedUndergradProgram = [];

        undergradProgramData.forEach((element) {
          loadedUndergradProgram.add(
            AcademicModel(
              academicId: element['academicId'],
              academicSection: element['academicSection'],
              academicProgram: element['programs'],
              academicInformation: element['academicInfo'],
              academicAdmission: element['academicAdmission'],
            ),
          );
        });

        undergradProgramBsse = loadedUndergradProgram;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetGradProgram() {
    final url = Uri.parse('${Constants.host}/api/academics/getacademic/gs');

    return http.get(url).then(
      (response) {
        final gradProgramData = json.decode(response.body) as List;
        final List<AcademicModel> loadedGradProgram = [];

        gradProgramData.forEach((element) {
          loadedGradProgram.add(
            AcademicModel(
              academicId: element['academicId'],
              academicSection: element['academicSection'],
              academicProgram: element['programs'],
              academicInformation: element['academicInfo'],
              academicAdmission: element['academicAdmission'],
            ),
          );
        });

        gradProgramMsse = loadedGradProgram
            .where((element) => element.academicProgram.contains('MSSE'))
            .toList();
        gradProgramMit = loadedGradProgram
            .where((element) => element.academicProgram.contains('MIT'))
            .toList();
        gradProgramPgdit = loadedGradProgram
            .where((element) => element.academicProgram.contains('PGDIT'))
            .toList();

        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetTrainingProgram() {
    final url = Uri.parse('${Constants.host}/api/academics/getacademic/tp');

    return http.get(url).then(
      (response) {
        final trainingProgramData = json.decode(response.body) as List;
        final List<AcademicModel> loadedTrainingProgram = [];

        trainingProgramData.forEach((element) {
          loadedTrainingProgram.add(
            AcademicModel(
              academicId: element['academicId'],
              academicSection: element['academicSection'],
              academicProgram: element['programs'],
              academicInformation: element['academicInfo'],
              academicAdmission: element['academicAdmission'],
            ),
          );
        });

        trainingProgramWebDesign = loadedTrainingProgram
            .where((element) => element.academicProgram.contains('Web Design'))
            .toList();
        trainingProgramWebProgramming = loadedTrainingProgram
            .where((element) =>
                element.academicProgram.contains('Web Programming'))
            .toList();
        trainingProgramOfficeApplication = loadedTrainingProgram
            .where((element) =>
                element.academicProgram.contains('Office Applications'))
            .toList();
        trainingProgramMatlabOriginLatex = loadedTrainingProgram
            .where((element) =>
                element.academicProgram.contains('Matlab-Origin-LaTeX'))
            .toList();
        trainingProgramMobileApplication = loadedTrainingProgram
            .where((element) =>
                element.academicProgram.contains('Mobile Application'))
            .toList();

        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
