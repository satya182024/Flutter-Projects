import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/my_product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;
  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  //add a product to cart
  addCart(MyProductModel productModel) {
    if (productExist(productModel)) {
      int index =
          _carts.indexWhere((element) => element.productModel == productModel);
      _carts[index].quantity = _carts[index].quantity + 1;
    } else {
      // add a new CartModel item with quantity 1
      _carts.add(CartModel(productModel: productModel, quantity: 1));
    }
    notifyListeners();
  }

  addQuantity(MyProductModel product) {
    //finds the index of the product in the cart.
    int index = _carts.indexWhere((element) => element.productModel == product);
    _carts[index].quantity = _carts[index].quantity + 1;
    notifyListeners();
  }

  removeProduct(MyProductModel product) {
    if (productExist(product)) {
      int index =
          _carts.indexWhere((element) => element.productModel == product);
      _carts.removeAt(index);
      notifyListeners();
    }
  }

  removeAll() {
    _carts.clear();
    notifyListeners();
  }

  reduceQuantity(MyProductModel product) {
    int index = _carts.indexWhere((element) => element.productModel == product);
    _carts[index].quantity = _carts[index].quantity - 1;
    notifyListeners();
  }

  productExist(MyProductModel productModel) {
    if (_carts.indexWhere((element) => element.productModel == productModel) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  double totalCart() {
    double total = 0;
    for (var i = 0; i < _carts.length; i++) {
      total = total + _carts[i].quantity * _carts[i].productModel.price;
    }
    return total;
  }
}
