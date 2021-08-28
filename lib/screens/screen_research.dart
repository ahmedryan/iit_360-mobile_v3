import 'package:flutter/material.dart';
import 'package:iit_360/providers/research_provider.dart';
import 'package:provider/provider.dart';

class ResearchScreen extends StatefulWidget {
  static const routeName = '/research';

  @override
  _ResearchScreenState createState() => _ResearchScreenState();
}

class _ResearchScreenState extends State<ResearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Research'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<ResearchProvider>(context, listen: false)
              .fetchAndSetResearch(),
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
              return Consumer<ResearchProvider>(
                builder: (ctx, researchProvider, _) {
                  return ListView.builder(
                    itemCount: researchProvider.research!.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              Text(
                                researchProvider.research![index].researchTitle
                                    .toString(),
                              ),
                              Text(
                                researchProvider.research![index].description
                                    .toString(),
                              ),
                            ],
                          ),
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
