
import 'package:flutter/material.dart';

import '../view/cart_page.dart';


class CartViewModel extends ChangeNotifier {

  void increment(int index) {
  cartItems[index].count++;
  total();
    notifyListeners();
  }

  void decrement(int index) {
    if (cartItems[index].count >0) {
    cartItems[index].count--;
    total();
      notifyListeners();
    }
  }

  // void multiple(int num){
  //   _counter*num;
  //   notifyListeners();
  // }
  
    List<Cartitems> cartItems = [
    Cartitems(name: "Deep Radiance cream",image: Image.network("https://www.be-ecocentric.com/img/108/356979/m2/p/royalty-body-oil-lovinah.jpg",fit: BoxFit.fill,height:80,width:80,), price: 50, count: 0),
    Cartitems(name: "Wrinkel Reducer",image: Image.network("https://st4prdbebeautiful4s4ci.blob.core.windows.net/www-bebeautiful-in/5-beauty-products-we-are-loving-this-month_3.jpg?w=300",fit: BoxFit.fill,height:80,width:80,), price: 75, count: 0),
    Cartitems(name: "Under Eye Cream",image: Image.network("https://media.vogue.fr/photos/5d0a126388190aefe27180b5/master/pass/182855_estee_lauder_advance.jpg",fit: BoxFit.fill,height:80,width:80,), price: 125, count: 0),
    Cartitems(name: "Deep Radiance cream",image: Image.network("https://www.be-ecocentric.com/img/108/356979/m2/p/royalty-body-oil-lovinah.jpg",fit: BoxFit.fill,height:80,width:80,), price: 50, count: 0),
    Cartitems(name: "Wrinkel Reducer",image: Image.network("https://st4prdbebeautiful4s4ci.blob.core.windows.net/www-bebeautiful-in/5-beauty-products-we-are-loving-this-month_3.jpg?w=300",fit: BoxFit.fill,height:80,width:80,), price: 75, count: 0),
    Cartitems(name: "Under Eye Cream",image: Image.network("https://media.vogue.fr/photos/5d0a126388190aefe27180b5/master/pass/182855_estee_lauder_advance.jpg",fit: BoxFit.fill,height:80,width:80,), price: 125, count: 0),
  ];

  double shippingCost = 20;
 

double totalPrice = 0.0; 
double subTotal = 0.0;
  void total(){
    totalPrice = 0.0;
     cartItems.forEach((item) {
      subTotal += item.price * item.count ;

    });
    totalPrice = subTotal + shippingCost;
  }

}
