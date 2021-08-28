import 'package:flutter/material.dart';
import 'package:iit_360/widgets/matlab_origin_latex_program.dart';
import 'package:iit_360/widgets/mobile_application_program.dart';
import 'package:iit_360/widgets/office_application_program.dart';
import 'package:iit_360/widgets/web_design_program.dart';
import 'package:iit_360/widgets/web_programming_program.dart';

class TrainingProgramScreen extends StatefulWidget {
  static const routeName = '/training';

  @override
  _TrainingProgramScreenState createState() => _TrainingProgramScreenState();
}

class _TrainingProgramScreenState extends State<TrainingProgramScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Training Program'),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 160.0,
            bottom: TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: [
                Tab(text: 'Web Design'),
                Tab(text: 'Web Programming'),
                Tab(text: 'Office Applications'),
                Tab(text: 'Matlab-Origin-Latex'),
                Tab(text: 'Mobile Application'),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                WebDesignProgram(),
                WebProgrammingProgram(),
                OfficeApplicationProgram(),
                MatlabOriginLatexProgram(),
                MobileApplicationProgram(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
