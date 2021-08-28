import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/services/service_constants.dart' as Constants;

class ResearchAreaModel {
  int researchAreaId;
  String? fieldName;
  String? areaDescription;

  ResearchAreaModel({
    required this.researchAreaId,
    required this.fieldName,
    required this.areaDescription,
  });
}

class ResearchAreaProvider with ChangeNotifier {
  List<ResearchAreaModel>? researchAreas;

  Future<void> fetchAndSetResearchAreas() {
    final url = Uri.parse('${Constants.host}/api/researchareas');

    return http.get(url).then(
      (response) {
        final researchAreaData = json.decode(response.body) as List;
        final List<ResearchAreaModel> loadedResearchAreas = [];

        researchAreaData.forEach((element) {
          loadedResearchAreas.add(
            ResearchAreaModel(
              researchAreaId: element['researchAreaId'],
              fieldName: element['fieldName'],
              areaDescription: element['areaDescription'],
            ),
          );
        });

        researchAreas = loadedResearchAreas;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
