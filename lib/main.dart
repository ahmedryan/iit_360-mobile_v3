import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iit_360/providers/academic_provider.dart';
import 'package:iit_360/providers/achievement_provider.dart';
import 'package:iit_360/providers/event_provider.dart';
import 'package:iit_360/providers/faculty_provider.dart';
import 'package:iit_360/providers/history_provider.dart';
import 'package:iit_360/providers/institution_provider.dart';
import 'package:iit_360/providers/instructor_provider.dart';
import 'package:iit_360/providers/notice_provider.dart';
import 'package:iit_360/providers/objective_provider.dart';
import 'package:iit_360/providers/publication_provider.dart';
import 'package:iit_360/providers/research_area_provider.dart';
import 'package:iit_360/providers/research_provider.dart';
import 'package:iit_360/providers/routine_provider.dart';
import 'package:iit_360/providers/staff_provider.dart';
import 'package:iit_360/screens/screen_class_cancel.dart';
import 'package:iit_360/screens/screen_class_extra.dart';
import 'package:iit_360/screens/screen_class_reschedule.dart';
import 'package:iit_360/screens/screen_class_swap.dart';
import 'package:iit_360/screens/screen_dashboard.dart';
import 'package:iit_360/screens/screen_event_reminder.dart';
import 'package:iit_360/screens/screen_home_guest.dart';
import 'package:iit_360/screens/screen_routine_edit.dart';
import 'package:iit_360/services/service_worker_api.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'providers/auth_provider.dart';
import 'screens/screen_achievement.dart';
import 'screens/screen_auth.dart';
import 'screens/screen_event_previous.dart';
import 'screens/screen_event_upcoming.dart';
import 'screens/screen_faculty.dart';
import 'screens/screen_history.dart';
import 'screens/screen_home.dart';
import 'screens/screen_institution.dart';
import 'screens/screen_notice_general.dart';
import 'screens/screen_notice_graduate.dart';
import 'screens/screen_notice_project.dart';
import 'screens/screen_notice_training.dart';
import 'screens/screen_notice_undergraduate.dart';
import 'screens/screen_objective.dart';
import 'screens/screen_program_graduate.dart';
import 'screens/screen_program_training.dart';
import 'screens/screen_program_undergraduate.dart';
import 'screens/screen_publication.dart';
import 'screens/screen_research.dart';
import 'screens/screen_research_area.dart';
import 'screens/screen_splash.dart';
import 'screens/screen_staff.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => ObjectiveProvider()),
        ChangeNotifierProvider(create: (ctx) => InstitutionProvider()),
        ChangeNotifierProvider(create: (ctx) => HistoryProvider()),
        ChangeNotifierProvider(create: (ctx) => FacultyProvider()),
        ChangeNotifierProvider(create: (ctx) => InstructorProvider()),
        ChangeNotifierProvider(create: (ctx) => StaffProvider()),
        ChangeNotifierProvider(create: (ctx) => ResearchProvider()),
        ChangeNotifierProvider(create: (ctx) => PublicationProvider()),
        ChangeNotifierProvider(create: (ctx) => ResearchAreaProvider()),
        ChangeNotifierProvider(create: (ctx) => EventProvider()),
        ChangeNotifierProvider(create: (ctx) => AchievementProvider()),
        ChangeNotifierProvider(create: (ctx) => AcademicProvider()),
        ChangeNotifierProvider(create: (ctx) => NoticeProvider()),
        ChangeNotifierProxyProvider<AuthProvider, RoutineProvider>(
          create: (ctx) => RoutineProvider(),
          update: (ctx, authProvider, previousRoutineProvider) =>
              RoutineProvider(
                  studentEmail: authProvider.getEmail,
                  token: authProvider.getToken),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'IIT 360',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: auth.getAuthStatus == true
              ? DashboardScreen()
              : FutureBuilder(
                  future: auth.onAutoLogin(),
                  builder: (ctx, snapshot) {
                    print(snapshot);
                    return snapshot.connectionState == ConnectionState.waiting
                        ? SplashScreen()
                        : AuthScreen();
                  }),
          routes: {
            AchievementScreen.routeName: (ctx) => AchievementScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            PreviousEventScreen.routeName: (ctx) => PreviousEventScreen(),
            FacultyScreen.routeName: (ctx) => FacultyScreen(),
            GeneralNoticeScreen.routeName: (ctx) => GeneralNoticeScreen(),
            GradNoticeScreen.routeName: (ctx) => GradNoticeScreen(),
            GraduateProgramScreen.routeName: (ctx) => GraduateProgramScreen(),
            HistoryScreen.routeName: (ctx) => HistoryScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            GuestHomeScreen.routeName: (ctx) => GuestHomeScreen(),
            InstitutionScreen.routeName: (ctx) => InstitutionScreen(),
            ObjectiveScreen.routeName: (ctx) => ObjectiveScreen(),
            ProjectNoticeScreen.routeName: (ctx) => ProjectNoticeScreen(),
            PublicationScreen.routeName: (ctx) => PublicationScreen(),
            ResearchAreaScreen.routeName: (ctx) => ResearchAreaScreen(),
            ResearchScreen.routeName: (ctx) => ResearchScreen(),
            SplashScreen.routeName: (ctx) => SplashScreen(),
            StaffScreen.routeName: (ctx) => StaffScreen(),
            TrainingNoticeScreen.routeName: (ctx) => TrainingNoticeScreen(),
            TrainingProgramScreen.routeName: (ctx) => TrainingProgramScreen(),
            UndergraduateNoticeScreen.routeName: (ctx) =>
                UndergraduateNoticeScreen(),
            UndergraduateProgramScreen.routeName: (ctx) =>
                UndergraduateProgramScreen(),
            UpcomingEventScreen.routeName: (ctx) => UpcomingEventScreen(),
            EditRoutineScreen.routeName: (ctx) => EditRoutineScreen(),
            CancelClassScreen.routeName: (ctx) => CancelClassScreen(),
            ExtraClassScreen.routeName: (ctx) => ExtraClassScreen(),
            RescheduleClassScreen.routeName: (ctx) => RescheduleClassScreen(),
            SwapClassScreen.routeName: (ctx) => SwapClassScreen(),
            EventReminderScreen.routeName: (ctx) => EventReminderScreen(),
          },
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
