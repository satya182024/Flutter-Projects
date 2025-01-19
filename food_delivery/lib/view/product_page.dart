// import 'package:flutter/material.dart';

// import '../consts/consts.dart';
// import '../models/my_product_model.dart';

// class ProductPage extends StatelessWidget {
//   final MyProductModel myProductModel;
//   const ProductPage({super.key, required this.myProductModel});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(10),
//           margin: EdgeInsets.all(10),
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 10,
//                 child: Text(
//                   'Get information of the food',
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Positioned(
//                 top: 80,
//                 child: Container(
//                   height: 100,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     gradient: const LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Color.fromARGB(255, 202, 94, 55),
//                         Color.fromARGB(255, 236, 101, 52),
//                         Color.fromARGB(255, 219, 135, 105),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 50,
//                 left: 10,
//                 child: Stack(
//                   children: [
//                     Container(
//                       height: 100,
//                       width: 145,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: kblack.withOpacity(0.4),
//                             offset: Offset(0, 10),
//                             blurRadius: 12,
//                             spreadRadius: 5,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Image.asset(myProductModel.image),
//                   ],
//                 ),
//                 height: 100,
//               ),
//               Positioned(
//                 top: 100,
//                 right: 20,
//                 child: Text(
//                   myProductModel.name,
//                   style: TextStyle(fontSize: 25, color: Colors.white),
//                 ),
//               ),
//               Positioned(
//                 top: 300,
//                 child: Container(
//                   width: MediaQuery.of(context).size.width - 40,
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         const Color.fromARGB(255, 236, 83, 27),
//                         const Color.fromARGB(255, 219, 116, 79),
//                         const Color.fromARGB(255, 205, 85, 42),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Text(
//                     myProductModel.description,
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 20,
//                 left: 0,
//                 right: 0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       '\$${myProductModel.price.toStringAsFixed(2)}',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Add to cart functionality
//                       },
//                       child: Text('Add to Cart'),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.orange,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_delivery/Provider/cart_provider.dart';
import 'package:food_delivery/view/cart.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../consts/consts.dart';
import '../models/my_product_model.dart';

class ProductPage extends StatefulWidget {
  final MyProductModel myProductModel;
  const ProductPage({super.key, required this.myProductModel});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<Offset> _nameSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _nameSlideAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Timer(Duration(milliseconds: 200), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
              icon: const Icon(Icons.shopping_cart))
        ],
        title: const Text(
          'Get to know more',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Positioned(
              //   top: 10,
              //   left: 10,
              //   right: 10,
              //   child: Text(
              //     'Get information of the food',
              //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //   ),
              // ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                height: 80,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFF9A9E),
                        Color.fromARGB(255, 238, 153, 130),
                        const Color.fromARGB(255, 241, 99, 99),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 10,
                child: SlideTransition(
                  position: _imageSlideAnimation,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: kblack.withOpacity(0.4),
                              offset: Offset(0, 10),
                              blurRadius: 12,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(widget.myProductModel.image,
                          height: 120, width: 120),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 90,
                right: 20,
                child: SlideTransition(
                  position: _nameSlideAnimation,
                  child: Text(
                    widget.myProductModel.name,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 10,
                right: 10,
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFF9A9E),
                          Color.fromARGB(255, 238, 153, 130),
                          Color.fromARGB(255, 241, 99, 99),
                          // const Color.fromARGB(255, 241, 133, 94),
                          // const Color.fromARGB(255, 224, 102, 58),
                          // const Color.fromARGB(255, 246, 122, 77),
                          // const Color.fromARGB(255, 220, 72, 17),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.myProductModel.description,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Ratings.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Text(
                              widget.myProductModel.rate.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${widget.myProductModel.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Added to cart',
                                )));
                        cartProvider.addCart(widget.myProductModel);
                        // Add to cart functionality
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xffFBF0F4),
                        backgroundColor:
                            const Color.fromARGB(255, 247, 126, 34),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Add to Cart'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
