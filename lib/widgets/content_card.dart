import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String nextPage;

  ContentCard(
      {required this.title, required this.imagePath, required this.nextPage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(nextPage);
      },
      child: Card(
        child: Container(
          width: 180,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  imagePath,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 210,
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
                    height: 205,
                  ),
                  Container(
                    height: 65,
                    child: Material(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
