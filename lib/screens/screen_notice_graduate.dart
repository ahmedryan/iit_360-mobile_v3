import 'package:flutter/material.dart';
import 'package:iit_360/widgets/mit_notice.dart';
import 'package:iit_360/widgets/msse_notice.dart';
import 'package:iit_360/widgets/pgdit_notice.dart';

class GradNoticeScreen extends StatefulWidget {
  static const routeName = '/grad-notice';

  @override
  _GradNoticeScreenState createState() => _GradNoticeScreenState();
}

class _GradNoticeScreenState extends State<GradNoticeScreen>
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
            title: Text('General Notice'),
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
                MsseNotice(),
                MitNotice(),
                PgditNotice(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
