import 'package:clarity_mirror/features/products/model/products_model.dart';
import 'package:clarity_mirror/features/products/product_details_page.dart';
import 'package:clarity_mirror/features/products/products_view_model.dart';
import 'package:clarity_mirror/utils/common_widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsMainPage extends StatefulWidget {
  ProductsMainPage({super.key});

  @override
  State<ProductsMainPage> createState() => _ProductsMainPageState();
}

class _ProductsMainPageState extends State<ProductsMainPage> {

  var dummyImage = "https://plus.unsplash.com/premium_photo-1677541205130-51e60e937318?q=80&w=480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

  var dummyImage2 = "https://images.pexels.com/photos/2533266/pexels-photo-2533266.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";

  var dummyImage3 = "https://img.freepik.com/free-photo/makeup-cosmetics-palette-brushes-white-background_1357-247.jpg?w=540&t=st=1718853597~exp=1718854197~hmac=eec34130f2e102de7e55e200f998b168f14a1f937351f44c04fb6c4368245929";

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
   await Provider.of<ProductsViewModel>(context, listen: false).getProductRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsViewModel>(builder: (context, productsViewModel, widget) {
      print('Products ${productsViewModel.productsModel?.productRecommendations?.length}');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Products for you'),
        ),
        body: productsViewModel.isLoading ? const ProgressIndicatorWidget() : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Other Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              _getProductsWidget(context,productsViewModel),
              // dummyGridView(context),
            ],
          ),
        ),
      );
    });
  }

  Widget _getProductsWidget(context, ProductsViewModel productsViewModel) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 18.0,
        crossAxisSpacing: 18.0,
        childAspectRatio: 0.55,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: productsViewModel.productsModel?.productRecommendations?.length, // total number of items
      itemBuilder: (context, index) {
        ProductRecommendation? productRecommendation = productsViewModel.productsModel?.productRecommendations?.elementAt(index);
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductDetailsPage()));
          },
          child: Column(
            children: [
              Container(
                  height: 120,
                  margin: const EdgeInsets.only(bottom: 10),
                  // color: Colors.red,
                  child: Image.network('$dummyImage3', height: 100, fit: BoxFit.cover,)
                  // child: productRecommendation?.productImageUrl != null ? Image.network('${productRecommendation?.productImageUrl}', height: 100, fit: BoxFit.cover,) : Image.network('$dummyImage3', height: 100, fit: BoxFit.cover,),
              ),
              Text(
                // 'N/A large product item name goes here',
                productRecommendation?.productName ?? 'N/A',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
