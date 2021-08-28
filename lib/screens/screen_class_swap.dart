import 'package:flutter/material.dart';
import 'package:iit_360/providers/routine_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SwapClassScreen extends StatefulWidget {
  static const routeName = '/swap-class';

  @override
  _SwapClassScreenState createState() => _SwapClassScreenState();
}

class _SwapClassScreenState extends State<SwapClassScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  String? _courseCode1;
  bool _courseCode1Error = false;
  String? _courseCode2;
  bool _courseCode2Error = false;
  DateTime _classDate1 = DateTime.now();
  DateTime _classDate2 = DateTime.now();

  _reset() {
    setState(() {
      _courseCode1 = null;
      _courseCode1Error = false;
      _courseCode2 = null;
      _courseCode2Error = false;
    });
  }

  _submit() {
    if (_courseCode1 == null || _courseCode2 == null) {
      setState(() {
        _courseCode1Error = _courseCode1 == null ? true : false;
        _courseCode2Error = _courseCode2 == null ? true : false;
      });
      return;
    }
    _courseCode1Error = false;
    _courseCode2Error = false;

    var modifiedCourseCode1 = _courseCode1!;
    var modifiedCourseCode2 = _courseCode2!;
    var modifiedClassDate1 = _classDate1.toIso8601String().substring(0, 10);
    var modifiedClassDate2 = _classDate2.toIso8601String().substring(0, 10);

    setState(() {
      _isLoading = true;
    });

    Provider.of<RoutineProvider>(context, listen: false)
        .swapClass(modifiedCourseCode1, modifiedCourseCode2, modifiedClassDate1,
            modifiedClassDate2)
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
              ? Text('Class swapped successfully!')
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

  _pickClassDate1(ctx) async {
    DateTime? date = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 4)),
      context: ctx,
    );
    if (date != null) {
      setState(() {
        _classDate1 = date;
      });
    }
  }

  _pickClassDate2(ctx) async {
    DateTime? date = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 4)),
      context: ctx,
    );
    if (date != null) {
      setState(() {
        _classDate2 = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swap Class'),
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
                                  value: _courseCode1, //
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text('Course Code 1'),
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
                                      _courseCode1 = value.toString();
                                      _courseCode1Error = false;
                                    });
                                  },
                                ),
                                _courseCode1Error
                                    ? Text(
                                        'Select a course code',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : SizedBox.shrink(),
                                DropdownButtonFormField(
                                  value: _courseCode2,
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text('Course Code 2'),
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
                                      _courseCode2 = value.toString();
                                      _courseCode2Error = false;
                                    });
                                  },
                                ),
                                _courseCode2Error
                                    ? Text(
                                        'Select a course code',
                                        style: TextStyle(color: Colors.red),
                                      )
                                    : SizedBox.shrink(),
                                ListTile(
                                  title: Text(
                                    DateFormat.yMMMMEEEEd().format(_classDate1),
                                  ),
                                  subtitle: Text('Class Date 1'),
                                  trailing: Icon(
                                    Icons.date_range,
                                    color: Colors.deepPurple,
                                  ),
                                  onTap: () {
                                    _pickClassDate1(context);
                                  },
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: Colors.black45,
                                ),
                                ListTile(
                                  title: Text(
                                    DateFormat.yMMMMEEEEd().format(_classDate2),
                                  ),
                                  subtitle: Text('Class Date 2'),
                                  trailing: Icon(
                                    Icons.date_range,
                                    color: Colors.deepPurple,
                                  ),
                                  onTap: () {
                                    _pickClassDate2(context);
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
                                        child: Text('Swap Class'),
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
