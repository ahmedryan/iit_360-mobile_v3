import 'package:flutter/material.dart';
import 'package:iit_360/providers/auth_provider.dart';
import 'package:iit_360/providers/routine_provider.dart';
import 'package:iit_360/screens/screen_routine.dart';
import 'package:iit_360/screens/screen_routine_edit.dart';
import 'package:provider/provider.dart';

class WeekRoutineScreen extends StatefulWidget {
  const WeekRoutineScreen({Key? key}) : super(key: key);

  @override
  _WeekRoutineScreenState createState() => _WeekRoutineScreenState();
}

class _WeekRoutineScreenState extends State<WeekRoutineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<RoutineModel> routine;
  var crStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        length: 7, vsync: this, initialIndex: DateTime.now().weekday);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<RoutineProvider>(context, listen: false)
        .fetchAndSetWeekRoutine();
    routine = Provider.of<RoutineProvider>(context, listen: false).weekRoutine;
    crStatus = Provider.of<AuthProvider>(context, listen: false).crStatus;
    setState(() {
      //trigger change
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.deepPurple),
        title: Text(
          'Weekly Routine',
          style: TextStyle(color: Colors.deepPurple),
        ),
        actions: [
          if (crStatus)
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditRoutineScreen.routeName)
                    .then((value) => setState(() {}));
              },
              icon: const Icon(Icons.edit),
            ),
        ],
        bottom: TabBar(
          labelColor: Colors.deepPurple,
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(
              text: 'Sun',
            ),
            Tab(text: 'Mon'),
            Tab(text: 'Tue'),
            Tab(text: 'Wed'),
            Tab(text: 'Thu'),
            Tab(text: 'Fri'),
            Tab(text: 'Sat'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SunRoutineScreen(),
          MonRoutineScreen(),
          TueRoutineScreen(),
          WedRoutineScreen(),
          ThuRoutineScreen(),
          FriRoutineScreen(),
          SatRoutineScreen(),
        ],
      ),
    );
  }
}
