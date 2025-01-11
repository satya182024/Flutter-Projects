import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic movie;

  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: movie['image'] != null
                    ? Image.network(
                        movie['image']['original'],
                        fit: BoxFit.contain,
                      )
                    : Container(
                        color: Colors.grey,
                        child: const Icon(Icons.movie, size: 100),
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['name'] ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (movie['genres'] != null && movie['genres'].length > 0)
                      Wrap(
                        spacing: 8,
                        children: (movie['genres'] as List).map((genre) {
                          return Chip(
                            label: Text(genre),
                            backgroundColor: Colors.red,
                            labelStyle: const TextStyle(color: Colors.white),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 16),
                    if (movie['rating'] != null &&
                        movie['rating']['average'] != null)
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          const SizedBox(width: 8),
                          Text(
                            '${movie['rating']['average']}/10',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    Text(
                      _stripHtmlTags(
                          movie['summary'] ?? 'No summary available'),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _stripHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
