import 'package:flutter/material.dart';
import 'group_event.dart';
import 'group_event_card.dart';
import 'host_event_page.dart';
import 'event_details_page.dart'; // Import the EventDetailsPage
import 'package:intl/intl.dart';

class GroupListPage extends StatefulWidget {
  final List<GroupEvent> events;
  final dateFormat = DateFormat('dd MMM yyyy');
  
  GroupListPage({super.key, required this.events});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  final List<GroupEvent> _events = [
    GroupEvent(
      location: 'Freme Lodge, Temburong',
      date: DateTime(2025, 5, 12),
      duration: '3 days',
      description: 'Enjoy a scenic adventure in Temburong!',
      attendees: 3,
      maxPax: 10,
      chatRoomLink: ''
    ),
    GroupEvent(
      location: 'Butterfly Garden, Tutong',
      date: DateTime(2025, 6, 25),
      duration: '1 day',
      description: 'A relaxing day surrounded by nature.',
      attendees: 5,
      maxPax: 8,
      chatRoomLink: ''
    ),
  ];

  void _addEvent(GroupEvent event) {
    setState(() {
      _events.add(event);
    });
  }

  void _navigateToDetailsPage(GroupEvent event) async {
    final hasJoined = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(event: event),
      ),
    );

    if (hasJoined == true) {
      setState(() {
        // Increment attendees if the user joined the event
        event.attendees++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'BruRoam',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Column(
        children: [
          // Host Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE4D192),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                final newEvent = await Navigator.push<GroupEvent>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HostEventPage(),
                  ),
                );

                if (newEvent != null) {
                  _addEvent(newEvent); // Dynamically add the new event
                }
              },
              child: const Text(
                'Host',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // List of Group Event Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                return GroupEventCard(
                  group: _events[index],
                  onCardTap: () => _navigateToDetailsPage(_events[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}