import 'package:flutter/material.dart';

import 'model/subscriber_model.dart';

class ProductReviews extends StatefulWidget {
  const ProductReviews({super.key});

  @override
  State<ProductReviews> createState() => _ProductReviewsState();
}

class _ProductReviewsState extends State<ProductReviews> {
  List<SubscriberModel> subscribeModel = [
    SubscriberModel(
        "assets/images/Dermatolgist6.png",
        "Kishore",
        "This is a smaple review of some user .Lorem ipsum dolar sit amet,consecture adipicsing elit,sed do eisumod tempour",
        3),
    SubscriberModel(
        "assets/images/Dermatolgist6.png",
        "Bharat",
        "This is a smaple review of some user .Lorem ipsum dolar sit amet,consecture adipicsing elit,sed do eisumod tempour",
        3),
    SubscriberModel(
        "assets/images/Dermatolgist6.png",
        "Susmitha",
        "This is a smaple review of some user .Lorem ipsum dolar sit amet,consecture adipicsing elit,sed do eisumod tempour",
        5),
    SubscriberModel(
        "assets/images/Dermatolgist6.png",
        "Kishore",
        "This is a smaple review of some user .Lorem ipsum dolar sit amet,consecture adipicsing elit,sed do eisumod tempour",
        3),
    SubscriberModel(
        "assets/images/Dermatolgist6.png",
        "Bharat",
        "This is a smaple review of some user .Lorem ipsum dolar sit amet,consecture adipicsing elit,sed do eisumod tempour",
        3),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ListView.builder(physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: subscribeModel.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            subscribeModel[index].image,
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.14,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  subscribeModel[index].name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                    children: starRatingWidget(
                                        subscribeModel[index].rating))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text(
                              subscribeModel[index].description,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.cyan),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text(
                "Give Review",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> starRatingWidget(int numOfStars) {
    return List.generate(5, (stars) {
      return Icon(
        stars < numOfStars ? Icons.star : Icons.star_border,
        color: Colors.amber,
      );
    });
  }
}
