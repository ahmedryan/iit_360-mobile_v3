import 'package:flutter/material.dart';
import 'package:iit_360/providers/notice_provider.dart';
import 'package:provider/provider.dart';

class WebProgrammingNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<NoticeProvider>(context, listen: false)
            .fetchAndSetTrainingNoticeWebProgramming(),
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
            return Consumer<NoticeProvider>(
              builder: (ctx, noticeProvider, _) {
                return noticeProvider.trainingNoticeWebProgramming!.length == 0
                    ? Center(
                        child: Text('No Notices Available...'),
                      )
                    : ListView.builder(
                        itemCount:
                            noticeProvider.trainingNoticeWebProgramming!.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Card(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            noticeProvider
                                                .trainingNoticeWebProgramming![
                                                    index]
                                                .noticeSection,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Text(
                                          noticeProvider
                                              .trainingNoticeWebProgramming![
                                                  index]
                                              .noticeDate
                                              .toIso8601String(),
                                        ),
                                        Text(
                                          noticeProvider
                                              .trainingNoticeWebProgramming![
                                                  index]
                                              .noticeTime,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            noticeProvider
                                                .trainingNoticeWebProgramming![
                                                    index]
                                                .noticeTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Text(
                                          noticeProvider
                                              .trainingNoticeWebProgramming![
                                                  index]
                                              .noticeDescription,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          noticeProvider
                                              .trainingNoticeWebProgramming![
                                                  index]
                                              .noticeDocumentId
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
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
    );
  }
}
