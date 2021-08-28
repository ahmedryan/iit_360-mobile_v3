import 'package:flutter/material.dart';
import 'package:iit_360/widgets/registrar_office_notice.dart';
import 'package:iit_360/widgets/scholarship_notice.dart';

class GeneralNoticeScreen extends StatefulWidget {
  static const routeName = '/general-notice';

  @override
  _GeneralNoticeScreenState createState() => _GeneralNoticeScreenState();
}

class _GeneralNoticeScreenState extends State<GeneralNoticeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                Tab(text: 'Scholarship'),
                Tab(text: 'Registrar Office'),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                ScholarshipNoticeScreen(),
                RegistrarOfficeNotice(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
