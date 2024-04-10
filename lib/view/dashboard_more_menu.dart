import 'package:clarity_mirror/utils/app_strings.dart';
import 'package:flutter/material.dart';

class DashboardMoreMenu extends StatelessWidget {
   const DashboardMoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: GridView.builder(
          itemCount: AppStrings.dashbordMoreMenuItems.length,
          
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            crossAxisSpacing: 6.0, // Optional spacing between columns
            mainAxisSpacing: 3.0, // Optional spacing between rows
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                
              },
              child: GridTile(
                child: SizedBox(
                  height: 100,
                  width: 80,
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: AssetImage('assets/images/${AppStrings.dashbordMoreMenuItems[index]}.png',),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        AppStrings.dashbordMoreMenuItems[index],
                        textAlign: TextAlign.center,
                        style:const TextStyle(fontSize: 12,height:1,color: Colors.white,letterSpacing: 0,wordSpacing: 0,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      
        ),
          
      ],
    ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String itemName;
  final ImageProvider itemImage;

  GridItem({required this.itemName, required this.itemImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 120,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              image: DecorationImage(
                image: itemImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5), // Optional spacing between image and text
          Text(
            itemName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14,color: Colors.white),
          ),
        ],
      ),
    );
  }
}