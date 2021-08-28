import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/services/service_constants.dart' as Constants;

class ObjectiveModel {
  int objectiveId;
  String aim;

  ObjectiveModel({required this.objectiveId, required this.aim});
}

class ObjectiveProvider with ChangeNotifier {
  List<ObjectiveModel>? objectives;

  Future<void> fetchAndSetObjectives() {
    final url = Uri.parse('${Constants.host}/api/anos');

    return http.get(url).then(
      (response) {
        final objectiveData = json.decode(response.body) as List;
        final List<ObjectiveModel> loadedObjectives = [];

        objectiveData.forEach((objective) {
          loadedObjectives.add(
            ObjectiveModel(
              objectiveId: objective['anoId'],
              aim: objective['aim'],
            ),
          );
        });

        objectives = loadedObjectives;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
