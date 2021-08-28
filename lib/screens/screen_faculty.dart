import 'package:flutter/material.dart';
import 'package:iit_360/providers/faculty_provider.dart';
import 'package:provider/provider.dart';

class FacultyScreen extends StatefulWidget {
  static const routeName = '/faculty';

  @override
  _FacultyScreenState createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Faculty'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<FacultyProvider>(context, listen: false)
              .fetchAndSetFaculties(),
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
              return Consumer<FacultyProvider>(
                builder: (ctx, facultyProvider, _) {
                  return GridView.builder(
                    itemCount: facultyProvider.faculties!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          child: Container(
                            width: 180,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                    width: 190,
                                    height: 190,
                                    child: Image.network(
                                      facultyProvider
                                          .faculties![index].facultyImageUrl
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 128,
                                    ),
                                    Container(
                                      height: 60,
                                      width: double.infinity,
                                      color: Colors.black45.withOpacity(0.5),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 128,
                                    ),
                                    Container(
                                      height: 60,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            clipBehavior: Clip.antiAlias,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 0, 0, 0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  facultyProvider
                                                      .faculties![index]
                                                      .facultyName
                                                      .toString(),
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            clipBehavior: Clip.antiAlias,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8.0, 0, 0, 0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  facultyProvider
                                                      .faculties![index]
                                                      .designation
                                                      .toString(),
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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

// Card(
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: Image.network(facultyProvider
//     .faculties![index].facultyImageUrl
//     .toString()),
// ),
// Text(
// facultyProvider.faculties![index].facultyName
//     .toString(),
// textAlign: TextAlign.center,
// ),
// Text(
// facultyProvider.faculties![index].designation
//     .toString(),
// textAlign: TextAlign.center,
// ),
// ],
// ),
// ),
// )
