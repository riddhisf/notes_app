import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:circular_menu/circular_menu.dart';

class Note {
  final DateTime date;
  final String title;
  final String text;

  Note({
    required this.date,
    required this.title,
    required this.text,
  });
}

Color _selectedColor = Colors.deepPurple[400]!;

class AnotherPage extends StatefulWidget {
  static const String routeName = 'another_page';
  final List<Note> noteList;

  final void Function(List<Note>) onNotesAdded;

  const AnotherPage({
    Key? key,
    required this.noteList,
    required this.onNotesAdded,
  }) : super(key: key);

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final List<Note> _noteList = [];

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      Note newNote = Note(
        date: DateTime.now(),
        title: _titleController.text,
        text: _textController.text,
      );
      _noteList.add(newNote);

      // Call the callback function to pass the new list of notes back to HomePage
      widget.onNotesAdded(_noteList);

      Navigator.pop(context); // Navigate back to the HomePage
    } else {
      // If form is not valid, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fields'),
        ),
      );
    }
  }

  Widget float1() {
    return FloatingActionButton(
      onPressed: () async {
        XFile? image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          setState(() {
            _textController.text += '${image.path}\n';
          });
        }
      },
      elevation: 0,
      shape: const CircleBorder(),
      backgroundColor: _selectedColor.withOpacity(0.1),
      hoverColor: _selectedColor.withOpacity(0.2),
      heroTag: "add image",
      tooltip: 'Add Image',
      child: Icon(
        Icons.add_a_photo_rounded,
        color: _selectedColor,
        size: MediaQuery.of(context).size.height * 0.04,
      ),
    );
  }

  Widget float2() {
    return FloatingActionButton(
      hoverColor: _selectedColor.withOpacity(0.2),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const CircleBorder(),
              alignment: Alignment.center,
              content: CircularMenu(
                alignment: Alignment.center,
                backgroundWidget: Container(
                  color: Colors.transparent,
                ),
                toggleButtonColor: _selectedColor.withOpacity(0.8),
                toggleButtonSize: MediaQuery.of(context).size.height * 0.05,
                items: [
                  CircularMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedColor = Colors.white;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                  ),
                  CircularMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedColor = Colors.amber;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.amber,
                  ),
                  CircularMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedColor = Colors.deepOrange;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.deepOrange,
                  ),
                  CircularMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedColor = Colors.red;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.red,
                  ),
                  CircularMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedColor = Colors.pink;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.pink,
                  ),
                  CircularMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedColor = Colors.deepPurple;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.deepPurple,
                  ),
                  CircularMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedColor = Colors.blue;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.blue,
                  ),
                  CircularMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedColor = Colors.teal;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.teal,
                  ),
                  CircularMenuItem(
                    onTap: () {
                      setState(() {
                        _selectedColor = Colors.green;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.green,
                  ),
                ],
              ),
            );
          },
        );
      },
      elevation: 0,
      shape: const CircleBorder(),
      backgroundColor: _selectedColor.withOpacity(0.1),
      heroTag: "theme",
      tooltip: 'Theme',
      child: Icon(
        Icons.color_lens,
        color: _selectedColor,
        size: MediaQuery.of(context).size.height * 0.04,
      ),
    );
  }

  Widget float3() {
    return FloatingActionButton(
      onPressed: null,
      backgroundColor: _selectedColor.withOpacity(0.1),
      hoverColor: _selectedColor.withOpacity(0.2),
      elevation: 0,
      heroTag: "save",
      tooltip: 'Save',
      shape: const CircleBorder(),
      child: Icon(
        Icons.download_rounded,
        color: _selectedColor,
        size: MediaQuery.of(context).size.height * 0.04,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _selectedColor.withOpacity(0.1),
        iconTheme: IconThemeData(color: _selectedColor),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                'Add New Note',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: _selectedColor,
                  fontSize: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
            ),
            IconButton(
              onPressed: _saveNote,
              icon: const Icon(Icons.done),
              color: _selectedColor,
              iconSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter title...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Enter text...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: HeroMode(
        child: Positioned(
          bottom: 10,
          right: 10,
          child: AnimatedFloatingActionButton(
            fabButtons: <Widget>[
              float1(),
              float2(),
              float3(),
            ],
            key: key,
            animatedIconData: AnimatedIcons.menu_close,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _textController.dispose();
  }
}
