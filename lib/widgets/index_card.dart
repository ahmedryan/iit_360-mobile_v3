import 'package:flutter/material.dart';

class IndexCard extends StatelessWidget {
  final String title;
  final Color color;

  IndexCard({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Container(
            width: 180,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
