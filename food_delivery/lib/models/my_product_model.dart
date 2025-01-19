class MyProductModel {
  final String image, name, category, description;
  final double price, rate, distance;

  MyProductModel({
    required this.image,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.rate,
    required this.distance,
  });
}

List<MyProductModel> myProducts = [
  MyProductModel(
      image: 'assets/ramen/sapporo_miso_ramen.png',
      name: 'Sapporo Miso',
      description:
          'Sapporo miso is a rich, flavorful ramen broth made with a blend of six different types of miso and vegetables, often accompanied by wavy noodles and customizable spice levels.',
      category: "Ramen",
      price: 3.9,
      rate: 5,
      distance: 150),
  MyProductModel(
      image: 'assets/ramen/kurume_ramen.png',
      name: 'Kurume Ramen',
      description:
          'Kurume Ramen is a rich, creamy tonkotsu ramen from Kurume City in Fukuoka Prefecture, known for its thick, flavorful soup and straight, slightly thicker noodles compared to other styles like Hakata Ramen.',
      category: 'Ramen',
      price: 4.3,
      rate: 4.9,
      distance: 600),
  MyProductModel(
      image: 'assets/ramen/hakata_ramen.png',
      name: 'Hakata Ramen',
      description:
          'Hakata Ramen is a type of Japanese ramen characterized by its ultra-fine, straight noodles served in a rich, cloudy tonkotsu broth.',
      category: 'Ramen',
      price: 3.9,
      rate: 4.8,
      distance: 400),
  MyProductModel(
      image: 'assets/ramen/shrimp_fried_rice.png',
      name: 'Shrimp Fried Rice',
      description:
          'Sapporo miso is a rich, flavorful ramen broth made with a blend of six different types of miso and vegetables, often accompanied by wavy noodles and customizable spice levels.',
      category: 'Ramen',
      price: 4.9,
      rate: 4.5,
      distance: 800),
  MyProductModel(
      image: 'assets/ramen/fullset_ramen.png',
      name: 'Fullset Ramen',
      description:
          'Sapporo miso is a rich, flavorful ramen broth made with a blend of six different types of miso and vegetables, often accompanied by wavy noodles and customizable spice levels.',
      category: 'Ramen',
      price: 5.9,
      rate: 4.7,
      distance: 400),
  MyProductModel(
    image: 'assets/burger/cheese-burger.png',
    name: 'Aalu Tikki burger',
    description:
        'Aloo tikki burger is a fusion dish featuring crispy potato patties stuffed with paneer and pickled onions, served in a toasted burger bun.',
    price: 33.5,
    distance: 150,
    rate: 5.0,
    category: "Burger",
  ),
  MyProductModel(
      image: 'assets/burger/cheese-burger.png',
      name: 'Cheese Burger',
      description:
          'A cheeseburger is a hamburger topped with a slice of melted cheese on top of the meat patty, added near the end of the cooking time, and may include various condiments and other toppings.',
      category: 'Burger',
      price: 40.5,
      rate: 4.5,
      distance: 100),
  // for salad
  MyProductModel(
    image: 'assets/veg-salad.png',
    name: 'Veg Salad',
    description:
        'Sapporo miso is a rich, flavorful ramen broth made with a blend of six different types of miso and vegetables, often accompanied by wavy noodles and customizable spice levels.',
    price: 7.0,
    distance: 300,
    rate: 5.0,
    category: "Salad",
  ),
  MyProductModel(
    image: 'assets/mix-salad.png',
    name: 'Mix Salad',
    description:
        'Sapporo miso is a rich, flavorful ramen broth made with a blend of six different types of miso and vegetables, often accompanied by wavy noodles and customizable spice levels.',
    price: 10.0,
    distance: 350,
    rate: 4.8,
    category: "Salad",
  ),
  // for waffle
  MyProductModel(
    image: 'assets/berry-bonanza-waffle.png',
    name: 'Berry Bonanza Waffle',
    description:
        'Berry Bonanza Waffles are delightful and versatile berry puree from the Gumdropz Berry Bonanza strain, which offers a tasty berry flavor profile.',
    price: 10.0,
    distance: 500,
    rate: 4.5,
    category: "Waffle",
  ),
];
