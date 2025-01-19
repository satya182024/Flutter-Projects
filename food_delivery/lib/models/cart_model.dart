import 'package:food_delivery/models/my_product_model.dart';

class CartModel {
  final MyProductModel productModel;
  int quantity;

  CartModel({
    required this.productModel,
    required this.quantity,
  });
}
