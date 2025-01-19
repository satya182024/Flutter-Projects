import 'package:flutter/foundation.dart';
import 'dart:math';

class FoodFactsProvider extends ChangeNotifier {
  List<String> _foodFacts = [];

  List<String> get foodFacts => _foodFacts;

  FoodFactsProvider() {
    generateNewFacts();
  }

  void generateNewFacts() {
    _foodFacts = _generateRandomFoodFacts();
    notifyListeners();
  }

  List<String> _generateRandomFoodFacts() {
    final List<String> allFacts = [
      // Ramen facts
      "Ramen was first invented in 1958 by Momofuku Ando.",
      "The world's largest serving of ramen weighed 4,508 kg and was made in Japan.",
      "There are over 10,000 ramen shops in Tokyo alone.",
      "Instant ramen was invented to help feed people after World War II.",

      // Burger facts
      "The world's largest hamburger weighed 2,014 pounds.",
      "Americans eat about 50 billion burgers a year.",
      "The term 'hamburger' comes from Hamburg, Germany.",
      "The first burger chain was White Castle, founded in 1921.",

      // Waffle facts
      "The world's largest waffle weighed 110 pounds and was made in the Netherlands.",
      "Belgian waffles were introduced to North America at the 1964 New York World's Fair.",
      "The first electric waffle iron was patented in 1911.",
      "In Belgium, there are two main types of waffles: Brussels and Liège.",

      // Salad facts
      "The word 'salad' comes from the Latin word 'sal', meaning salt.",
      "The Caesar salad was invented in Mexico by an Italian-American restaurateur.",
      "The world's largest salad weighed 20,100 kg and was made in Romania.",
      "The first salad bars appeared in the United States in the late 1960s.",
    ];

    final random = Random();
    final selectedFacts = <String>{};

    while (selectedFacts.length < 5) {
      selectedFacts.add(allFacts[random.nextInt(allFacts.length)]);
    }

    return selectedFacts.toList();
  }
}
