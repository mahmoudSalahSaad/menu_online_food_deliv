import 'package:flutter/material.dart';
import 'package:card_loading/card_loading.dart';

class BottomSheetLoading extends StatelessWidget {
  const BottomSheetLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.80,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        CardLoading(
                          height: 30,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          width: 100,
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        CardLoading(
                          height: 100,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        CardLoading(
                          height: 30,
                          width: 200,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
