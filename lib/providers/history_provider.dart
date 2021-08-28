import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/services/service_constants.dart' as Constants;

class HistoryModel {
  int historyId;
  String historyTitle;
  String directorName;
  String actFrom;
  String actTo;

  HistoryModel({
    required this.historyId,
    required this.historyTitle,
    required this.directorName,
    required this.actFrom,
    required this.actTo,
  });
}

class HistoryProvider with ChangeNotifier {
  List<HistoryModel>? histories;

  Future<void> fetchAndSetHistories() {
    final url = Uri.parse('${Constants.host}/api/histories');

    return http.get(url).then(
      (response) {
        final historyData = json.decode(response.body) as List;
        final List<HistoryModel> loadedHistories = [];

        historyData.forEach((institution) {
          loadedHistories.add(HistoryModel(
            historyId: institution['historyId'],
            historyTitle: institution['headingText'],
            directorName: institution['directorName'],
            actTo: institution['actTo'],
            actFrom: institution['actFrom'],
          ));
        });

        histories = loadedHistories;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
