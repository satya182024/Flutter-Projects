import 'package:flutter/material.dart';
import 'package:food_delivery/Widgets/food_product_items.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/models/category_model.dart';
import 'package:food_delivery/models/my_product_model.dart';
import 'package:food_delivery/view/cart.dart';
import 'package:provider/provider.dart';

import '../Provider/cart_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String category = '';
  List<MyProductModel> productModel = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (myCategories.isNotEmpty) {
      category = myCategories[0].name;
      filterProductByCategory(category);
    }
  }

  void filterProductByCategory(String selectedCategory) {
    setState(() {
      category = selectedCategory;
      productModel = myProducts
          .where((element) =>
              element.category.toLowerCase() == selectedCategory.toLowerCase())
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  const Expanded(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Your Location',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: kblack,
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Dubai, UAE',
                            style: TextStyle(
                                fontSize: 16,
                                color: kblack,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  )),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          Icons.search,
                          color: kblack,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Stack(alignment: Alignment.topCenter, children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: kblack,
                          ),
                        ),
                        cartProvider.carts.isNotEmpty
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Cart()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xfff95f60),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      cartProvider.carts.length.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ))
                            : Container(),
                      ]),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Let\'s find the best food around you',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.4,
                    color: kblack),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Find by Category',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: kblack),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(color: Colors.orange),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                      myCategories.length,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                filterProductByCategory(
                                    myCategories[index].name);
                              });
                            },
                            child: Container(
                              height: 105,
                              width: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: category == myCategories[index].name
                                      ? Border.all(width: 2.5, color: korange)
                                      : Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 45,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      kblack.withOpacity(0.4),
                                                  offset: Offset(0, 10),
                                                  blurRadius: 12,
                                                  spreadRadius: 5)
                                            ]),
                                      ),
                                      Image.asset(
                                        myCategories[index].image,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(myCategories[index].name)
                                ],
                              ),
                            ),
                          ))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Result: ${productModel.length}',
                style: TextStyle(
                    color: kblack.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    letterSpacing: -.2),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  ...List.generate(
                    productModel.length,
                    (index) => Padding(
                      padding: index == 0
                          ? const EdgeInsets.only(left: 25, right: 25)
                          : const EdgeInsets.only(right: 25),
                      child:
                          FoodProductItems(myProductModel: productModel[index]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Padding headerParts() {
  //   return
  // }
}
