import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFFF9C22E),
    statusBarIconBrightness: Brightness.dark,
  ));
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
        fontFamily: 'serif',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/events': (context) => const EventsPage(),
        '/shops': (context) => const ShopsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9C22E), // Bright yellow background
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Places to Go button
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4BE7F), // Gold/tan color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Places to Go',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'serif',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Events section
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/events'),
                child: const CategoryCard(
                  title: 'Events',
                  subtitle: 'Find current events to go in Brunei',
                ),
              ),
              const SizedBox(height: 20),
              // Shops section
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/shops'),
                child: const CategoryCard(
                  title: 'Shops',
                  subtitle: 'Find shops at your convenience',
                ),
              ),
              const SizedBox(height: 20),
              // Interesting Places section
              const CategoryCard(
                title: 'Interesting\nPlaces',
                subtitle: '',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildPageHeader(context, 'Events'),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 6, // Show 6 events as in the image
              itemBuilder: (context, index) {
                return EventItem(
                  isEven: index % 2 == 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShopsPage extends StatelessWidget {
  const ShopsPage({Key? key}) : super(key: key);

  // List of Brunei shopping malls with their details
  final List<Map<String, String>> mallsData = const [
    {
      'name': 'The Mall Gadong',
      'address': 'Jalan Gadong, Bandar Seri Begawan, Brunei Darussalam',
      'description': "Brunei's most prominent shopping destination featuring multiple floors of retail shops, a large Hua Ho department store, numerous fashion outlets, electronics stores, a food court, restaurants, and entertainment facilities."
    },
    {
      'name': 'Times Square Shopping Centre',
      'address': 'Jalan Berakas, Kampung Jaya Setia, Bandar Seri Begawan, Brunei Darussalam',
      'description': 'A modern multi-story complex housing a variety of retail outlets, fashion boutiques, and electronics stores. The mall includes a cinema, numerous dining options ranging from fast food to upscale restaurants.'
    },
    {
      'name': 'Yayasan Shopping Complex',
      'address': 'Jalan Pretty, Bandar Seri Begawan BS8711, Brunei Darussalam',
      'description': 'Located in the heart of the capital with scenic waterfront views near Omar Ali Saifuddien Mosque, this royal-owned shopping center offers a mix of local and international brands.'
    },
    {
      'name': 'OneCity Shopping Centre',
      'address': 'Jalan Utama Salambigar, Kampung Salambigar, Brunei Muara, Brunei Darussalam',
      'description': 'A newer addition to Brunei\'s retail landscape featuring a contemporary design with spacious walkways and natural lighting. The mall offers a diverse range of shops, a supermarket, and family entertainment facilities.'
    },
    {
      'name': 'The Airport Mall',
      'address': 'Jalan Lapangan Terbang Antarabangsa, Berakas, Bandar Seri Begawan, Brunei Darussalam',
      'description': 'Conveniently located near Brunei International Airport, this mall combines shopping and dining with practical services. It houses a Supa Save supermarket, various retail outlets, and electronic stores.'
    },
    {
      'name': 'Rimba Point',
      'address': 'Jalan Utama Rimba, Kampung Rimba, Gadong, Brunei Darussalam',
      'description': 'A community-focused suburban mall serving the Rimba residential area with essential services and retail outlets. The complex includes various specialty shops and dining establishments.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildPageHeader(context, 'Shops'),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: mallsData.length,
              itemBuilder: (context, index) {
                return ShopItem(
                  isEven: index % 2 == 0,
                  name: mallsData[index]['name'] ?? 'Shop Name',
                  address: mallsData[index]['address'] ?? 'Address',
                  description: mallsData[index]['description'] ?? 'Description',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Common AppBar for consistent UI across screens
PreferredSizeWidget _buildAppBar() {
  return AppBar(
    backgroundColor: const Color(0xFFF9C22E),
    elevation: 0,
    centerTitle: true,
    title: const Text(
      'BruRoam',
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'serif',
      ),
    ),
    leading: Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {},
        padding: EdgeInsets.zero,
        iconSize: 22,
      ),
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF9C22E),
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

// Common header for listing pages (Events, Shops)
Widget _buildPageHeader(BuildContext context, String title) {
  return Container(
    color: const Color(0xFFF9C22E), // Continue yellow background
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFD4BE7F), // Gold/tan color for button
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Icon(
            Icons.filter_list,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF9B208), // Slightly darker yellow for cards
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
              fontFamily: 'serif',
            ),
          ),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'serif',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final bool isEven;

  const EventItem({
    Key? key,
    required this.isEven,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isEven ? Colors.white : const Color(0xFFF9F9E0), // Alternating colors
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            width: 70,
            height: 70,
            color: const Color(0xFFD3D3D3), // Light gray for image placeholder
          ),
          const SizedBox(width: 15),
          // Event details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Event Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'See location',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShopItem extends StatelessWidget {
  final bool isEven;
  final String name;
  final String address;
  final String description;

  const ShopItem({
    Key? key,
    required this.isEven,
    required this.name,
    required this.address,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isEven ? Colors.white : const Color(0xFFF9F9E0), // Alternating colors
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Container(
            width: 70,
            height: 70,
            color: const Color(0xFFD3D3D3), // Light gray for image placeholder
          ),
          const SizedBox(width: 15),
          // Shop details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'See location',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'serif',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 35),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}