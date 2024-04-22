import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key});

  void _navigateToPage(BuildContext context, String pageName) {
    // Add your navigation logic here
    // Example: Navigator.pushNamed(context, '/$pageName');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('path_to_your_image'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your Profile Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.black),
            title: Text('Home', style: TextStyle(color: Colors.black)),
            onTap: () {
              _navigateToPage(context, 'Home');
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text('Profile', style: TextStyle(color: Colors.black)),
            onTap: () {
              _navigateToPage(context, 'Profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text('Settings', style: TextStyle(color: Colors.black)),
            onTap: () {
              _navigateToPage(context, 'Settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_sharp, color: Colors.black),
            title: Text('Log Out', style: TextStyle(color: Colors.black)),
            onTap: () {
              _navigateToPage(context, 'LogOut');
            },
          ),
        ],
      ),
    );
  }
}
