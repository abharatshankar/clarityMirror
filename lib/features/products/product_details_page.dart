import 'package:clarity_mirror/features/products/model/products_model.dart';
import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view/custom_appbar.dart';

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
    _tabController = TabController(length: 4, vsync: this);
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
        floatingActionButton: addToCartButtonWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            const CustomAppBar(
              titleTxt: "Product Details",
              showNotificationIcon: false,
            ),

            const SizedBox(height: 10,),
            /// Product image
            widget.product?.productImageUrl != null ? Container(
              height: 180.h,
              margin: const EdgeInsets.only(bottom: 10),
              child: Image.network(
                  widget.product?.productImageUrl ?? '',
                // height: 90,
                fit: BoxFit.cover,
              )
            ) : Container(),

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
                    "Ingratients",
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
                    getContentWidget(content: widget.product?.description),
                    getContentWidget(content: widget.product?.ingredients),
                    getContentWidget(content: widget.product?.usageInfo),
                    getContentWidget(content: widget.product?.localizationInfo),
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
  
  Widget getContentWidget({@ required String? content}) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.only(bottom: 80, left: 16, right: 16, top: 16),
          child: Text(content ?? 'N/A'),
      ),
    );
  }
}
