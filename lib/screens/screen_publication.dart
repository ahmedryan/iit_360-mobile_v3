import 'package:flutter/material.dart';
import 'package:iit_360/providers/publication_provider.dart';
import 'package:provider/provider.dart';

class PublicationScreen extends StatefulWidget {
  static const routeName = '/publication';

  @override
  _PublicationScreenState createState() => _PublicationScreenState();
}

class _PublicationScreenState extends State<PublicationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Publications'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<PublicationProvider>(context, listen: false)
              .fetchAndSetPublication(),
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
              return Consumer<PublicationProvider>(
                builder: (ctx, publicationProvider, _) {
                  return ListView.builder(
                    itemCount: publicationProvider.publications!.length,
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
                                'Publication Type: ${publicationProvider.publications![index].publicationType.toString()}',
                              ),
                              Text(
                                'Year of Publish: ${publicationProvider.publications![index].publicationYear.toString()}',
                              ),
                              Text(
                                publicationProvider
                                    .publications![index].publicationTitle
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
