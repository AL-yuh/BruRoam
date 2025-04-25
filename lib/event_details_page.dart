import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for handling hyperlinks
import 'group_event.dart';

class EventDetailsPage extends StatefulWidget {
  final GroupEvent event;

  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool _hasJoined = false;

  // Function to open the chat room link
  Future<void> _openChatRoomLink() async {
    final Uri url = Uri.parse(widget.event.chatRoomLink);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the chat room link'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Function to handle leaving the event
  void _leaveEvent() {
    // Ensure attendees are not decremented below 1
    if (widget.event.attendees > 1) {
      setState(() {
        widget.event.attendees--;
        _hasJoined = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have left this event.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot leave. At least one attendee (host) must remain.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Return whether the user joined or not
            Navigator.pop(context, _hasJoined);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color(0xFFFFC107),
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.event.location,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.event.attendees}/${widget.event.maxPax} pax',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date: ${widget.event.date.day}/${widget.event.date.month}/${widget.event.date.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Duration: ${widget.event.duration}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              'Description/Itinerary:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.event.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Chat Room Link
            Row(
              children: [
                const Text(
                  'Chat Room:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _openChatRoomLink,
                  child: Text(
                    widget.event.chatRoomLink,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Join and Leave Buttons
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_hasJoined)
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: widget.event.attendees < widget.event.maxPax
                            ? () async {
                                setState(() {
                                  widget.event.attendees++;
                                  _hasJoined = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'You have joined this event! Redirecting to chat room...'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                await Future.delayed(
                                    const Duration(seconds: 2)); // Wait for Snackbar
                                _openChatRoomLink(); // Redirect to the chat room
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Join',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  if (_hasJoined)
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: _leaveEvent,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.red, // Red button for Leave
                        ),
                        child: const Text(
                          'Leave',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}