import 'package:flutter/material.dart';
import 'package:iit_360/services/service_google_calendar_api.dart';
import 'package:intl/intl.dart';

class EventReminderScreen extends StatefulWidget {
  static const routeName = '/event-reminder';

  @override
  _EventReminderScreenState createState() => _EventReminderScreenState();
}

class _EventReminderScreenState extends State<EventReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime eventDate = DateTime.now();
  TimeOfDay eventTime = TimeOfDay.now();
  String title = '';
  int reminder = 0;

  _pickDate(ctx) async {
    DateTime? date = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 4)),
      context: ctx,
    );
    if (date != null) {
      setState(() {
        eventDate = date;
      });
    }
  }

  _pickBeginTime(ctx) async {
    TimeOfDay? time =
        await showTimePicker(context: ctx, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        eventTime = time;
      });
    }
  }

  _submit() {
    DateTime dateTime = DateTime(eventDate.year, eventDate.month, eventDate.day,
        eventTime.hour, eventTime.minute);
    GoogleCalendarService().addEvent(title, reminder, dateTime).then((value) {
      return showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Event Successful!'),
          content: Text('Event reminder added to google calendar!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }).catchError((onError) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  initialValue: title,
                  keyboardType: TextInputType.text,
                  onChanged: (val) {
                    title = val;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter title here",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 4.0),
              //   child: TextFormField(
              //     keyboardType: TextInputType.number,
              //     onChanged: (val) {
              //       reminder = int.parse(val);
              //     },
              //     decoration: InputDecoration(
              //       hintText: "Enter reminder minutes",
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10.0)),
              //     ),
              //   ),
              // ),
              ListTile(
                title: Text(
                  DateFormat.jm().format(
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day, eventTime.hour, eventTime.minute),
                  ),
                ),
                subtitle: Text('Event Time'),
                trailing: Icon(Icons.timer),
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
                  DateFormat.yMMMMEEEEd().format(eventDate),
                ),
                subtitle: Text('Class Date'),
                trailing: Icon(Icons.date_range),
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
                      child: Text('Add Reminder'),
                      onPressed: _submit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
