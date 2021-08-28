import 'package:flutter/material.dart';
import 'package:iit_360/screens/screen_achievement.dart';
import 'package:iit_360/screens/screen_event_upcoming.dart';
import 'package:iit_360/screens/screen_notice_general.dart';
import 'package:iit_360/screens/screen_notice_graduate.dart';
import 'package:iit_360/screens/screen_notice_project.dart';
import 'package:iit_360/screens/screen_notice_training.dart';
import 'package:iit_360/screens/screen_notice_undergraduate.dart';
import 'package:iit_360/screens/screen_program_training.dart';
import 'package:iit_360/screens/screen_program_undergraduate.dart';
import 'package:iit_360/screens/screen_publication.dart';
import 'package:iit_360/screens/screen_research.dart';
import 'package:iit_360/screens/screen_research_area.dart';

import '/widgets/content.dart';
import 'screen_event_previous.dart';
import 'screen_faculty.dart';
import 'screen_history.dart';
import 'screen_institution.dart';
import 'screen_objective.dart';
import 'screen_program_graduate.dart';
import 'screen_staff.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  final contents = [
    {
      'details': {
        'title': 'ABOUT IIT',
        'color': Color(0xFFC04870),
      },
      'items': [
        {
          'title': 'Institution',
          'image': 'images/institution.jpg',
          'route': InstitutionScreen.routeName
        },
        {
          'title': 'Objective',
          'image': 'images/objective.jpg',
          'route': ObjectiveScreen.routeName
        },
        {
          'title': 'History',
          'image': 'images/history.jpg',
          'route': HistoryScreen.routeName
        },
        {
          'title': 'Faculty',
          'image': 'images/faculty.jpg',
          'route': FacultyScreen.routeName
        },
        {
          'title': 'Staff',
          'image': 'images/staff.jpg',
          'route': StaffScreen.routeName
        },
      ]
    },
    {
      'details': {
        'title': 'ACADEMIC',
        'color': Color(0xFFF0B840),
      },
      'items': [
        {
          'title': 'Undergraduate Studies',
          'image': 'images/undergraduateAcademy.jpg',
          'route': UndergraduateProgramScreen.routeName
        },
        {
          'title': 'Graduate Studies',
          'image': 'images/graduateAcademy.jpg',
          'route': GraduateProgramScreen.routeName
        },
        {
          'title': 'Training Programs',
          'image': 'images/trainingAcademy.jpg',
          'route': TrainingProgramScreen.routeName
        },
      ]
    },
    {
      'details': {
        'title': 'NOTICES',
        'color': Color(0xFF9078D8),
      },
      'items': [
        {
          'title': 'General',
          'image': 'images/general.jpg',
          'route': GeneralNoticeScreen.routeName
        },
        {
          'title': 'Projects',
          'image': 'images/project.jpg',
          'route': ProjectNoticeScreen.routeName
        },
        {
          'title': 'Undergraduate Studies',
          'image': 'images/undergraduateNotice.jpg',
          'route': UndergraduateNoticeScreen.routeName
        },
        {
          'title': 'Graduate Studies',
          'image': 'images/graduateNotice.jpg',
          'route': GradNoticeScreen.routeName
        },
        {
          'title': 'Training Programs',
          'image': 'images/trainingNotice.jpg',
          'route': TrainingNoticeScreen.routeName
        },
      ]
    },
    {
      'details': {
        'title': 'LIFE IN IIT',
        'color': Color(0xFF30B898),
      },
      'items': [
        {
          'title': 'News and Events',
          'image': 'images/news.jpg',
          'route': PreviousEventScreen.routeName
        },
        {
          'title': 'Achievements',
          'image': 'images/achievement.jpg',
          'route': AchievementScreen.routeName
        },
        {
          'title': 'Upcoming Events',
          'image': 'images/event.jpg',
          'route': UpcomingEventScreen.routeName
        },
      ]
    },
    {
      'details': {
        'title': 'RESEARCH',
        'color': Color(0xFF606060),
      },
      'items': [
        {
          'title': 'Research',
          'image': 'images/research.jpg',
          'route': ResearchScreen.routeName
        },
        {
          'title': 'Publications',
          'image': 'images/publication.jpg',
          'route': PublicationScreen.routeName
        },
        {
          'title': 'Research Area',
          'image': 'images/researchArea.jpg',
          'route': ResearchAreaScreen.routeName
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.blue.withOpacity(0.5),
          title: Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          pinned: false,
          floating: true,
          snap: false,
          expandedHeight: 50,
        ),
        SliverFixedExtentList(
          itemExtent: 278,
          delegate: SliverChildListDelegate(
            contents
                .map<Widget>((item) => Content(
                      itemList: item['items'],
                      indexDetails: item['details'],
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
