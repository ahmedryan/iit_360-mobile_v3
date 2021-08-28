import 'package:flutter/material.dart';
import 'package:iit_360/providers/notice_provider.dart';
import 'package:provider/provider.dart';

class RegistrarOfficeNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<NoticeProvider>(context, listen: false)
            .fetchAndSetGeneralNoticeRegistrarOffice(),
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
                return noticeProvider.generalNoticeRegistrarOffice!.length == 0
                    ? Center(
                        child: Text('No Notices Available...'),
                      )
                    : ListView.builder(
                        itemCount:
                            noticeProvider.generalNoticeRegistrarOffice!.length,
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
                                                .generalNoticeRegistrarOffice![
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
                                              .generalNoticeRegistrarOffice![
                                                  index]
                                              .noticeDate
                                              .toIso8601String(),
                                        ),
                                        Text(
                                          noticeProvider
                                              .generalNoticeRegistrarOffice![
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
                                                .generalNoticeRegistrarOffice![
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
                                              .generalNoticeRegistrarOffice![
                                                  index]
                                              .noticeDescription,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          noticeProvider
                                              .generalNoticeRegistrarOffice![
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
