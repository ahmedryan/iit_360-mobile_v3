import 'package:flutter/material.dart';
import 'package:iit_360/providers/achievement_provider.dart';
import 'package:provider/provider.dart';

class AchievementScreen extends StatefulWidget {
  static const routeName = '/achievement';

  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Achievements'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<AchievementProvider>(context, listen: false)
              .fetchAndSetAchievements(),
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
              return Consumer<AchievementProvider>(
                builder: (ctx, achievementProvider, _) {
                  return ListView.builder(
                    itemCount: achievementProvider.achievements!.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        achievementProvider.achievements![index]
                                            .achievementVenue,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Text(
                                      achievementProvider
                                          .achievements![index].achievementDate
                                          .toIso8601String(),
                                    )
                                  ],
                                ),
                              ),
                            )
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
