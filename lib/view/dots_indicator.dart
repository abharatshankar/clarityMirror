import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({super.key, required this.pagedIndex});
final int pagedIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
              height: 25,
              width: 80,
              child: Center(                                        //
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == pagedIndex
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.2)),                   //
                        ),
                      );
                    }),
              ),
            );
  }
}