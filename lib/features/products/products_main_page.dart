import 'package:clarity_mirror/features/products/model/products_model.dart';
import 'package:clarity_mirror/features/products/product_details_page.dart';
import 'package:clarity_mirror/features/products/products_view_model.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/utils/common_widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
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
    'Hydration',
    'Texture',
    'Elasticity',
    'Redness',
    'Pores',
    'Dark Circles',
    'Dehydration',
    'Uneven Skintone',
    'Oiliness',
    'Lip Health',
    'Firmness',
    
  ];


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
      print(
          'Products ${productsViewModel.productsModel?.productRecommendations?.length}');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Products for you'),
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
        body: productsViewModel.isLoading
            ? const ProgressIndicatorWidget()
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          'Regimen for you',
                          style: AppFonts().sego18bold.copyWith(
                              color: AppConstColors.appThemeCayan,
                          ),
                        ),
                        children: [
                          getSkinConcernFilterItems(productsViewModel),
                          getGroupedProductsDataWidget(productsViewModel),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        dense: true,
                        enabled: true,
                        initiallyExpanded: true,
                        trailing:
                            (!_isExpanded) ? const SizedBox.shrink() : null,
                        onExpansionChanged: (value) {
                          _isExpanded = !_isExpanded;
                          setState(() {});
                        },
                        title: (!_isExpanded)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Other Products',
                                    style: AppFonts().sego18bold.copyWith(
                                        color: (!_isExpanded)
                                            ? AppConstColors.appThemeCayan
                                            : AppConstColors
                                                .editProfileTxtColor),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Icon(
                                      //   Icons.more_horiz,
                                      //   color: Colors.white,
                                      // ),
                                      // SizedBox(
                                      //   width: 20,
                                      // ),
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
                          // getSkinConcernFilterItems(),
                          const SizedBox(height: 10),
                          _getProductsWidget(context,
                              products: productsViewModel
                                  .productsModel?.productRecommendations),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }

  Widget getGroupedProductsDataWidget(ProductsViewModel productsVM) {
    // Map<String, List<ProductRecommendation?>> groupedProducts = groupBy(
    //     Provider.of<ProductsViewModel>(context, listen: false)
    //             .productsModel
    //             ?.productRecommendations ??
    //         [],
    //     (product) => product?.regimentName ?? 'N/A');
    // print('Grouped products length: ${groupedProducts.length}');
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: productsVM.groupedProducts?.length,
        itemBuilder: (context, index) {
          // groupedProducts.values.
          // return Column(children: [

          // ],);
          return Column(
            children: [
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  dense: !_isExpanded,
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
                            Expanded(
                              flex: 3,
                              child: Text(
                                productsVM.groupedProducts?.keys.elementAt(index) ?? '',
                                style: AppFonts().sego18bold.copyWith(
                                    color: (!_isExpanded)
                                        ? AppConstColors.appThemeCayan
                                        : AppConstColors.editProfileTxtColor),
                              ),
                            ),
                            const Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Text(
                          productsVM.groupedProducts?.keys.elementAt(index) ?? '',
                          style: AppFonts().sego18bold.copyWith(
                                color: AppConstColors.appThemeCayan,
                              ),
                        ),
                  children: [
                    // getSkinConcernFilterItems(),
                    const SizedBox(height: 10),
                    _getProductsWidget(context,
                        products: productsVM.groupedProducts?.values.elementAt(index)),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget getSkinConcernFilterItems(ProductsViewModel productsViewModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppConstColors.appThemeCayan),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        spacing: 8.0,
        children: _choices.map((choice) {
          return GestureDetector(
            onTap: () {

             productsViewModel.selectedChoices.contains(choice) ? productsViewModel.removeSelectedChoice(choice) : productsViewModel.addSelectedChoice(choice)  ;
print(productsViewModel.selectedChoices);
               
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Container(decoration: BoxDecoration(
                color: productsViewModel.selectedChoices.contains(choice) ? AppConstColors.appThemeCayan.withOpacity(0.2) : Colors.transparent,
                border: Border.all(color:productsViewModel.selectedChoices.contains(choice) ? AppConstColors.appThemeCayan: Colors.white),borderRadius: BorderRadius.circular(10)),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(choice,style: AppFonts().sego14normal,),
              ),),
            ),
          );
          // ChoiceChip(
          //   label: Text(choice,style: AppFonts().sego14normal,),
          //   padding: EdgeInsets.zero,
          //   selected: productsViewModel.selectedChoices.contains(choice),
          // //   onSelected: (bool selected) {
              
          //       if (selected) {
          //         productsViewModel.addSelectedChoice(choice);
                  
          //       } else {
          //         productsViewModel.removeSelectedChoice(choice);
          //       }
              
          //   },
          // );
        }).toList(),
      ),
    );
  }

  Widget sunnyOrMoon(String? precribedTime){
    if(precribedTime != null && precribedTime == "Day time"){
      return Container(
        decoration: const BoxDecoration(color: Colors.grey,shape: BoxShape.circle),
        child: const Padding(
          padding: EdgeInsets.all(2.0),
          child: Icon(Icons.sunny,color: Colors.black,size: 18,),
        ));
    }
    else if(precribedTime != null && precribedTime == "Night time"){
      return Container(
        decoration: const BoxDecoration(color: Colors.grey,shape: BoxShape.circle),
        child:  const Padding(
          padding: EdgeInsets.all(2.0),
          child: Icon(Icons.nightlight_round_outlined,size: 18,color: Colors.black),
        ));
    }else if(precribedTime != null && precribedTime == "Day time & Night time"){
      return Container(
        decoration: const BoxDecoration(color: Colors.grey,shape: BoxShape.circle),
        child: const Padding(
          padding: EdgeInsets.all(2.0),
          child: Icon(Icons.sunny_snowing,size: 18,color: Colors.black),
        ));
    }
    return const SizedBox();
  }

  Widget _getProductsWidget(context,
      {@required List<ProductRecommendation?>? products}) {
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
      itemCount: products?.length,
      itemBuilder: (context, index) {
        ProductRecommendation? productRecommendation =
            products?.elementAt(index);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsPage(product: productRecommendation)));
            },
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 10,
                  left: -1,
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: productRecommendation?.productImageUrl != null
                        ? Image.network(
                            '${productRecommendation?.productImageUrl}',
                            // height: 90,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            dummyImage3,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top:0 ,
                  child: sunnyOrMoon(productRecommendation?.prescribedTimeToUse)),
                Positioned(
                  top: 110,
                  child: SizedBox(
                    width: 105,
                    child: Text(
                      productRecommendation?.productName ?? 'N/A',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: AppFonts().sego12normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
