import 'package:flutter/material.dart';
import 'package:notes_app/addnotepage.dart';
import 'package:notes_app/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Note> noteList = []; // Define a dummy list of notes

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: SafeArea(
          child: Builder(
            builder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hi! Welcome to Notes',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontFamily: 'Roboto',
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/star.png',
                        height: MediaQuery.of(context).size.height * 0.525,
                        fit: BoxFit.cover,
                        color: Colors.black12,
                      ),
                      Image.asset(
                        'assets/star.png',
                        height: MediaQuery.of(context).size.height * 0.515,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(noteList: noteList)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                          MediaQuery.of(context).size.height * 0.1),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple[300],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue  ',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.05),
                        ),
                        Icon(
                          Icons.arrow_circle_right_rounded,
                          size: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
