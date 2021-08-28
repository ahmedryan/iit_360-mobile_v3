import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/services/service_constants.dart' as Constants;

class ResearchModel {
  int researchId;
  String? researchTitle;
  String? description;
  String? fkFacultyResearch;

  ResearchModel({
    required this.researchId,
    required this.researchTitle,
    required this.description,
    required this.fkFacultyResearch,
  });
}

class ResearchProvider with ChangeNotifier {
  List<ResearchModel>? research;

  Future<void> fetchAndSetResearch() {
    final url = Uri.parse('${Constants.host}/api/researches/getresearch');

    return http.get(url).then(
      (response) {
        final researchData = json.decode(response.body) as List;
        final List<ResearchModel> loadedResearch = [];

        researchData.forEach((element) {
          loadedResearch.add(ResearchModel(
            researchId: element['researchId'],
            description: element['description'],
            researchTitle: element['title'],
            fkFacultyResearch: element['fkFacultyResearch'],
          ));
        });

        research = loadedResearch;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
