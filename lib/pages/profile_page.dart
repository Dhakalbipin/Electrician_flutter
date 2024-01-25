import 'package:electrician/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Dismiss the dialog
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            // Sign out the user
                            await FirebaseAuth.instance.signOut();

                            // Close the current screen
                            Navigator.of(context).pop();

                            // Navigate to the login page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );

                            // Show a success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Logout successful!'),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } catch (e) {
                            print('Error during logout: $e');

                            // Show an error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Logout failed. Please try again.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                'https://th.bing.com/th/id/OIP.cF-R8IXSTnyXbbemr5Kd3gAAAA?pid=ImgDet&w=179&h=179&c=7',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Admin',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(
                Icons.call,
                color: Color(0xFF584846),
              ),
              title: Text(
                'Phone Number',
                style: TextStyle(
                  color: Color(0xFF584846),
                  fontFamily: 'Montserrat',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '+ 977 9843018218',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.mail,
                color: Color(0xFF584846),
              ),
              title: Text(
                'Email',
                style: TextStyle(
                  color: Color(0xFF584846),
                  fontFamily: 'Montserrat',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'admin@gmail.com',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
