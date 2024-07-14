import 'package:clarity_mirror/features/products/model/products_model.dart';
import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/features/cart/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'product_certifications.dart';
import 'product_reviews.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  /// Product object passed from the product's selection
  final ProductRecommendation? product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final pageController = PageController();
  int pagedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Details"),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                size: 28,
              ),
              onPressed: () {},
            ),
          ],
        ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            /// Product image
            widget.product?.productImageUrl != null
                ? Container(
                    height: 180.h,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Image.network(
                      widget.product?.productImageUrl ?? '',
                      // height: 90,
                      fit: BoxFit.cover,
                    ))
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product?.productName ?? '',
                style: AppFonts().sego18normal,
              ),
            ),
            Text(
              "\$${widget.product?.productPrice ?? ''}",
              style: AppFonts().sego18normal,
            ),
            TabBar(
              controller: _tabController,
              labelColor: AppConstColors.appThemeCayan,
              indicatorColor: AppConstColors.appThemeCayan,
              indicatorSize: TabBarIndicatorSize.label,
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Text(
                    "Description",
                    style: AppFonts().sego12bold,
                  ),
                ),
                Tab(
                  child: Text(
                    "Ingredients",
                    style: AppFonts().sego12bold,
                  ),
                ),
                Tab(
                  child: Text(
                    "How to use",
                    style: AppFonts().sego12bold,
                  ),
                ),
                Tab(
                  child: Text(
                    "Certifications",
                    style: AppFonts().sego12bold,
                  ),
                ),
                Tab(
                  child: Text(
                    "Reviews",
                    style: AppFonts().sego12bold,
                  ),
                ),
              ],
            ),

            Expanded(
              child: TabBarView(
                  physics: const ClampingScrollPhysics(),
                  controller: _tabController,
                  children: [
                    GestureDetector(
                      onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>CartList()));
            },
                      child: getContentWidget(content: widget.product?.description)),
                    GestureDetector(
                      onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>CartList()));
            },
                      child: getContentWidget(content: widget.product?.ingredients)),
                    GestureDetector(
                      onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>CartList()));
            },
                      child: getContentWidget(content: widget.product?.usageInfo)),
                    //certifications
                    ProductCertifications(),
                    //reviews
                    ProductReviews(),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  /// Add to cart button widget
  Widget addToCartButtonWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.cyanAccent,
        ),
        width: double.infinity,
        height: 50,
        child: Center(
            child: Text(
          "Add to cart",
          style: AppFonts().sego14bold.copyWith(color: Colors.white),
        )),
      ),
    );
  }

  Widget getContentWidget({@required String? content}) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(top:15,left:15,right:15,child: SizedBox(width: MediaQuery.of(context).size.width,child: Text(content ?? 'N/A'))),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.cyan),
              child: const Center(
                child: Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
