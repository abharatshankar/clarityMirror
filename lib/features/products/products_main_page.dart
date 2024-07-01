import 'package:clarity_mirror/features/products/model/products_model.dart';
import 'package:clarity_mirror/features/products/product_details_page.dart';
import 'package:clarity_mirror/features/products/products_view_model.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/utils/common_widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';

class ProductsMainPage extends StatefulWidget {
  ProductsMainPage({super.key});

  @override
  State<ProductsMainPage> createState() => _ProductsMainPageState();
}

class _ProductsMainPageState extends State<ProductsMainPage> {

  var dummyImage3 =
      "https://img.freepik.com/free-photo/makeup-cosmetics-palette-brushes-white-background_1357-247.jpg?w=540&t=st=1718853597~exp=1718854197~hmac=eec34130f2e102de7e55e200f998b168f14a1f937351f44c04fb6c4368245929";
  bool _isExpanded = false;

// List of choices
  final List<String> _choices = [
    'Wrinkles',
    'Acne',
    'Pigmentation',
    'Hyderation',
    'Texture',
    'Elaticity',
    'Redness',
    'Dark Circles'
  ];

  // Set to store selected choices
  Set<String> _selectedChoices = {'Wrinkles', 'Acne', 'Pigmentation'};

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<void> getProducts() async {
    await Provider.of<ProductsViewModel>(context, listen: false)
        .getProductRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsViewModel>(
        builder: (context, productsViewModel, widget) {
      // print('Products ${productsViewModel.productsModel?.productRecommendations?.length}');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Products for you'),
          actions: [
            IconButton(icon: const Icon(Icons.shopping_cart, size: 28,), onPressed: (){},),
          ],
        ),
        body: productsViewModel.isLoading
            ? const ProgressIndicatorWidget()
            : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [

                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      dense: true,
                      enabled: true,
                      initiallyExpanded: true,
                      trailing: (!_isExpanded) ? const SizedBox.shrink() : null,
                      onExpansionChanged: (value) {
                        _isExpanded = !_isExpanded;
                        setState(() {});
                      },
                      title: (!_isExpanded)
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Regimen for you',
                            style: AppFonts().sego18bold.copyWith(
                                color: (!_isExpanded)
                                    ? AppConstColors.appThemeCayan
                                    : AppConstColors.editProfileTxtColor),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      )
                          : Text(
                        'Regimen for you',
                        style: AppFonts().sego18bold.copyWith(
                          color: AppConstColors.appThemeCayan,
                        ),
                      ),
                      children: [
                        getSkinConcernFilterItems(),
                        const SizedBox(height: 10),
                        _getProductsWidget(context, productsViewModel),
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      dense: true,
                      enabled: true,
                      initiallyExpanded: true,
                      trailing: (!_isExpanded) ? const SizedBox.shrink() : null,
                      onExpansionChanged: (value) {
                        _isExpanded = !_isExpanded;
                        setState(() {});
                      },
                      title: (!_isExpanded)
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Other Products',
                            style: AppFonts().sego18bold.copyWith(
                                color: (!_isExpanded)
                                    ? AppConstColors.appThemeCayan
                                    : AppConstColors.editProfileTxtColor),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      )
                          : Text(
                        'Other Products',
                        style: AppFonts().sego18bold.copyWith(
                          color: AppConstColors.appThemeCayan,
                        ),
                      ),
                      children: [
                        const SizedBox(height: 10),
                        _getProductsWidget(context, productsViewModel),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      );
    });
  }

  Widget getSkinConcernFilterItems() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color:  AppConstColors.appThemeCayan),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        spacing: 8.0,
        children: _choices.map((choice) {
          return ChoiceChip(
            label: Text(choice),
            padding: EdgeInsets.zero,
            selected: _selectedChoices.contains(choice),
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _selectedChoices.add(choice);
                } else {
                  _selectedChoices.remove(choice);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _getProductsWidget(context, ProductsViewModel productsViewModel) {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        // mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      // padding: const EdgeInsets.all(8.0),
      itemCount:
          productsViewModel.productsModel?.productRecommendations?.length,
      itemBuilder: (context, index) {
        ProductRecommendation? productRecommendation = productsViewModel
            .productsModel?.productRecommendations
            ?.elementAt(index);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(product: productRecommendation)));
            },
            child: Column(
              children: [
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: productRecommendation?.productImageUrl != null
                      ? Image.network(
                          '${productRecommendation?.productImageUrl}',
                          // height: 90,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          '$dummyImage3',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
                Text(
                  productRecommendation?.productName ?? 'N/A',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
