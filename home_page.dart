import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'login_page.dart';
import 'summary_page.dart'; // Import your SummaryPage widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff046380), // Set background color using hex code
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/smart_icon.png', width: 600, height: 400),
            SizedBox(height: 10),
            Text(
              "Start your journey towards financial wellness with our expense tracker.\n'Expense Wise, Savings Rise'",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Check if the user is already logged in
                final User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  // User is logged in, navigate to the summary page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SummaryPage()),
                  );
                } else {
                  // User is not logged in, navigate to the login page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Adjust the value for the desired roundness
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size(300, 50)), // Adjust the width and height
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set your desired button color
              ),
              child: Text('Get Started',
                style: TextStyle(
                    color: Color(0xff046380),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
