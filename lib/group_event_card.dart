import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'group_event.dart';

class GroupEventCard extends StatelessWidget {
  final GroupEvent group;
  final VoidCallback? onCardTap; // Add a callback for handling card taps

  const GroupEventCard({
    super.key,
    required this.group,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedMonth = DateFormat('MMMM').format(group.date);
    final String formattedMax = '${group.attendees}/${group.maxPax}';

    return GestureDetector(
      onTap: onCardTap, // Handle the card tap event
      child: Card(
        color: const Color(0xFFFFC107), // Yellow background
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location (Month) and attendees/max
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${group.location} ($formattedMonth)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formattedMax,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Duration
              Text(
                group.duration,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              // Description/Agenda
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text(
                  group.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 12),
              // Join Button
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (group.attendees < group.maxPax) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'You have joined the event at ${group.location}.'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('This group is already full'),
                        ),
                      );
                    }
                  },
                  child: const Text('Join'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}