import 'package:flutter/material.dart';

class ForYouTab extends StatelessWidget {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 40,
              crossAxisSpacing: 40,
              childAspectRatio: 0.75),
          itemCount: 7,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4Q8Oln3CJXbyAfQDV-yyuQBdnCHdfUDxq6Q&s",
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
