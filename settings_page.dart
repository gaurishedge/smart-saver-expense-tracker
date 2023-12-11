import 'package:SmartSaver/savings_page.dart';
import 'package:SmartSaver/summary_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_database/firebase_database.dart';

import 'expense_income.dart';
import 'home_page.dart';
FirebaseAuth auth = FirebaseAuth.instance;


class SettingsPage extends StatefulWidget {
  final firebase_auth.User? user = FirebaseAuth.instance.currentUser;


  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? displayName;
  String? phoneNumber;
  bool _isAboutUsExpanded = false;
  bool _isTermsExpanded = false;
  bool _isPrivacyExpanded = false ;
  bool _isContactUsExpanded = false ;
  int _bottomNavigationBarIndex = 3; // Index for the selected tab

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firebase Realtime Database
    _fetchUserData();
  }
  void _onBottomNavBarIndexChanged(int index) {
    setState(() {
      _bottomNavigationBarIndex = index;
      if (index == 3) {
        // If the "Settings" icon is clicked (index 3), navigate to the SettingsPage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SettingsPage(),
          ),
        );
      }
      if (index == 2) {
        // If the "Settings" icon is clicked (index 3), navigate to the SettingsPage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FinancialGoalsPage(),
          ),
        );
      }
      if (index == 1) {
        // If the "Settings" icon is clicked (index 3), navigate to the SettingsPage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IncomeExpenseAddPage(),
          ),
        );
      }
      if (index == 0) {
        // If the "Settings" icon is clicked (index 3), navigate to the SettingsPage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SummaryPage(),
          ),
        );
      }
    });
  }
  final List<Widget> _pages = [
    SummaryPage(), // Dashboard page
    //ExpensesIncomePage(), // Expenses/Income page
    // SavingsPage(), // Savings page
    SettingsPage(), // Settings page
  ];
  Future<void> _fetchUserData() async {
    try {
      // Get a reference to your Firebase Realtime Database instance
      FirebaseDatabase _database = FirebaseDatabase.instance;
      final DatabaseReference userReference =
      _database.ref().child('users/${widget.user?.uid}');

      // Listen to the once() event and get the DataSnapshot from the event
      final DataSnapshot snapshot = (await userReference.once()).snapshot;

      if (snapshot.value != null) {
        final userData = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          displayName = userData['name'] ?? 'N/A';
          phoneNumber = userData['phoneNumber'] ?? 'N/A';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Call _fetchUserData when the page is opened or dependencies change
    // This ensures that the user's details are updated when the page is displayed.
    _fetchUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3AA6B9),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            // User information section
            SizedBox(height:30),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xff3AA6B9),
                border: Border.all(color: Color(0xff3AA6B9)), // Border color
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Profile', // Heading
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 16),
                  // User information section
                  ListTile(
                    title: Text(
                      '$displayName',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    subtitle: Text(
                      '${widget.user?.email ?? 'N/A'}\n$phoneNumber',
                      style: TextStyle(
                        color: Color(0xffFFFFFF),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                ],

              ),

            ),
            // Rest of the settings page content outside the container
            Divider(),
            SizedBox(height:30),
            // About Us section (outside the container)
            _buildCollapsibleSection(
              title: 'About Us',
              isExpanded: _isAboutUsExpanded,
              onChanged: (isExpanded) {
                setState(() {
                  _isAboutUsExpanded = isExpanded;
                });
              },
              content: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        "Welcome to SmartSaver - Your Financial Companion\n\n"
                            "At SmartSaver, we're here to simplify your finances. Our app makes expense tracking, budgeting, and savings easy. Whether you're saving for a vacation or securing your financial future, SmartSaver is here to assist you every step of the way.\n\n"
                            "Thank you for choosing SmartSaver. Start saving smarter today!\n\n"
                            "Explore our features and feel free to reach out if you have any questions.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(0xff3AA6B9),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            _buildCollapsibleSection(
              title: 'Terms and Conditions',
              isExpanded: _isTermsExpanded,
              onChanged: (isExpanded) {
                setState(() {
                  _isTermsExpanded = isExpanded;
                });
              },
              content: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        "By using the Smart Saver app, you agree to the following terms and conditions:\n\n"
                            "1. Accountability: You are responsible for the accuracy of your financial data entered into the app.\n\n"
                            "2. Security: Protect your login credentials and personal information. Smart Saver is not responsible for unauthorized access.\n\n"
                            "3. Data Usage: Smart Saver securely stores your financial data for your use only. We do not share your data without your consent.\n\n"
                            "4. Accuracy: While we strive for accuracy, Smart Saver is not liable for any errors in financial calculations.\n\n"
                            "5. Compliance: Ensure compliance with local tax laws when using Smart Saver for tax purposes.\n\n"
                            "6. Feedback: We welcome feedback and suggestions to improve our services.\n\n"
                            "Please read these terms carefully and reach out to us if you have any questions.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(0xff3AA6B9),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            _buildCollapsibleSection(
              title: 'Privacy and Policy',
              isExpanded: _isPrivacyExpanded,
              onChanged: (isExpanded) {
                setState(() {
                  _isPrivacyExpanded = isExpanded;
                });
              },
              content: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        "Smart Saver Privacy Policy\n\n"
                            "Your privacy is important to us. Here's how we handle your data:\n\n"
                            "1. Data Collection: We collect and securely store financial data you enter into the Smart Saver app.\n\n"
                            "2. Data Usage: Your financial data is used solely for providing you with expense tracking and budgeting services.\n\n"
                            "3. Data Sharing: We do not share your financial data with third parties without your explicit consent.\n\n"
                            "4. Security: We employ industry-standard security measures to protect your data.\n\n"
                            "5. Cookies: Smart Saver may use cookies to enhance your user experience.\n\n"
                            "6. Contact: If you have concerns or questions about your data, please contact us.\n\n"
                            "By using Smart Saver, you agree to this Privacy Policy. We may update this policy periodically.\n\n"
                            "Thank you for choosing Smart Saver to manage your finances securely.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(0xff3AA6B9),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            _buildCollapsibleSection(
              title: 'Contact Us',
              isExpanded: _isContactUsExpanded,
              onChanged: (isExpanded) {
                setState(() {
                  _isContactUsExpanded = isExpanded;
                });
              },
              content: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        "Contact Smart Saver\n\n"
                            "If you have any questions, feedback, or need assistance, don't hesitate to reach out to us. We're here to help!\n\n"
                            "Email: support.smartsaver@gmail.com\n"
                            "Phone: +91 9823920630\n\n"
                            "You can also visit our website for more information: www.smartsaver.com\n\n"
                            "We value your feedback and are committed to providing the best user experience. Thank you for choosing Smart Saver!",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color(0xff3AA6B9),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


            Divider(),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _handleLogout(context);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size(300, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xff3AA6B9)),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavigationBarIndex,
        onTap: _onBottomNavBarIndexChanged,
        selectedItemColor: Color(0xff3AA6B9), // Change this color to your desired color
        unselectedItemColor: Color(0xff727272),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Expenses/Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance), // Icon for Savings
            label: 'Savings', // Label for Savings
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedLabelStyle: TextStyle(color: Color(0xff3AA6B9)),
        unselectedLabelStyle: TextStyle(color: Color(0xff727272)),
      ),
    );
  }

  Widget _buildCollapsibleSection({
    required String title,
    required bool isExpanded,
    required ValueChanged<bool> onChanged,
    required Widget content,
  }) {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        onChanged(!isExpanded);
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(title,
                style: TextStyle(
                  fontSize: 15, // Adjust the font size
                  fontWeight: FontWeight.w400,
                  color: Color(0xff3AA6B9), // Heading text color
                  fontFamily: 'Poppins',
                ),),
            );
          },
          body: content,
          isExpanded: isExpanded,
        ),
      ],
    );
  }

  void _handleLogout(BuildContext context) async {
    try {
      // Sign out the user using Firebase Authentication
      await FirebaseAuth.instance.signOut();
      setState(() {
        displayName = null;
        phoneNumber = null;
      });
      // Navigate back to the homepage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
