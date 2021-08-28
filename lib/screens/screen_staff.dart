import 'package:flutter/material.dart';
import 'package:iit_360/providers/staff_provider.dart';
import 'package:provider/provider.dart';

class StaffScreen extends StatefulWidget {
  static const routeName = '/staff';

  @override
  _StaffScreenState createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Staff'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Provider.of<StaffProvider>(context, listen: false)
              .fetchAndSetStaffs(),
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
              return Consumer<StaffProvider>(
                builder: (ctx, staffProvider, _) {
                  return GridView.builder(
                    itemCount: staffProvider.staffs!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Image.network(staffProvider
                                      .staffs![index].staffImageUrl
                                      .toString()),
                                ),
                                Text(
                                  staffProvider.staffs![index].staffName
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  staffProvider.staffs![index].designation
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
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
