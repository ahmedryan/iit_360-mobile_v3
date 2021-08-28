import 'package:flutter/material.dart';
import 'package:iit_360/providers/auth_provider.dart';
import 'package:iit_360/providers/routine_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Sunday
class SunRoutineScreen extends StatefulWidget {
  @override
  _SunRoutineScreenState createState() => _SunRoutineScreenState();
}

class _SunRoutineScreenState extends State<SunRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<RoutineProvider>(context, listen: false)
            .fetchAndSetWeekRoutine(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<RoutineProvider>(
              builder: (ctx, routineProvider, _) {
                return ListView.builder(
                  itemCount: routineProvider.sunRoutine.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  DateFormat.yMMMMEEEEd().format(routineProvider
                                      .sunRoutine[index].routineDate),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  '${routineProvider.sunRoutine[index].beginTime.toString().substring(0, 5)} '
                                  'to ${routineProvider.sunRoutine[index].endTime.toString().substring(0, 5)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider.sunRoutine[index].courseCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider
                                      .sunRoutine[index].instructorCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class MonRoutineScreen extends StatefulWidget {
  @override
  _MonRoutineScreenState createState() => _MonRoutineScreenState();
}

class _MonRoutineScreenState extends State<MonRoutineScreen> {
  var crStatus = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      // trigger change
      crStatus = Provider.of<AuthProvider>(context, listen: false).crStatus;
      print(crStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<RoutineProvider>(context, listen: false)
            .fetchAndSetWeekRoutine(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<RoutineProvider>(
              builder: (ctx, routineProvider, _) {
                return ListView.builder(
                  itemCount: routineProvider.monRoutine.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  DateFormat.yMMMMEEEEd().format(routineProvider
                                      .monRoutine[index].routineDate),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  '${routineProvider.monRoutine[index].beginTime.toString().substring(0, 5)} '
                                  'to ${routineProvider.monRoutine[index].endTime.toString().substring(0, 5)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider.monRoutine[index].courseCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                    routineProvider
                                        .monRoutine[index].instructorCode
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.deepPurple)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ThuRoutineScreen extends StatefulWidget {
  @override
  _ThuRoutineScreenState createState() => _ThuRoutineScreenState();
}

class _ThuRoutineScreenState extends State<ThuRoutineScreen> {
  var crStatus = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      // trigger change
      crStatus = Provider.of<AuthProvider>(context, listen: false).crStatus;
      print(crStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<RoutineProvider>(context, listen: false)
            .fetchAndSetWeekRoutine(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<RoutineProvider>(
              builder: (ctx, routineProvider, _) {
                return ListView.builder(
                  itemCount: routineProvider.thuRoutine.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  DateFormat.yMMMMEEEEd().format(routineProvider
                                      .thuRoutine[index].routineDate),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  '${routineProvider.thuRoutine[index].beginTime.toString().substring(0, 5)} '
                                  'to ${routineProvider.thuRoutine[index].endTime.toString().substring(0, 5)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider.thuRoutine[index].courseCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider
                                      .thuRoutine[index].instructorCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class WedRoutineScreen extends StatefulWidget {
  @override
  _WedRoutineScreenState createState() => _WedRoutineScreenState();
}

class _WedRoutineScreenState extends State<WedRoutineScreen> {
  var crStatus = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      // trigger change
      crStatus = Provider.of<AuthProvider>(context, listen: false).crStatus;
      print(crStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<RoutineProvider>(context, listen: false)
            .fetchAndSetWeekRoutine(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<RoutineProvider>(
              builder: (ctx, routineProvider, _) {
                return ListView.builder(
                  itemCount: routineProvider.wedRoutine.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  DateFormat.yMMMMEEEEd().format(routineProvider
                                      .wedRoutine[index].routineDate),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  '${routineProvider.wedRoutine[index].beginTime.toString().substring(0, 5)} '
                                  'to ${routineProvider.wedRoutine[index].endTime.toString().substring(0, 5)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider.wedRoutine[index].courseCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider
                                      .wedRoutine[index].instructorCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class TueRoutineScreen extends StatefulWidget {
  @override
  _TueRoutineScreenState createState() => _TueRoutineScreenState();
}

class _TueRoutineScreenState extends State<TueRoutineScreen> {
  var crStatus = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      // trigger change
      crStatus = Provider.of<AuthProvider>(context, listen: false).crStatus;
      print(crStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<RoutineProvider>(context, listen: false)
            .fetchAndSetWeekRoutine(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<RoutineProvider>(
              builder: (ctx, routineProvider, _) {
                return ListView.builder(
                  itemCount: routineProvider.tueRoutine.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  DateFormat.yMMMMEEEEd().format(routineProvider
                                      .tueRoutine[index].routineDate),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  '${routineProvider.tueRoutine[index].beginTime.toString().substring(0, 5)} '
                                  'to ${routineProvider.tueRoutine[index].endTime.toString().substring(0, 5)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider.tueRoutine[index].courseCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider
                                      .tueRoutine[index].instructorCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class FriRoutineScreen extends StatefulWidget {
  @override
  _FriRoutineScreenState createState() => _FriRoutineScreenState();
}

class _FriRoutineScreenState extends State<FriRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<RoutineProvider>(context, listen: false)
            .fetchAndSetWeekRoutine(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<RoutineProvider>(
              builder: (ctx, routineProvider, _) {
                return ListView.builder(
                  itemCount: routineProvider.friRoutine.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  DateFormat.yMMMMEEEEd().format(routineProvider
                                      .friRoutine[index].routineDate),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  '${routineProvider.friRoutine[index].beginTime.toString().substring(0, 5)} '
                                  'to ${routineProvider.friRoutine[index].endTime.toString().substring(0, 5)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider.friRoutine[index].courseCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider
                                      .friRoutine[index].instructorCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class SatRoutineScreen extends StatefulWidget {
  @override
  _SatRoutineScreenState createState() => _SatRoutineScreenState();
}

class _SatRoutineScreenState extends State<SatRoutineScreen> {
  var crStatus = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      // trigger change
      crStatus = Provider.of<AuthProvider>(context, listen: false).crStatus;
      print(crStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<RoutineProvider>(context, listen: false)
            .fetchAndSetWeekRoutine(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<RoutineProvider>(
              builder: (ctx, routineProvider, _) {
                return ListView.builder(
                  itemCount: routineProvider.satRoutine.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  DateFormat.yMMMMEEEEd().format(routineProvider
                                      .satRoutine[index].routineDate),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  '${routineProvider.satRoutine[index].beginTime.toString().substring(0, 5)} '
                                  'to ${routineProvider.satRoutine[index].endTime.toString().substring(0, 5)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider.satRoutine[index].courseCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Text(
                                  routineProvider
                                      .satRoutine[index].instructorCode
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
