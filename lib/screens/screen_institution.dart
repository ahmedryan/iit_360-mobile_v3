import 'package:flutter/material.dart';
import 'package:iit_360/providers/institution_provider.dart';
import 'package:provider/provider.dart';

class InstitutionScreen extends StatefulWidget {
  static const routeName = '/institution';

  @override
  _InstitutionScreenState createState() => _InstitutionScreenState();
}

class _InstitutionScreenState extends State<InstitutionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Institution'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<InstitutionProvider>(context, listen: false)
              .fetchAndSetInstitutions(),
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
              return Consumer<InstitutionProvider>(
                builder: (ctx, institutionProvider, _) {
                  return ListView.builder(
                    itemCount: institutionProvider.institutions!.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        title: Text(institutionProvider
                            .institutions![index].institutionTitle),
                        subtitle: Text(institutionProvider
                            .institutions![index].institutionDescription),
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
