import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iit_360/services/service_constants.dart' as Constants;

class NoticeModel {
  int noticeId;
  String noticeSection;
  String noticeTitle;
  String noticeDescription;
  DateTime noticeDate;
  String noticeTime;
  int noticeDocumentId;

  NoticeModel({
    required this.noticeId,
    required this.noticeSection,
    required this.noticeTitle,
    required this.noticeDescription,
    required this.noticeDate,
    required this.noticeTime,
    required this.noticeDocumentId,
  });
}

class NoticeProvider with ChangeNotifier {
  List<NoticeModel>? projectNotice = [];
  List<NoticeModel>? generalNoticeScholarship = [];
  List<NoticeModel>? generalNoticeRegistrarOffice = [];
  List<NoticeModel>? undergradNoticeBsse = [];
  List<NoticeModel>? gradNoticeMsse = [];
  List<NoticeModel>? gradNoticeMit = [];
  List<NoticeModel>? gradNoticePgdit = [];
  List<NoticeModel>? trainingNoticeWebDesign = [];
  List<NoticeModel>? trainingNoticeWebProgramming = [];
  List<NoticeModel>? trainingNoticeOfficeApplication = [];
  List<NoticeModel>? trainingNoticeMatlabOriginLatex = [];
  List<NoticeModel>? trainingNoticeMobileApplication = [];

  Future<void> fetchAndSetProjectNotice() {
    final url = Uri.parse('${Constants.host}/api/notices/getnotice/project');

    return http.get(url).then(
      (response) {
        final projectNoticeData = json.decode(response.body) as List;
        final List<NoticeModel> loadedProjectNotice = [];

        projectNoticeData.forEach((element) {
          loadedProjectNotice.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        projectNotice = loadedProjectNotice;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetGeneralNoticeScholarship() {
    final url =
        Uri.parse('${Constants.host}/api/notices/getnotice/scholarship');

    return http.get(url).then(
      (response) {
        final generalNoticeScholarshipData = json.decode(response.body) as List;
        final List<NoticeModel> loadedGeneralNoticeScholarship = [];

        generalNoticeScholarshipData.forEach((element) {
          loadedGeneralNoticeScholarship.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        generalNoticeScholarship = loadedGeneralNoticeScholarship;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetGeneralNoticeRegistrarOffice() {
    final url =
        Uri.parse('${Constants.host}/api/notices/getnotice/registrar%20office');

    return http.get(url).then(
      (response) {
        final generalNoticeRegistrarOfficeData =
            json.decode(response.body) as List;
        final List<NoticeModel> loadedGeneralNoticeRegistrarOffice = [];

        generalNoticeRegistrarOfficeData.forEach((element) {
          loadedGeneralNoticeRegistrarOffice.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        generalNoticeRegistrarOffice = loadedGeneralNoticeRegistrarOffice;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetUndergradNoticeBsse() {
    final url =
        Uri.parse('${Constants.host}/api/notices/getnotice/registrar%20office');

    return http.get(url).then(
      (response) {
        final undergradNoticeBsseData = json.decode(response.body) as List;
        final List<NoticeModel> loadedUndergradNoticeBsse = [];

        undergradNoticeBsseData.forEach((element) {
          loadedUndergradNoticeBsse.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        undergradNoticeBsse = loadedUndergradNoticeBsse;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetGradNoticeMsse() {
    final url = Uri.parse('${Constants.host}/api/notices/getnotice/msse');

    return http.get(url).then(
      (response) {
        final gradNoticeMsseData = json.decode(response.body) as List;
        final List<NoticeModel> loadedGradNoticeMsse = [];

        gradNoticeMsseData.forEach((element) {
          loadedGradNoticeMsse.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        gradNoticeMsse = loadedGradNoticeMsse;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetGradNoticeMit() {
    final url = Uri.parse('${Constants.host}/api/notices/getnotice/mit');

    return http.get(url).then(
      (response) {
        final gradNoticeMitData = json.decode(response.body) as List;
        final List<NoticeModel> loadedGradNoticeMit = [];

        gradNoticeMitData.forEach((element) {
          loadedGradNoticeMit.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        gradNoticeMit = loadedGradNoticeMit;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetGradNoticePgdit() {
    final url = Uri.parse('${Constants.host}/api/notices/getnotice/pgdit');

    return http.get(url).then(
      (response) {
        final gradNoticePgditData = json.decode(response.body) as List;
        final List<NoticeModel> loadedGradNoticePgdit = [];

        gradNoticePgditData.forEach((element) {
          loadedGradNoticePgdit.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        gradNoticePgdit = loadedGradNoticePgdit;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetTrainingNoticeWebDesign() {
    final url =
        Uri.parse('${Constants.host}/api/notices/getnotice/web%20design');

    return http.get(url).then(
      (response) {
        final trainingNoticeWebDesignData = json.decode(response.body) as List;
        final List<NoticeModel> loadedTrainingNoticeWebDesign = [];

        trainingNoticeWebDesignData.forEach((element) {
          loadedTrainingNoticeWebDesign.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        trainingNoticeWebDesign = loadedTrainingNoticeWebDesign;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetTrainingNoticeWebProgramming() {
    final url =
        Uri.parse('${Constants.host}/api/notices/getnotice/web%20programming');

    return http.get(url).then(
      (response) {
        final trainingNoticeWebProgrammingData =
            json.decode(response.body) as List;
        final List<NoticeModel> loadedTrainingNoticeWebProgramming = [];

        trainingNoticeWebProgrammingData.forEach((element) {
          loadedTrainingNoticeWebProgramming.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        trainingNoticeWebProgramming = loadedTrainingNoticeWebProgramming;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetTrainingNoticeOfficeApplication() {
    final url = Uri.parse(
        '${Constants.host}/api/notices/getnotice/office%20applications');

    return http.get(url).then(
      (response) {
        final trainingNoticeOfficeApplicationData =
            json.decode(response.body) as List;
        final List<NoticeModel> loadedTrainingNoticeOfficeApplication = [];

        trainingNoticeOfficeApplicationData.forEach((element) {
          loadedTrainingNoticeOfficeApplication.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        trainingNoticeOfficeApplication = loadedTrainingNoticeOfficeApplication;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetTrainingNoticeMatlabOriginLatex() {
    final url = Uri.parse(
        '${Constants.host}/api/notices/getnotice/matlab-origin-latex');

    return http.get(url).then(
      (response) {
        final trainingNoticeMatlabOriginLatexData =
            json.decode(response.body) as List;
        final List<NoticeModel> loadedTrainingNoticeMatlabOriginLatex = [];

        trainingNoticeMatlabOriginLatexData.forEach((element) {
          loadedTrainingNoticeMatlabOriginLatex.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        trainingNoticeMatlabOriginLatex = loadedTrainingNoticeMatlabOriginLatex;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }

  Future<void> fetchAndSetTrainingNoticeMobileApplication() {
    final url = Uri.parse(
        '${Constants.host}/api/notices/getnotice/mobile%20application');

    return http.get(url).then(
      (response) {
        final trainingNoticeMobileApplicationData =
            json.decode(response.body) as List;
        final List<NoticeModel> loadedTrainingNoticeMobileApplication = [];

        trainingNoticeMobileApplicationData.forEach((element) {
          loadedTrainingNoticeMobileApplication.add(
            NoticeModel(
              noticeId: element['noticeId'],
              noticeSection: element['section'],
              noticeTitle: element['title'],
              noticeDescription: element['description'],
              noticeDate: DateTime.parse(element['date']),
              noticeTime: element['time'],
              noticeDocumentId: element['fkNoticeDocument'],
            ),
          );
        });

        trainingNoticeMobileApplication = loadedTrainingNoticeMobileApplication;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
