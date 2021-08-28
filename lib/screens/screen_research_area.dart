import 'package:flutter/material.dart';
import 'package:iit_360/providers/research_area_provider.dart';
import 'package:provider/provider.dart';

class ResearchAreaScreen extends StatefulWidget {
  static const routeName = '/research-area';

  @override
  _ResearchAreaScreenState createState() => _ResearchAreaScreenState();
}

class _ResearchAreaScreenState extends State<ResearchAreaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Research Area'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<ResearchAreaProvider>(context, listen: false)
              .fetchAndSetResearchAreas(),
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
              return Consumer<ResearchAreaProvider>(
                builder: (ctx, researchAreaProvider, _) {
                  return ListView.builder(
                    itemCount: researchAreaProvider.researchAreas!.length,
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
                                'Field: ${researchAreaProvider.researchAreas![index].fieldName.toString()}',
                              ),
                              Text(
                                researchAreaProvider
                                    .researchAreas![index].areaDescription
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
