import 'package:flutter/material.dart';
import 'package:iit_360/providers/instructor_provider.dart';
import 'package:iit_360/providers/routine_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExtraClassScreen extends StatefulWidget {
  static const routeName = '/extra-class';

  @override
  _ExtraClassScreenState createState() => _ExtraClassScreenState();
}

class _ExtraClassScreenState extends State<ExtraClassScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  String? _courseCode;
  bool _courseCodeError = false;
  String? _instructorCode;
  bool _instructorCodeError = false;
  TimeOfDay _beginTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  bool _endTimeError = false;
  DateTime _classDate = DateTime.now();

  _reset() {
    setState(() {
      _courseCode = null;
      _courseCodeError = false;
      _instructorCode = null;
      _instructorCodeError = false;
      _endTimeError = false;
    });
  }

  _timeToDouble(TimeOfDay t) {
    return t.hour * 60 + t.minute;
  }

  _submit() {
    if (_courseCode == null || _instructorCode == null) {
      setState(() {
        _courseCodeError = _courseCode == null ? true : false;
        _instructorCodeError = _instructorCode == null ? true : false;
      });
      return;
    }
    if (_timeToDouble(_beginTime) > _timeToDouble(_endTime)) {
      return showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('End time can not be less than begin time!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }

    _courseCodeError = false;
    _instructorCodeError = false;
    _endTimeError = false;

    // var modifiedCourseCode = _courseCode!.replaceAll(' ', '%20');
    var modifiedCourseCode = _courseCode!;
    var modifiedInstructorCode = _instructorCode!;
    // var modifiedInstructorCode = _instructorCode!.replaceAll(' ', '%20');
    var modifiedClassDate = _classDate.toIso8601String().substring(0, 10);
    // var modifiedDayName = DateFormat('EEEE').format(_classDate).substring(0, 3);
    var modifiedBeginTime = _beginTime.toString().substring(10, 15);
    var modifiedEndTime = _endTime.toString().substring(10, 15);

    setState(() {
      _isLoading = true;
    });

    Provider.of<RoutineProvider>(context, listen: false)
        .extraClass(modifiedCourseCode, modifiedClassDate, modifiedBeginTime,
            modifiedEndTime, modifiedInstructorCode)
        .catchError((err) {
      return showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }).then((_) {
      final status = Provider.of<RoutineProvider>(context, listen: false)
          .requestStatusCode;
      setState(() {
        _isLoading = false;
      });
      return showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: status == 200 ? Text('Hurray!') : Text('Oops!'),
          content: status == 200
              ? Text('Extra class added Successfully!')
              : Text('It seems you provided wrong information!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                if (status == 200) {
                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pop();
                }
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    });
  }

  _pickDate(ctx) async {
    DateTime? date = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 4)),
      context: ctx,
    );
    if (date != null) {
      setState(() {
        _classDate = date;
      });
    }
  }

  _pickBeginTime(ctx) async {
    TimeOfDay? time =
        await showTimePicker(context: ctx, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        _beginTime = time;
      });
    }
  }

  _pickEndTime(ctx) async {
    TimeOfDay? time =
        await showTimePicker(context: ctx, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        _endTime = time;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<InstructorProvider>(context, listen: false)
        .fetchAndSetInstructors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Class'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: FutureBuilder(
                future: Provider.of<RoutineProvider>(context, listen: false)
                    .fetchAndSetCourses(),
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
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              children: [
                                DropdownButtonFormField(
                                  value: _courseCode,
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text('Course Code'),
                                  ),
                                  items: routineProvider.courses!
                                      .map(
                                        (String element) =>
                                            DropdownMenuItem<String>(
                                          child: Text(element),
                                          value: element,
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      _courseCode = value.toString();
                                      _courseCodeError = false;
                                    });
                                  },
                                ),
                                _courseCodeError
                                    ? Text(
                                        'Select a course code',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : SizedBox.shrink(),
                                DropdownButtonFormField(
                                  value: _instructorCode,
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text('Instructor Name'),
                                  ),
                                  items:
                                      Provider.of<InstructorProvider>(context)
                                          .instructors!
                                          .map(
                                            (element) =>
                                                DropdownMenuItem<String>(
                                              child: Text(element.instructorName
                                                  .toString()),
                                              value: element.instructorId,
                                            ),
                                          )
                                          .toList(),
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      _instructorCode = value.toString();
                                      _instructorCodeError = false;
                                    });
                                  },
                                ),
                                _instructorCodeError
                                    ? Text(
                                        'Select an instructor',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : SizedBox.shrink(),
                                ListTile(
                                  title: Text(
                                    DateFormat.jm().format(
                                      DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day,
                                          _beginTime.hour,
                                          _beginTime.minute),
                                    ),
                                  ),
                                  subtitle: Text('Begin Time'),
                                  trailing: Icon(
                                    Icons.timer,
                                    color: Colors.deepPurple,
                                  ),
                                  onTap: () {
                                    _pickBeginTime(context);
                                  },
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: Colors.black45,
                                ),
                                ListTile(
                                  title: Text(
                                    DateFormat.jm().format(
                                      DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day,
                                          _endTime.hour,
                                          _endTime.minute),
                                    ),
                                  ),
                                  subtitle: Text('End Time'),
                                  trailing: Icon(
                                    Icons.timer,
                                    color: Colors.deepPurple,
                                  ),
                                  onTap: () {
                                    _pickEndTime(context);
                                  },
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: Colors.black45,
                                ),
                                ListTile(
                                  title: Text(
                                    DateFormat.yMMMMEEEEd().format(_classDate),
                                  ),
                                  subtitle: Text('Class Date'),
                                  trailing: Icon(
                                    Icons.date_range,
                                    color: Colors.deepPurple,
                                  ),
                                  onTap: () {
                                    _pickDate(context);
                                  },
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: Colors.black45,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      child: TextButton(
                                        child: Text('Reset'),
                                        onPressed: _reset,
                                      ),
                                    ),
                                    InkWell(
                                      child: TextButton(
                                        child: Text('Add Class'),
                                        onPressed: _submit,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
    );
  }
}
