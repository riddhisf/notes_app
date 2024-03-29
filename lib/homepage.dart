import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'dart:developer';
import 'package:notes_app/addnotepage.dart';

class HomePage extends StatefulWidget {
  final List<Note> noteList;

  const HomePage({Key? key, required this.noteList}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 2;

  late List<Widget> bottomBarPages;

  @override
  void initState() {
    super.initState();
    bottomBarPages = [
      General(noteList: widget.noteList),
      const Favorite(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
  final List<Note> noteList;

  const General({Key? key, required this.noteList}) : super(key: key);

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  late List<Note> _noteList;

  @override
  void initState() {
    super.initState();
    _noteList = widget.noteList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.deepPurple.shade50,
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnotherPage(
                      noteList: _noteList,
                      onNotesAdded: (List<Note> newNotes) {
                        setState(() {
                          widget.noteList.addAll(newNotes);
                        });
                      }),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
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
        ),
        // Subsequent cards displaying title and date from the list
        Expanded(
          child: GridView.builder(
            itemCount: _noteList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 0,
                  color: Colors.deepPurple.shade50,
                  margin: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Handle tap on a note card
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _noteList[index].title,
                            style: TextStyle(
                              color: Colors.deepPurple[400],
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _noteList[index]
                                .date
                                .toString(), // Assuming date is formatted properly
                            style: TextStyle(
                              color: Colors.deepPurple[400],
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
