import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iit_360/services/service_constants.dart' as Constants;

import '/services/service_constants.dart' as Constants;

class AchievementModel {
  int achievementId;
  String achievementTitle;
  String achievementDescription;
  DateTime achievementDate;
  String achievementVenue;
  String achievementImageUrl;
  String achievementImageCaption;

  AchievementModel({
    required this.achievementId,
    required this.achievementTitle,
    required this.achievementDescription,
    required this.achievementDate,
    required this.achievementVenue,
    required this.achievementImageUrl,
    required this.achievementImageCaption,
  });
}

class AchievementProvider with ChangeNotifier {
  List<AchievementModel>? achievements = [];

  Future<void> fetchAndSetAchievements() {
    final url = Uri.parse('${Constants.host}/api/achievements');

    return http.get(url).then(
      (response) {
        final achievementData = json.decode(response.body) as List;
        final List<AchievementModel> loadedAchievements = [];

        achievementData.forEach((element) {
          loadedAchievements.add(
            AchievementModel(
              achievementId: element['achievementId'],
              achievementTitle: element['title'],
              achievementDescription: element['description'],
              achievementVenue: element['venue'],
              achievementImageCaption: element['imageCaption'],
              achievementDate: DateTime.parse(element['date']),
              achievementImageUrl:
                  '${Constants.host}/api/images/${element['fkAchievementImage']}',
            ),
          );
        });

        achievements = loadedAchievements;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
