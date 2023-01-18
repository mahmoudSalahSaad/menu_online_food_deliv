import 'package:flutter/material.dart';
import 'package:card_loading/card_loading.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardLoading(
                          height: 100,
                          width: 100,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CardLoading(
                                  height: 20,
                                  width: 100,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CardLoading(
                                  height: 25,
                                  width: 25,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                CardLoading(
                                  height: 25,
                                  width: 25,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                CardLoading(
                                  height: 25,
                                  width: 25,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  margin: EdgeInsets.only(bottom: 10),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CardLoading(
                                  height: 25,
                                  width: 25,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CardLoading(
                                  height: 25,
                                  width: 25,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  margin: EdgeInsets.only(bottom: 10),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CardLoading(
                                  height: 25,
                                  width: 25,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  margin: EdgeInsets.only(bottom: 10),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CardLoading(
                          height: 40,
                          width: 80,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        CardLoading(
                          height: 40,
                          width: 80,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        CardLoading(
                          height: 40,
                          width: 80,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        CardLoading(
                          height: 40,
                          width: 80,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CardLoading(
                          height: 100,
                          width: 100,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardLoading(
                              height: 20,
                              width: 50,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              margin: EdgeInsets.only(bottom: 10),
                            ),
                            CardLoading(
                              height: 20,
                              width: 200,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              margin: EdgeInsets.only(bottom: 10),
                            ),
                            CardLoading(
                              height: 20,
                              width: 200,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              margin: EdgeInsets.only(bottom: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
                childCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
