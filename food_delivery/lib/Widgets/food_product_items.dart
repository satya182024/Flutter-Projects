// import 'package:flutter/material.dart';
// import 'package:food_delivery/Provider/cart_provider.dart';
// import 'package:food_delivery/consts/consts.dart';
// import 'package:food_delivery/models/my_product_model.dart';
// import 'package:food_delivery/view/product_page.dart';
// import 'package:provider/provider.dart';

// class FoodProductItems extends StatelessWidget {
//   final MyProductModel myProductModel;
//   const FoodProductItems({super.key, required this.myProductModel});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     CartProvider cartProvider = Provider.of<CartProvider>(context);
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     ProductPage(myProductModel: myProductModel)));
//       },
//       child: Stack(
//         alignment: AlignmentDirectional.bottomCenter,
//         children: [
//           Container(
//             height: 225,
//             width: size.width / 2.3,
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(10)),
//           ),
//           Container(
//             height: 285,
//             width: size.width / 2.3,
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 160,
//                     child: Stack(
//                       alignment: AlignmentDirectional.center,
//                       children: [
//                         Positioned(
//                           bottom: 0,
//                           child: Container(
//                             height: 50,
//                             width: 100, //100
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     spreadRadius: 10,
//                                     blurRadius: 30,
//                                   )
//                                 ]),
//                           ),
//                         ),
//                         Image.asset(
//                           myProductModel.image,
//                           height: 150,
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     overflow: TextOverflow.ellipsis,
//                     myProductModel.name,
//                     style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: kblack),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.star_rate_rounded,
//                             color: kyellow,
//                             size: 22,
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             myProductModel.rate.toString(),
//                             style: TextStyle(color: kblack.withOpacity(0.5)),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on,
//                             color: Colors.red,
//                             size: 20,
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             "${myProductModel.distance} m",
//                             style: TextStyle(
//                                 color: kblack.withOpacity(0.5),
//                                 fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "\$${myProductModel.price.toStringAsFixed(2)}",
//                     style: const TextStyle(
//                         color: kblack,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               bottom: 0,
//               right: 0,
//               child: GestureDetector(
//                 onTap: () {
//                   cartProvider.addCart(myProductModel);
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: const BoxDecoration(
//                       color: kblack,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           bottomRight: Radius.circular(10))),
//                   child: const Icon(
//                     Icons.shopping_cart_outlined,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:food_delivery/Provider/cart_provider.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/models/my_product_model.dart';
import 'package:food_delivery/view/product_page.dart';
import 'package:provider/provider.dart';

class FoodProductItems extends StatelessWidget {
  final MyProductModel myProductModel;
  const FoodProductItems({super.key, required this.myProductModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    // Final adjustment to container heights
    double containerHeight = size.height * 0.255; // Reduced from 0.26
    double outerContainerHeight = size.height * 0.325; // Reduced from 0.33
    double imageStackHeight = size.height * 0.19;
    double imageHeight = size.height * 0.17;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductPage(myProductModel: myProductModel)));
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            height: containerHeight,
            width: size.width / 2.3,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
          Container(
            height: outerContainerHeight,
            width: size.width / 2.3,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: imageStackHeight,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: size.height * 0.06,
                            width: size.width * 0.25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 10,
                                    blurRadius: 30,
                                  )
                                ]),
                          ),
                        ),
                        Image.asset(
                          myProductModel.image,
                          height: imageHeight,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    myProductModel.name,
                    style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: kblack),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            color: kyellow,
                            size: size.width * 0.055,
                          ),
                          SizedBox(
                            width: size.width * 0.012,
                          ),
                          Text(
                            myProductModel.rate.toString(),
                            style: TextStyle(color: kblack.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.012,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: size.width * 0.05,
                          ),
                          SizedBox(
                            width: size.width * 0.012,
                          ),
                          Text(
                            "${myProductModel.distance} m",
                            style: TextStyle(
                                color: kblack.withOpacity(0.5),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    "\$${myProductModel.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: kblack,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${myProductModel.name} added to Cart. ')));
                  cartProvider.addCart(myProductModel);
                },
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.03),
                  decoration: const BoxDecoration(
                      color: kblack,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: size.width * 0.05,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
