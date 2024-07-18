import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class TrendsTab extends StatelessWidget {
  const TrendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              height: 40,
                              width: 40,
                              child: ClipOval(
                                  child: Image.network(
                                "https://images.pexels.com/photos/1386604/pexels-photo-1386604.jpeg",
                                fit: BoxFit.fill,
                              )),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    "Lisa Marthey",
                                    style: AppFonts().sego12bold,
                                  ),
                                ),
                                Text(
                                  "Beauty Vlogger",
                                  style: AppFonts().sego10normal,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '20 sec ago',
                          style: AppFonts().sego10normal,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Image.network(
                      'https://images.pexels.com/photos/1386604/pexels-photo-1386604.jpeg',
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                                size: 30,
                              ),
                              Icon(
                                Icons.chat_bubble_outline_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.grey,
                                size: 30,
                              )
                            ],
                          ),
                          Icon(
                            Icons.bookmark_outline,
                            color: Colors.grey,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                    Text(
                      'Beauty obviously, this is a complex, Beauty obviously, this is a complex Beauty obviously, this is a complex Beauty obviously, this is a complex Beauty obviously, this is a complex',
                      style: AppFonts().sego12normal,
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
