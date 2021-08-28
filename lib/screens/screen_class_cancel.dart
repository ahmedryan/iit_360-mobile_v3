import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iit_360/providers/routine_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CancelClassScreen extends StatefulWidget {
  static const routeName = '/cancel-class';

  @override
  _CancelClassScreenState createState() => _CancelClassScreenState();
}

class _CancelClassScreenState extends State<CancelClassScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  String? _courseCode;
  bool _courseCodeError = false;
  DateTime _classDate = DateTime.now();

  _reset() {
    setState(() {
      _courseCode = null;
      _courseCodeError = false;
    });
  }

  _submit() {
    if (_courseCode == null) {
      setState(() {
        _courseCodeError = true;
      });
      return;
    }
    _courseCodeError = false;

    var modifiedCourseCode = _courseCode!;
    var modifiedClassDate = _classDate.toIso8601String().substring(0, 10);

    setState(() {
      _isLoading = true;
    });

    Provider.of<RoutineProvider>(context, listen: false)
        .cancelClass(modifiedCourseCode, modifiedClassDate)
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
              ? Text('Class Cancelled Successfully!')
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Class'),
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
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                          child: Text(value),
                                          value: value,
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
                                ListTile(
                                  title: Text(DateFormat.yMMMMEEEEd()
                                      .format(_classDate)),
                                  trailing: Icon(
                                    Icons.date_range,
                                    color: Colors.deepPurple,
                                  ),
                                  onTap: () {
                                    _pickDate(context);
                                  },
                                ),
                                Divider(
                                  thickness: 2.0,
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
                                        child: Text('Cancel Class'),
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
