import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final Map<String, String> userProfile;

  const UserProfilePage({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BruRoam'),
        backgroundColor: const Color(0xFFF2DC56),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF2DC56),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Avatar and Information
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xFFF2DC56).withOpacity(0.3),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Color.fromARGB(255, 229, 227, 213),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userProfile['name']}, ${userProfile['age']}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Nationality: ${userProfile['nationality'] ?? ''}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Contact: ${userProfile['contact'] ?? 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Location: ${userProfile['location'] ?? ''}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.star_border),
                  onPressed: () {
                    // Handle favorite action
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Description/Bio Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Text(
                  userProfile['about'] ?? 'No description provided.',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
