import 'package:flutter/material.dart';
import 'package:iit_360/providers/event_provider.dart';
import 'package:provider/provider.dart';

class PreviousEventScreen extends StatefulWidget {
  static const routeName = '/event-news';

  @override
  _PreviousEventScreenState createState() => _PreviousEventScreenState();
}

class _PreviousEventScreenState extends State<PreviousEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Previous Events'),
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
                    itemCount: eventProvider.previousEvents!.length,
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
                                          .previousEvents![index].eventTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    eventProvider
                                        .previousEvents![index].eventDate
                                        .toIso8601String(),
                                  ),
                                  Text(
                                    eventProvider
                                        .previousEvents![index].eventTime,
                                  ),
                                  Text(
                                    eventProvider
                                        .previousEvents![index].eventVenue,
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
