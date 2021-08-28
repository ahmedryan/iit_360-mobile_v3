import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/objective_provider.dart';

class ObjectiveScreen extends StatefulWidget {
  static const routeName = '/objective';

  @override
  _ObjectiveScreenState createState() => _ObjectiveScreenState();
}

class _ObjectiveScreenState extends State<ObjectiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Objective'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<ObjectiveProvider>(context, listen: false)
              .fetchAndSetObjectives(),
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
              return Consumer<ObjectiveProvider>(
                builder: (ctx, objProvider, _) {
                  return ListView.builder(
                    itemCount: objProvider.objectives!.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        subtitle: Text(objProvider.objectives![index].aim),
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
