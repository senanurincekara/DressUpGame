import 'package:dress_up_game/screens/game_screen_page.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> avatars = [
      {
        'image': 'assets/images/avatars/girl_avatar.png',
        'label': 'Girl Avatar',
      },
      {
        'image': 'assets/images/avatars/boy_avatar.png',
        'label': 'Boy Avatar',
      },
    ];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 155, 195),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
            ),
            card(avatars),
            Container(
              padding: EdgeInsets.only(top: 50, bottom: 50),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Choose your character",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final selectedAvatar = avatars[_currentIndex];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(selectedAvatar: selectedAvatar),
                        ),
                      );
                      print('Selected Avatar: ${selectedAvatar['label']}');
                    },
                    child: Icon(Icons.keyboard_double_arrow_right_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget card(List<Map<String, String>> avatars) {
    return Container(
      height: 500, // Adjust this height as needed
      child: PageView.builder(
        itemCount: avatars.length,
        controller: PageController(viewportFraction: 0.8),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Transform.scale(
            scale: index == _currentIndex ? 1 : 0.92,
            child: Card(
              elevation: 4,
              color: Color.fromARGB(255, 253, 222, 239),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    avatars[index]['image']!,
                    height: 480,
                    width: 300,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
