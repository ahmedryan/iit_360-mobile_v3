import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iit_360/services/service_constants.dart' as Constants;

class StaffModel {
  int staffId;
  String staffName;
  String? designation;
  String? staffImageUrl;

  StaffModel({
    required this.staffId,
    required this.staffName,
    required this.designation,
    required this.staffImageUrl,
  });
}

class StaffProvider with ChangeNotifier {
  List<StaffModel>? staffs;

  Future<void> fetchAndSetStaffs() {
    final url = Uri.parse('${Constants.host}/api/staffs');

    return http.get(url).then(
      (response) {
        final staffData = json.decode(response.body) as List;
        final List<StaffModel> loadedStaffs = [];

        staffData.forEach((staff) {
          loadedStaffs.add(StaffModel(
            designation: staff['designation'],
            staffName: staff['name'],
            staffId: staff['staffsId'],
            staffImageUrl:
                "${Constants.host}/api/images/${staff['fkStaffImage']}",
          ));
        });

        staffs = loadedStaffs;
        notifyListeners();
      },
    ).catchError((err) {
      print(err);
    });
  }
}
