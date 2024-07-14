
import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view_model/cart_view_model.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CartViewModel>(context, listen: false).total();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, cartProvider, _) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "Cart",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.black,
                    child: CartListCard(index: index,));
                },
              ),
              promoCard(),
              cartFinalPriceSummary(cartProvider),
              checkoutBtnWidget()
            ],
          ),
        ),
      );
    });
  }

  Widget cartFinalPriceSummary(CartViewModel cartProvider){
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppConstColors.cartCardColor
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 6),
                              child: Text(
                                textAlign: TextAlign.start,
                                "Sub Total",
                                style: AppFonts().sego14normal,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:40.0),
                              child: Text(
                                textAlign: TextAlign.start,
                                "\$${cartProvider.subTotal}",
                                style: AppFonts().sego14normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 6),
                              child: Text(
                                textAlign: TextAlign.start,
                                "Shipping",
                                style: AppFonts().sego14normal,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:40.0),
                              child: Text(
                                textAlign: TextAlign.start,
                                "\$${cartProvider.shippingCost}",
                                style: AppFonts().sego14normal,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 6),
                              child: Text(
                                textAlign: TextAlign.start,
                                "Total",
                                style: AppFonts().sego14normal,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:40.0),
                              child: Text(
                                textAlign: TextAlign.start,
                                "\$${cartProvider.totalPrice}",
                                style: AppFonts().sego14normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }

  Widget checkoutBtnWidget(){
    return Padding(
                padding:
                     const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: GestureDetector(onTap: () {

                },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppConstColors.appThemeCayan,
                    ),
                    child:   Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        " Checkout",
                        style: AppFonts().sego20normal,
                      ),
                    ),
                  ),
                ),
              );
  }

  Widget promoCard(){
    return Padding(
                padding:  const EdgeInsets.symmetric(horizontal:10.0,vertical: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppConstColors.cartCardColor
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                     SizedBox(
                  width :MediaQuery.of(context).size.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Promo Code",hintStyle:AppFonts().sego18normal.copyWith(color: AppConstColors.editProfileTxtColor) ),
                    ),
                  )),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppConstColors.appThemeCayan),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36.0, vertical: 15),
                          child: Text(
                            textAlign: TextAlign.center,
                            "Apply",
                            style: AppFonts().sego18normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}

class CartListCard extends StatelessWidget {
  const CartListCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(builder: (context, cartProvider, _) {
        return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          key: Key(cartProvider.cartItems[index].name),
                          onDismissed: (direction) {
                            cartProvider.cartItems[index];
                          },
                          background: Container(
                           
                          ),
                          secondaryBackground: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red,
                            ),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            child: const Icon(Icons.delete),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppConstColors.cartCardColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 10),
                                  child: cartProvider.cartItems[index].image,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartProvider.cartItems[index].name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height * 0.07,
                                      width:
                                          MediaQuery.of(context).size.width - 150,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${cartProvider.cartItems[index].price.toString()}',
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          // SizedBox(
                                          //   width: MediaQuery.of(context).size.width * 0.30,
                                          // ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppConstColors.plusMinusBackgroundColor),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      cartProvider.decrement(index);
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        color: AppConstColors.plusMinusBtnColor,
                                                      ),
                                                      child: const Icon(Icons.remove),
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15.0),
                                                  child: Text(
                                                    '${cartProvider.cartItems[index].count}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      cartProvider.increment(index);
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        color: AppConstColors.plusMinusBtnColor,
                                                      ),
                                                      child: const Icon(Icons.add),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
      }
    );
  }
}

class Cartitems {
  final String name;
  dynamic image;
  int price;
  int count;

  Cartitems(
      {required this.name,
      required this.image,
      required this.price,
      required this.count});
}
