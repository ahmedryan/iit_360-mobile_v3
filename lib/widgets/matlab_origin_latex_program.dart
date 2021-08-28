import 'package:flutter/material.dart';
import 'package:iit_360/providers/academic_provider.dart';
import 'package:provider/provider.dart';

class MatlabOriginLatexProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<AcademicProvider>(context, listen: false)
            .fetchAndSetTrainingProgram(),
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
            return Consumer<AcademicProvider>(
              builder: (ctx, academicProvider, _) {
                return ListView.builder(
                  itemCount:
                      academicProvider.trainingProgramMatlabOriginLatex!.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                academicProvider
                                    .trainingProgramMatlabOriginLatex![index]
                                    .academicProgram,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Visibility(
                              visible: academicProvider
                                  .trainingProgramMatlabOriginLatex![index]
                                  .academicInformation
                                  .isNotEmpty,
                              child: Column(
                                children: [
                                  Text(
                                    'Information',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(academicProvider
                                      .trainingProgramMatlabOriginLatex![index]
                                      .academicInformation),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: academicProvider
                                  .trainingProgramMatlabOriginLatex![index]
                                  .academicAdmission
                                  .isNotEmpty,
                              child: Column(
                                children: [
                                  Text(
                                    'Admission',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(academicProvider
                                      .trainingProgramMatlabOriginLatex![index]
                                      .academicAdmission),
                                ],
                              ),
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
    );
  }
}
