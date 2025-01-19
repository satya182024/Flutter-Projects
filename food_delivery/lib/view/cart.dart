import 'package:animate_do/animate_do.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Provider/cart_provider.dart';
import 'package:food_delivery/Widgets/cart_items.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<CartModel> cartsItems = cartProvider.carts.reversed.toList();
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                cartProvider.removeAll();
              },
              icon: const Icon(Icons.remove_shopping_cart_outlined))
        ],
        title: const
            //
            Text(
          'My Cart',
          style: TextStyle(
              color: kblack, fontWeight: FontWeight.w600, fontSize: 22),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 25),
          //     child:
          //   ),
          Expanded(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...List.generate(
                    cartsItems.length,
                    (index) => Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: index == 0 ? 30 : 0,
                              right: 25,
                              left: 25,
                              bottom: 30),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              FadeInUp(
                                  delay:
                                      Duration(milliseconds: (index + 1) * 200),
                                  child:
                                      CartItems(cartModel: cartsItems[index]))
                            ],
                          ),
                        ))
              ],
            ),
          )),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Delivery',
                      style: TextStyle(
                          fontSize: 20,
                          color: kblack,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DottedLine(
                        dashLength: 10,
                        dashColor: kblack.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '\$5.99',
                      style: TextStyle(
                          color: korange,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Total Order',
                      style: TextStyle(
                          fontSize: 20,
                          color: kblack,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DottedLine(
                        dashLength: 10,
                        dashColor: kblack.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      '\$${(cartProvider.totalCart()).toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: korange,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: kblack,
                  height: 75,
                  minWidth: MediaQuery.of(context).size.width - 50,
                  child: Text(
                    " Pay \$${(cartProvider.totalCart() + 5.99).toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
