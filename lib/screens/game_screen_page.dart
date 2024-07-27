import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final Map<String, String> selectedAvatar;

  const GameScreen({super.key, required this.selectedAvatar});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String selectedCategory = 'dress';
  Map<String, Offset> itemPositions = {};
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/images/background/background.png'),
            height: height,
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Image.asset(
                    widget.selectedAvatar['image']!,
                    height: 430,
                    width: 300,
                  ),
                ),
                SizedBox(height: 10),
                CustomContainer(width, height, selectedCategory),
              ],
            ),
          ),
          ..._buildItemWidgets('shoes'),
          ..._buildItemWidgets('pants'),
          ..._buildItemWidgets('shirts'),
          ..._buildItemWidgets('dress'),
        ],
      ),
    );
  }

  List<Widget> _buildItemWidgets(String category) {
    return itemPositions.entries
        .where((entry) => entry.key.contains(category))
        .map((entry) {
      var clothesItem = getClothesItemByPath(entry.key);
      return Positioned(
        left: entry.value.dx,
        top: entry.value.dy,
        child: Draggable(
          data: entry.key,
          feedback: Image.asset(entry.key,
              width: clothesItem['width'], height: clothesItem['height']),
          childWhenDragging: Container(),
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              itemPositions[entry.key] = offset;
            });
          },
          child: Image.asset(entry.key,
              width: clothesItem['width'], height: clothesItem['height']),
        ),
      );
    }).toList();
  }

  Widget CustomContainer(double width, double height, String category) {
    List<Map<String, dynamic>> clothes = clothesByCategory(category);
    return Container(
      height: 220,
      width: width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.pink,
                ),
                width: width,
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: clothes.map((clothesItem) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Draggable(
                        data: clothesItem['path'],
                        feedback: Image.asset(clothesItem['path'],
                            width: 100, height: 100),
                        childWhenDragging: Container(),
                        onDraggableCanceled: (velocity, offset) {
                          setState(() {
                            manageSelections(clothesItem['path']);
                            itemPositions[clothesItem['path']] = offset;
                          });
                        },
                        child: Image.asset(
                          clothesItem['path'],
                          width: 100,
                          height: 100,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 30,
            left: 30,
            child: Container(
              height: 100.0,
              width: width / 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: menuCategories(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void manageSelections(String newItem) {
    if (newItem.contains('dress')) {
      selectedItems.removeWhere(
          (item) => item.contains('shirts') || item.contains('pants'));
      selectedItems.removeWhere((item) => item.contains('dress'));
    } else if (newItem.contains('pants')) {
      selectedItems.removeWhere((item) => item.contains('dress'));
      selectedItems.removeWhere((item) => item.contains('pants'));
    } else if (newItem.contains('shirts')) {
      selectedItems.removeWhere((item) => item.contains('dress'));
      selectedItems.removeWhere((item) => item.contains('shirts'));
    } else if (newItem.contains('shoes')) {
      selectedItems.removeWhere((item) => item.contains('shoes'));
    }

    selectedItems.add(newItem);
    itemPositions.removeWhere((key, value) => !selectedItems.contains(key));
  }

  Widget menuCategories() {
    return Row(
      children: [
        buildCategoryCard('dress', 'assets/images/icons/12.png'),
        buildCategoryCard('shirts', 'assets/images/icons/15.png'),
        buildCategoryCard('pants', 'assets/images/icons/13.png'),
        buildCategoryCard('shoes', 'assets/images/icons/14.png'),
      ],
    );
  }

  Widget buildCategoryCard(String text, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = text;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(),
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      imagePath,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
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

  List<Map<String, dynamic>> clothesByCategory(String category) {
    switch (category) {
      case 'dress':
        return [
          {
            'path': 'assets/images/clothes/dress/17.png',
            'width': 200.0,
            'height': 200.0
          },
          {
            'path': 'assets/images/clothes/dress/18.png',
            'width': 200.0,
            'height': 200.0
          },
          {
            'path': 'assets/images/clothes/dress/19.png',
            'width': 200.0,
            'height': 200.0
          },
          {
            'path': 'assets/images/clothes/dress/20.png',
            'width': 200.0,
            'height': 200.0
          },
        ];
      case 'shirts':
        return [
          {
            'path': 'assets/images/clothes/shirts/25.png',
            'width': 128.0,
            'height': 180.0
          },
          {
            'path': 'assets/images/clothes/shirts/26.png',
            'width': 130.0,
            'height': 190.0
          },
          {
            'path': 'assets/images/clothes/shirts/31.png',
            'width': 128.0,
            'height': 180.0
          },
          {
            'path': 'assets/images/clothes/shirts/32.png',
            'width': 130.0,
            'height': 190.0
          },
          {
            'path': 'assets/images/clothes/shirts/33.png',
            'width': 128.0,
            'height': 180.0
          },
          {
            'path': 'assets/images/clothes/shirts/34.png',
            'width': 130.0,
            'height': 190.0
          },
          {
            'path': 'assets/images/clothes/shirts/35.png',
            'width': 128.0,
            'height': 180.0
          },
          {
            'path': 'assets/images/clothes/shirts/36.png',
            'width': 130.0,
            'height': 190.0
          },
          {
            'path': 'assets/images/clothes/shirts/37.png',
            'width': 140.0,
            'height': 190.0
          },
          {
            'path': 'assets/images/clothes/shirts/38.png',
            'width': 140.0,
            'height': 190.0
          },
          {
            'path': 'assets/images/clothes/shirts/39.png',
            'width': 128.0,
            'height': 180.0
          },
          {
            'path': 'assets/images/clothes/shirts/40.png',
            'width': 130.0,
            'height': 130.0
          },
        ];
      case 'pants':
        return [
          {
            'path': 'assets/images/clothes/pants/21.png',
            'width': 100.0,
            'height': 200.0
          },
          {
            'path': 'assets/images/clothes/pants/22.png',
            'width': 120.0,
            'height': 220.0
          },
          {
            'path': 'assets/images/clothes/pants/23.png',
            'width': 140.0,
            'height': 210.0
          },
          {
            'path': 'assets/images/clothes/pants/24.png',
            'width': 110.0,
            'height': 200.0
          },
          {
            'path': 'assets/images/clothes/pants/25.png',
            'width': 190.0,
            'height': 230.0
          },
          {
            'path': 'assets/images/clothes/pants/26.png',
            'width': 110.0,
            'height': 230.0
          },
          {
            'path': 'assets/images/clothes/pants/27.png',
            'width': 110.0,
            'height': 230.0
          },
          {
            'path': 'assets/images/clothes/pants/28.png',
            'width': 190.0,
            'height': 230.0
          },
        ];
      case 'shoes':
        return [
          {
            'path': 'assets/images/clothes/shoes/27.png',
            'width': 160.0,
            'height': 160.0
          },
          {
            'path': 'assets/images/clothes/shoes/28.png',
            'width': 160.0,
            'height': 160.0
          },
          {
            'path': 'assets/images/clothes/shoes/29.png',
            'width': 160.0,
            'height': 160.0
          },
          {
            'path': 'assets/images/clothes/shoes/30.png',
            'width': 160.0,
            'height': 160.0
          },
          {
            'path': 'assets/images/clothes/shoes/31.png',
            'width': 135.0,
            'height': 135.0
          },
          {
            'path': 'assets/images/clothes/shoes/32.png',
            'width': 140.0,
            'height': 140.0
          },
          {
            'path': 'assets/images/clothes/shoes/33.png',
            'width': 140.0,
            'height': 140.0
          },
          {
            'path': 'assets/images/clothes/shoes/34.png',
            'width': 125.0,
            'height': 125.0
          },
          {
            'path': 'assets/images/clothes/shoes/35.png',
            'width': 125.0,
            'height': 125.0
          },
          // Add more shoes images
        ];

      default:
        return [];
    }
  }

  Map<String, dynamic> getClothesItemByPath(String path) {
    // Get the item details (width, height) by its path
    List<Map<String, dynamic>> allClothes = [
      ...clothesByCategory('dress'),
      ...clothesByCategory('shirts'),
      ...clothesByCategory('pants'),
      ...clothesByCategory('shoes'),
    ];

    return allClothes.firstWhere((item) => item['path'] == path);
  }
}
