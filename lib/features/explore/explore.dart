import 'package:clarity_mirror/features/explore/exp1.dart';
import 'package:clarity_mirror/features/explore/exp2.dart';
import 'package:clarity_mirror/features/explore/exp3.dart';
import 'package:clarity_mirror/features/explore/exp4.dart';
import 'package:flutter/material.dart';

class ExploreHome extends StatefulWidget {
  const ExploreHome({super.key});

  @override
  State<ExploreHome> createState() => _ExploreHomeState();
}

class _ExploreHomeState extends State<ExploreHome>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Explore",
          style: TextStyle(fontSize: 25),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  hintText: "Search",
                  hintStyle: const TextStyle(fontSize: 20)),
            ),
          ),
          DefaultTabController(
            length: 5,
            initialIndex: 0,
            child: TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 4,
                indicatorColor: Colors.cyan,
                controller: tabController,
                tabs: [
                  Text("For You"),
                  Text("Following"),
                  Text("Live"),
                  Text("Trends"),
                  Text("Popular"),
                ]),
          ),
          Expanded(
            child: TabBarView(
              // physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              // clipBehavior: Clip.hardEdge,
              children: [
                ForYouTab(),
                FollowingTab(),
                LiveTab(),
                TrendsTab(),
                TrendsTab(),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
