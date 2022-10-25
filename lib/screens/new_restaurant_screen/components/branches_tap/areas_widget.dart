import 'package:flutter/material.dart';

class AreasWidget extends StatelessWidget {
  const AreasWidget({
    Key key,
    @required this.areas,
  }) : super(key: key);

  final List<String> areas;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, index) {
        return areas.length > 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Text(areas[index])],
              )
            : Center(child: Text('لايوجد مناطق'));
      }, childCount: areas.length),
    );
  }
}
