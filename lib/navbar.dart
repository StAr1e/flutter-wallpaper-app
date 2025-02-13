import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/aboutus.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('BALOCHIFY'),
            accountEmail: const Text(''),
            currentAccountPicture: CircleAvatar(
              radius: 30, // Smaller size
              backgroundColor: Colors.white, // Added background color
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/images/icons/applogo.png'),
                  fit: BoxFit.contain, // Adjusted to make image smaller
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/images/Beach/b5.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () async {
              // Open sharing options
              await Share.share(
                  'Check out this app!'); // You can customize the message
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context); // Close drawer before navigating
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Rate App'),
            onTap: () async {
              // Launch the app store link for rating (Google Play Store or Apple App Store)
              const url =
                  'https://play.google.com/store/apps/details?id=com.example.app'; // Replace with your app's link
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.pop(context); // Close drawer before exiting
            },
          ),
        ],
      ),
    );
  }
}
