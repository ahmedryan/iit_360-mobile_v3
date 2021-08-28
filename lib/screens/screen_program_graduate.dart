import 'package:flutter/material.dart';
import 'package:iit_360/widgets/mit_program.dart';
import 'package:iit_360/widgets/msse_program.dart';
import 'package:iit_360/widgets/pgdit_program.dart';

class GraduateProgramScreen extends StatefulWidget {
  static const routeName = 'grad';

  @override
  _GraduateProgramScreenState createState() => _GraduateProgramScreenState();
}

class _GraduateProgramScreenState extends State<GraduateProgramScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Graduate Studies'),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 160.0,
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'MSSE'),
                Tab(text: 'MIT'),
                Tab(text: 'PGDIT'),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                MsseProgram(),
                MitProgram(),
                PgditProgram(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
