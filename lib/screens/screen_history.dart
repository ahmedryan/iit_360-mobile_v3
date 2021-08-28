import 'package:flutter/material.dart';
import 'package:iit_360/providers/history_provider.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/history';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('History'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<HistoryProvider>(context, listen: false)
              .fetchAndSetHistories(),
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
              return Consumer<HistoryProvider>(
                builder: (ctx, historyProvider, _) {
                  return ListView.builder(
                    itemCount: historyProvider.histories!.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        title: Text(
                            historyProvider.histories![index].directorName),
                        subtitle: Text(
                            '${historyProvider.histories![index].actFrom} to ${historyProvider.histories![index].actTo}'),
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
