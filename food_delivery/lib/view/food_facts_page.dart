import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/foods_fact_provider.dart';
import '../Widgets/food_fact_card.dart';


class FoodFactsPage extends StatelessWidget {
  const FoodFactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF9A9E),
              Color(0xFFFAD0C4),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Random Food Facts',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Consumer<FoodFactsProvider>(
                  builder: (context, foodFactsProvider, child) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: foodFactsProvider.foodFacts.length,
                      itemBuilder: (context, index) {
                        return FoodFactCard(fact: foodFactsProvider.foodFacts[index]);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => Provider.of<FoodFactsProvider>(context, listen: false).generateNewFacts(),
                  child: const Text('Generate New Facts'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.pink, backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
