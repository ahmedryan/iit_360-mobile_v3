import 'package:flutter/material.dart';
import 'package:iit_360/widgets/matlab_origin_latex_notice.dart';
import 'package:iit_360/widgets/mobile_application_notice.dart';
import 'package:iit_360/widgets/office_applications_notice.dart';
import 'package:iit_360/widgets/web_design_notice.dart';
import 'package:iit_360/widgets/web_programming_notice.dart';

class TrainingNoticeScreen extends StatefulWidget {
  static const routeName = 'training-notice';

  @override
  _TrainingNoticeScreenState createState() => _TrainingNoticeScreenState();
}

class _TrainingNoticeScreenState extends State<TrainingNoticeScreen>
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
            title: Text('General Notice'),
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
                WebDesignNotice(),
                WebProgrammingNotice(),
                OfficeApplicationNotice(),
                MatlabOriginLatexNotice(),
                MobileApplicationNotice(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
