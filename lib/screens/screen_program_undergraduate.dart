import 'package:flutter/material.dart';
import 'package:iit_360/widgets/bsse_program.dart';

class UndergraduateProgramScreen extends StatefulWidget {
  static const routeName = '/undergrad';

  @override
  _UndergraduateProgramScreenState createState() =>
      _UndergraduateProgramScreenState();
}

class _UndergraduateProgramScreenState extends State<UndergraduateProgramScreen>
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
            title: Text('Undergraduate Studies'),
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
                BsseProgram(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
