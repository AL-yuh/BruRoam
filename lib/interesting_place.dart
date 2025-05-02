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
      backgroundColor: const Color(0xFFF9C22E),//Bright yellow background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9C22E),
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
          icon: const Icon(Icons.menu, color:Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            //places to go button
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFD4BE7F),//Gold/tan color
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
            //Events Section
            CategoryCard(
              title: ' Events',
              subtitle: 'Find current events to go in Brunei',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            //shops section
            CategoryCard(
              title: 'Shops',
              subtitle: 'Find shops at your convenience',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            //Interesting Places section
            CategoryCard(
              title: 'Interesting\nPlaces',
              subtitle: 'Discover Brunei\'s most beautiful attractions',
              titleLineHeight: 1.2,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InterestingPlacesPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double titleLineHeight;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.titleLineHeight = 1.5,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFF9B208),//Darker yellow for cards
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}

class InterestingPlacesPage extends StatelessWidget {
  const InterestingPlacesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9C22E),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9C22E),
        elevation: 0,
        title: const Text(
          'Interesting Places',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: const [
            SizedBox(height: 16),
            PlaceCard(
               title: 'Sultan Omar Ali Saifuddien Mosque',
              description: 'A stunning mosque with golden domes and a man-made lagoon. A symbol of Islamic architecture in Brunei.',
              address: 'Jalan McArthur, Bandar Seri Begawan BS8711, Brunei',
            ),
            SizedBox(height: 16),
            PlaceCard(
              title: 'Kampong Ayer (Water Village)',
              description: 'A traditional water village with homes on stilts, wooden walkways, and boat tours. Known as the "Venice of the East."',
              address: 'Kampong Ayer, Bandar Seri Begawan, Brunei',

            ),
            SizedBox(height: 16),
            PlaceCard(
              title: 'Royal Regalia Museum',
              description: 'Showcases the royal regalia and personal collections of the Sultan. Free admission and rich in history.',
              address: 'Jalan Sultan, Bandar Seri Begawan BS8611, Brunei',
            ),
            SizedBox(height: 16),
            PlaceCard(
             title: 'Ulu Temburong National Park',
              description: 'A protected rainforest with canopy walks, waterfalls, and eco-adventures. Perfect for nature lovers.',
              address: 'Batang Duri, Temburong District, Brunei (accessible via boat from Bangar)',

            ),
            SizedBox(height: 16),
            PlaceCard(
              title: 'The Empire Brunei',
              description: 'A luxurious beachfront resort with grand architecture, a golf course, and fine dining. Open to day visitors.',
              address: 'Jerudong BG3122, Brunei',
            ),
            SizedBox(height: 16),
            PlaceCard(
               title: 'Tasek Lama Recreational Park',
              description: 'A city park with hiking trails, a waterfall, and a viewing tower. Great for jogging and picnics.',
              address: 'Jalan Tasek Lama, Bandar Seri Begawan, Brunei',

            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String title;
  final String description;
  final String address;

  const PlaceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade200, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blank image placeholder
          Container(
            width: 80,
            height: 80,
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Times New Roman',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    
                    ],
                  ),
                  Text(
                    address,
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}