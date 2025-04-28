import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2DC56), // Yellow background color
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            
            // Logo would go here
            const SizedBox(height: 100), // Space for logo
            
            const Spacer(),
            
            // Welcome text
            const Text(
              "Hello.",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            
            const Text(
              "Welcome !",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            
            const Spacer(flex: 2),
            
            // Let's Start button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the next screen
                    Navigator.pushNamed(context, '/language');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Gold button color to match your app theme
                    foregroundColor: const Color(0xFFF2DC56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 2,
                  ),
                  child: 
                  const Text("Let's Start"),
                ),
              ),
            ),
            
            const SizedBox(height: 50), // Bottom spacing
          ],
        ),
      ),
    );
  }
}
