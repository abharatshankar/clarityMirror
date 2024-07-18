import 'package:flutter/material.dart';

class FollowingTab extends StatelessWidget {
  const FollowingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRAD8gxQIbLzQ1u0SLj7hAyBj_gcF_I5ACXQ&s",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.175,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlzN2_1B-s2KBH37BS3IaCI5wagX9Do5Ljhw&s",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 5),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 40),
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlzN2_1B-s2KBH37BS3IaCI5wagX9Do5Ljhw&s",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: Image.network(
                              "https://images.pexels.com/photos/2787341/pexels-photo-2787341.jpeg?cs=srgb&dl=pexels-alipazani-2787341.jpg&fm=jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMJAywEkdpLvHu6ztPssW4Znd7i2EEGfYEhQ&s",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4Q8Oln3CJXbyAfQDV-yyuQBdnCHdfUDxq6Q&s",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
