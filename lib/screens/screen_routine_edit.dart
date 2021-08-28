import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iit_360/screens/screen_class_cancel.dart';
import 'package:iit_360/screens/screen_class_extra.dart';
import 'package:iit_360/screens/screen_class_reschedule.dart';
import 'package:iit_360/screens/screen_class_swap.dart';

class EditRoutineScreen extends StatefulWidget {
  static const routeName = '/edit-routine-screen';

  @override
  _EditRoutineScreenState createState() => _EditRoutineScreenState();
}

class _EditRoutineScreenState extends State<EditRoutineScreen> {
  RoutineGridItem item1 = new RoutineGridItem(
    title: 'Cancel Class',
    subtitle:
        'It is natural that some classes will be cancelled in every semester',
    event: '',
    img: '',
    route: CancelClassScreen.routeName,
  );
  RoutineGridItem item2 = new RoutineGridItem(
    title: 'Extra Class',
    subtitle:
        'The classes missed should be covered up or else it is negligience to responsibility',
    event: '',
    img: '',
    route: ExtraClassScreen.routeName,
  );
  RoutineGridItem item3 = new RoutineGridItem(
    title: 'Reschedule Class',
    subtitle:
        'Do reschedule some classes sometimes to give a break to your teachers',
    event: '',
    img: '',
    route: RescheduleClassScreen.routeName,
  );
  RoutineGridItem item4 = new RoutineGridItem(
    title: 'Swap Class',
    subtitle:
        'Classes are often swapped by an agreement between multiple teachers',
    event: '',
    img: '',
    route: SwapClassScreen.routeName,
  );

  @override
  Widget build(BuildContext context) {
    List<RoutineGridItem> gridItems = [
      item1,
      item2,
      item3,
      item4,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Routine',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello CR, change the routine!',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      'I will notify everyone, no worries!',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.event),
                  iconSize: 50,
                  alignment: Alignment.topCenter,
                  color: Colors.white54,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: gridItems
                  .map(
                    (item) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(item.route);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_busy,
                              size: 42,
                              color: Colors.white70,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              item.title,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              item.subtitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              item.event,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class RoutineGridItem {
  String title;
  String subtitle;
  String event;
  String img;
  String route;

  RoutineGridItem({
    required this.title,
    required this.subtitle,
    required this.event,
    required this.img,
    required this.route,
  });
}
