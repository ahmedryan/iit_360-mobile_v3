import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/services/service_constants.dart' as Constants;

class InstitutionModel {
  int institutionId;
  String institutionTitle;
  String institutionDescription;
  int fkInstitutionImageId;

  InstitutionModel({
    required this.institutionId,
    required this.institutionTitle,
    required this.institutionDescription,
    required this.fkInstitutionImageId,
  });
}

class InstitutionProvider with ChangeNotifier {
  List<InstitutionModel>? institutions;

  Future<void> fetchAndSetInstitutions() {
    final url = Uri.parse('${Constants.host}/api/institutions');

    return http.get(url).then(
      (response) {
        final institutionData = json.decode(response.body) as List;
        final List<InstitutionModel> loadedInstitutions = [];

        institutionData.forEach((institution) {
          loadedInstitutions.add(
            InstitutionModel(
              institutionId: institution['institutionId'],
              institutionTitle: institution['instHeader'],
              institutionDescription: institution['instDescription'],
              fkInstitutionImageId: institution['fkInstImage'],
            ),
          );
        });

        institutions = loadedInstitutions;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
