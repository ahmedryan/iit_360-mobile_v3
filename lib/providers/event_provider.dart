import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/services/service_constants.dart' as Constants;

class EventModel {
  int eventId;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  String eventTime;
  String eventVenue;

  EventModel({
    required this.eventId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventTime,
    required this.eventVenue,
  });
}

class EventProvider with ChangeNotifier {
  List<EventModel>? upcomingEvents = [];
  List<EventModel>? previousEvents = [];

  Future<void> fetchAndSetPreviousEvents() {
    final url = Uri.parse('${Constants.host}/api/events/previous');

    return http.get(url).then(
      (response) {
        final eventData = json.decode(response.body) as List;
        final List<EventModel> loadedPreviousNews = [];

        eventData.forEach((element) {
          loadedPreviousNews.add(
            EventModel(
              eventId: element['eventId'],
              eventTitle: element['title'],
              eventDescription: element['description'],
              eventDate: DateTime.parse(element['date']),
              eventTime: element['time'],
              eventVenue: element['venue'],
            ),
          );
        });

        previousEvents = loadedPreviousNews;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetUpcomingEvents() {
    final url = Uri.parse('${Constants.host}/api/events/upcoming');

    return http.get(url).then(
      (response) {
        final eventData = json.decode(response.body) as List;
        final List<EventModel> loadedUpcomingNews = [];

        eventData.forEach((element) {
          loadedUpcomingNews.add(
            EventModel(
              eventId: element['eventId'],
              eventTitle: element['title'],
              eventDescription: element['description'],
              eventDate: DateTime.parse(element['date']),
              eventTime: element['time'],
              eventVenue: element['venue'],
            ),
          );
        });

        upcomingEvents = loadedUpcomingNews;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
