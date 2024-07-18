import 'package:flutter/material.dart';

class LiveTab extends StatelessWidget {
  const LiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 40,
              mainAxisSpacing: 40),
          itemCount: 7,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4Q8Oln3CJXbyAfQDV-yyuQBdnCHdfUDxq6Q&s",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNFvwbcNnWcurXaQBuEGIkkIhylDWQgwO_kg&s",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Row(
                    children: [
                      Text(
                        index < 3 ? "Live" : "Was live",
                        style: TextStyle(
                            color:index < 3 ? Colors.red : Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
                      ),
                       Icon(
                        Icons.radio_button_checked,
                        color: index < 3 ? Colors.red : Colors.white,
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
