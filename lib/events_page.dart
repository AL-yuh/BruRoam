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
      home: const EventsPage(),
    );
  }
}

// Create a model class for events
class Event {
  final String name;
  final String date;
  final String description;
  final String location;
  final String imageUrl;

  Event({
    required this.name,
    required this.date,
    required this.description,
    required this.location,
    this.imageUrl = '', // Default empty as we don't have real images
  });
}

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of Brunei events
    final List<Event> events = [
      Event(
        name: 'Brunei Food Festival 2025',
        date: 'May 5-10, 2025',
        description: 'A week-long celebration of Bruneian cuisine featuring local vendors, cooking demonstrations, and cultural performances.',
        location: 'Jerudong Park Amphitheatre, Jerudong BG3122',
      ),
      Event(
        name: 'Islamic Book Fair',
        date: 'May 15-18, 2025',
        description: 'Annual exhibition showcasing Islamic literature, educational materials, and cultural items from around the Muslim world.',
        location: 'International Convention Centre, Berakas BB3713',
      ),
      Event(
        name: 'Brunei International Marathon',
        date: 'May 25, 2025',
        description: 'Annual running event with full marathon, half marathon, and 10K categories through scenic parts of Bandar Seri Begawan.',
        location: 'Starting point: Taman Haji Sir Muda Omar \'Ali Saifuddien, Bandar Seri Begawan BS8611',
      ),
      Event(
        name: 'Royal Brunei Armed Forces Exhibition',
        date: 'June 1-3, 2025',
        description: 'Military showcase displaying equipment, technology, and demonstrations celebrating Brunei\'s defense capabilities.',
        location: 'Hassanal Bolkiah National Stadium, Berakas BB3713',
      ),
      Event(
        name: 'Brunei Arts & Handicraft Festival',
        date: 'June 10-15, 2025',
        description: 'Exhibition featuring traditional Bruneian crafts including silverware, brassware, woodcarving, and textile weaving.',
        location: 'Brunei Arts and Handicraft Centre, Jalan Residency, Bandar Seri Begawan BS8111',
      ),
      Event(
        name: 'Brunei River Festival',
        date: 'June 20-22, 2025',
        description: 'Weekend celebration with boat races, floating market, cultural performances, and activities centered around Brunei\'s historic waterways.',
        location: 'Kampong Ayer Cultural & Tourism Gallery, Bandar Seri Begawan BS8711',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9C22E), // Yellow header
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
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFFF9C22E), // Continue yellow background
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4BE7F), // Gold/tan color for Events button
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Events',
                        style: TextStyle(
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
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventItem(
                  event: events[index],
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

class EventItem extends StatelessWidget {
  final Event event;
  final bool isEven;

  const EventItem({
    Key? key,
    required this.event,
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
          // Image placeholder with event icon
          Container(
            width: 70,
            height: 70,
            color: const Color(0xFFD3D3D3), // Light gray for image placeholder
            child: getEventIcon(event.name),
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
                    Flexible(
                      child: Text(
                        event.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Show location in a dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Location'),
                            content: Text(event.location),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text(
                        'See location',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  event.date,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 35,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.5), width: 1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    event.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
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

  // Helper method to get an appropriate icon based on the event name
  Widget getEventIcon(String eventName) {
    IconData iconData;
    
    if (eventName.contains('Food')) {
      iconData = Icons.restaurant;
    } else if (eventName.contains('Book')) {
      iconData = Icons.menu_book;
    } else if (eventName.contains('Marathon')) {
      iconData = Icons.directions_run;
    } else if (eventName.contains('Armed Forces') || eventName.contains('Military')) {
      iconData = Icons.military_tech;
    } else if (eventName.contains('Arts') || eventName.contains('Handicraft')) {
      iconData = Icons.palette;
    } else if (eventName.contains('River')) {
      iconData = Icons.water;
    } else {
      iconData = Icons.event;
    }
    
    return Center(
      child: Icon(
        iconData,
        size: 35,
        color: Colors.black54,
      ),
    );
  }
}