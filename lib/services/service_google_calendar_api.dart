import 'dart:developer';

import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleCalendarService {
  static const _scopes = const [CalendarApi.calendarScope];
  final _clientId = new ClientId(
      '328770707335-ak602sj0k7e1tlta5k64ars6ggf9b1ec.apps.googleusercontent.com',
      '');

  // final _googleSignIn = GoogleSignIn(scopes: _scopes);
  //
  // Future<void> getCalendars() async {
  //   await _googleSignIn.signInSilently();
  //   var httpClient = (await _googleSignIn.authenticatedClient());
  //   print('..........http client: $httpClient.........');
  //   var calendarApi = CalendarApi(httpClient!);
  //
  //   calendarApi.calendarList
  //       .list()
  //       .then((value) => value.items!.forEach((element) {
  //             print(element.summary);
  //           }));
  // }

  Future<void> addEvent(String summary, int minutes, DateTime dateTime) {
    Event event = Event();
    EventReminders eventReminders = EventReminders();
    // eventReminders.overrides = EventReminder(minutes: 10);
    event.summary = summary;
    event.reminders = EventReminders(useDefault: true);

    EventDateTime start = new EventDateTime();
    EventDateTime end = new EventDateTime();
    start.dateTime = dateTime;
    start.timeZone = "GMT+06:00";
    end.dateTime = dateTime;
    end.timeZone = "GMT+06:00";

    event.start = start;
    event.end = end;

    return clientViaUserConsent(_clientId, _scopes, _prompt)
        .then((AuthClient client) {
      var calendar = CalendarApi(client);
      String calendarId = "primary";
      calendar.events.insert(event, calendarId).then((value) {
        print('..........added ${value.status}..........');
        if (value.status == "confirmed") {
          log('..........Event added in google calendar..........');
        } else {
          log('..........Unable to add event in google calendar..........');
        }
      });
    });
  }

  void _prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
