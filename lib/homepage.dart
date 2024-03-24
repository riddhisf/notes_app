import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> cards = []; // List to hold cards

  @override
  void initState() {
    super.initState();
    cards.add(
      Card(
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
            ),
            color: Colors.deepPurple[400],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        iconTheme:
            IconThemeData(color: Colors.deepPurple[400]), // Set icon color here
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
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        children: cards, // Display cards from the list
      ),
    );
  }
}
