import 'package:flutter/material.dart';

class TrendsTab extends StatelessWidget {
  const TrendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        leading: const Icon(Icons.arrow_back_rounded),
        actions: const [
           Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.notifications_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      // border: Border.all(width: 2, color: Colors.white)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        "https://images.pexels.com/photos/1386604/pexels-photo-1386604.jpeg",
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Lisa Marthay",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Beauty Vlogger",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.47),
                        const Text(
                          "20 sec ago",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w100),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                child: Image.network(
                  "https://images.pexels.com/photos/1386604/pexels-photo-1386604.jpeg",
                  // height: MediaQuery.of(context).size.height * 0.2,
                  // width: MediaQuery.of(context).size.width * 0.2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(Icons.heart_broken_outlined),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(Icons.message),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(Icons.telegram),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(Icons.bookmark_border),
                )
              ],
            ),
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Beauty Obviously,this is a complex. One of the reasons that some people and bussiness suceed online is because of the quality of their social posts.they don't post soley to promote their products.",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
