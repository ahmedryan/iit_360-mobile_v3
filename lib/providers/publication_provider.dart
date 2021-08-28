import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/services/service_constants.dart' as Constants;

class PublicationModel {
  int publicationId;
  String? publicationTitle;
  String? publicationType;
  int? publicationYear;

  PublicationModel({
    required this.publicationId,
    required this.publicationTitle,
    required this.publicationType,
    required this.publicationYear,
  });
}

class PublicationProvider with ChangeNotifier {
  List<PublicationModel>? publications;

  Future<void> fetchAndSetPublication() {
    final url = Uri.parse('${Constants.host}/api/publications/getpublication');

    return http.get(url).then(
      (response) {
        final publicationData = json.decode(response.body) as List;
        final List<PublicationModel> loadedPublications = [];

        publicationData.forEach((element) {
          loadedPublications.add(
            PublicationModel(
              publicationId: element['publicationId'],
              publicationTitle: element['title'],
              publicationType: element['pubType'],
              publicationYear: element['pubYear'],
            ),
          );
        });

        publications = loadedPublications;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
