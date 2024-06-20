import 'package:clarity_mirror/features/products/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductsMainPage extends StatelessWidget {
  ProductsMainPage({super.key});

  List items = [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
    'item6',
    'item7',
    'item8',
    'item9',
    'item10',
    'item11',
    'item12',
    'item13',
  ];

  var dummyImage = "https://plus.unsplash.com/premium_photo-1677541205130-51e60e937318?q=80&w=480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products for you'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recomended Products'),
            _getProductsWidget(context),
            // dummyGridView(context),
          ],
        ),
      ),
    );
  }

  Widget _getProductsWidget(context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 18.0,
        crossAxisSpacing: 18.0,
        childAspectRatio: 0.7,
      ),
      padding: const EdgeInsets.all(8.0), // padding around the grid
      itemCount: 20, // total number of items
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductDetailsPage()));
          },
          child: Container(
            // color: Colors.blue,
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: 110,
                      color: Colors.red,
                      child: Image.network('$dummyImage', height: 100, fit: BoxFit.cover,),
                  ),
                  Text(
                    'Item - $index',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
