import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'dart:developer';
import 'package:notes_app/addnotepage.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 2;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const General(),
    const Favorite(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        iconTheme: IconThemeData(color: Colors.deepPurple[400]),
        title: Row(
          children: [
            Text(
              'My Notes ',
              style: TextStyle(
                color: Colors.deepPurple[400],
                fontSize: MediaQuery.of(context).size.height * 0.04,
              ),
            ),
            Icon(
              CupertinoIcons.heart_fill,
              color: Colors.deepPurple[400],
              size: MediaQuery.of(context).size.height * 0.04,
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
          (index) => bottomBarPages[index],
        ),
      ),
      extendBody: false,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.deepPurple.shade100,
              showLabel: false,
              shadowElevation: 0,
              kBottomRadius: 10.0,
              notchColor: Colors.deepPurple.shade300,
              removeMargins: false,
              bottomBarWidth: MediaQuery.of(context).size.width,
              showShadow: true,
              durationInMilliSeconds: 300,
              elevation: 0,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  itemLabel: 'General',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  itemLabel: 'Favorite',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: MediaQuery.of(context).size.height * 0.045,
            )
          : null,
    );
  }
}

class General extends StatefulWidget {
  const General({Key? key}) : super(key: key);

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Number of columns in the grid
      children: [
        CardItem(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AnotherPage(),
              ),
            );
          },
        ),
      ], // Display cards from the list
    );
  }
}

class CardItem extends StatelessWidget {
  final VoidCallback onPressed;

  const CardItem({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.deepPurple.shade50,
      margin: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.deepPurple[400],
              ),
              const SizedBox(height: 8),
              Text(
                'Add Note',
                style: TextStyle(
                  color: Colors.deepPurple[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(child: Text('Favorite')),
    );
  }
}
