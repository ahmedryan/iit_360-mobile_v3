import 'package:flutter/material.dart';
import 'package:iit_360/widgets/index_card.dart';

import 'content_card.dart';

class Content extends StatelessWidget {
  final indexDetails;
  final itemList;

  Content({@required this.indexDetails, @required this.itemList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          IndexCard(
            title: indexDetails['title'],
            color: indexDetails['color'],
          ),
          ...itemList
              .map<Widget>(
                (item) => ContentCard(
                  title: item['title'],
                  imagePath: item['image'],
                  nextPage: item['route'],
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
