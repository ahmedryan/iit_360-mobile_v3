import 'package:flutter/material.dart';
import 'package:iit_360/providers/event_provider.dart';
import 'package:provider/provider.dart';

class UpcomingEventScreen extends StatefulWidget {
  static const routeName = '/upcoming-event';

  @override
  _UpcomingEventScreenState createState() => _UpcomingEventScreenState();
}

class _UpcomingEventScreenState extends State<UpcomingEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Upcoming Events'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<EventProvider>(context, listen: false)
              .fetchAndSetPreviousEvents(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<EventProvider>(
                builder: (ctx, eventProvider, _) {
                  return ListView.builder(
                    itemCount: eventProvider.upcomingEvents!.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      eventProvider
                                          .upcomingEvents![index].eventTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    eventProvider
                                        .upcomingEvents![index].eventDate
                                        .toIso8601String(),
                                  ),
                                  Text(
                                    eventProvider
                                        .upcomingEvents![index].eventTime,
                                  ),
                                  Text(
                                    eventProvider
                                        .upcomingEvents![index].eventVenue,
                                  ),
                                  Text(
                                    eventProvider.previousEvents![index]
                                        .eventDescription,
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
