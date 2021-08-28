import 'package:flutter/material.dart';
import 'package:iit_360/widgets/project_notice.dart';

class ProjectNoticeScreen extends StatefulWidget {
  static const routeName = '/project-notice';

  @override
  _ProjectNoticeScreenState createState() => _ProjectNoticeScreenState();
}

class _ProjectNoticeScreenState extends State<ProjectNoticeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('General Notice'),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 160.0,
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Project'),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                ProjectNotice(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
