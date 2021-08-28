import 'package:flutter/material.dart';
import 'package:iit_360/screens/screen_home.dart';
import 'package:iit_360/screens/screen_routine_week.dart';
import 'package:iit_360/widgets/custom_drawer.dart';
import 'package:workmanager/workmanager.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  List _screens = [
    HomeScreen(),
    WeekRoutineScreen(),
    // AlarmScreen(),
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Workmanager().registerPeriodicTask(
      'WorkManagerTask1',
      'CheckRoutineUpdate',
      frequency: Duration(minutes: 15),
      existingWorkPolicy: ExistingWorkPolicy.replace,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
    // GoogleCalendarService().addEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        selectedItemColor: Colors.deepPurple,
        showUnselectedLabels: false,
        selectedFontSize: 15,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Routine',
            icon: Icon(Icons.assignment),
          ),
          // BottomNavigationBarItem(
          //   label: 'Alarm',
          //   icon: Icon(Icons.alarm),
          // ),
        ],
      ),
    );
  }
}
