import 'package:flutter/material.dart';

void main() {
  runApp(const BruRoamApp());
}

class BruRoamApp extends StatelessWidget {
  const BruRoamApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BruRoam',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Times New Roman',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 253, 252),
        elevation: 0,
        title: const Text(
          'BruRoam',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              // "Places to Go" title
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4BE7F),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Places to Go',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Category Cards
              CategoryCard(
                title: 'Events',
                subtitle: 'Find current events to go in Brunei',
              ),
              const SizedBox(height: 20),
              CategoryCard(
                title: 'Shops',
                subtitle: 'Find shops at your convenience',
              ),
              const SizedBox(height: 20),
              CategoryCard(
                title: 'Interesting\nPlaces',
                subtitle: '',
                titleLineHeight: 1.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double titleLineHeight;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.titleLineHeight = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9B208),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: titleLineHeight,
              fontFamily: 'Times New Roman',
            ),
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Times New Roman',
              ),
            ),
        ],
      ),
    );
  }
}