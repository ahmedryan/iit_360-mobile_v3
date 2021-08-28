import 'package:flutter/material.dart';
import 'package:iit_360/widgets/bsse_notice.dart';

class UndergraduateNoticeScreen extends StatefulWidget {
  static const routeName = '/undergrad-notice';

  @override
  _UndergraduateNoticeScreenState createState() =>
      _UndergraduateNoticeScreenState();
}

class _UndergraduateNoticeScreenState extends State<UndergraduateNoticeScreen>
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
            title: Text('Project Notice'),
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 160.0,
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'BSSE'),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                BsseNotice(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
