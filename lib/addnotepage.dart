import 'package:flutter/material.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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

class AnotherPage extends StatefulWidget {
  static const String routeName = 'another_page';

  const AnotherPage({Key? key}) : super(key: key);

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  List<Note> _noteList = [];

  void _addNoteToList() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        String title = _titleController.text;
        String text = _textController.text;

        Note newNote = Note(
          date: DateTime.now(),
          title: title,
          text: text,
        );

        _noteList.add(newNote);
        _titleController.clear();
        _textController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You cannot add an empty note'),
        ),
      );
    }
  }

  Widget float1() {
    return Container(
      child: FloatingActionButton(
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
        shape: CircleBorder(),
        heroTag: "add image",
        tooltip: 'Add Image',
        child: Icon(
          Icons.add_a_photo_rounded,
          color: Colors.deepPurple[400],
          size: MediaQuery.of(context).size.height * 0.04,
        ),
      ),
    );
  }

  Widget float2() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        elevation: 0,
        shape: CircleBorder(),
        heroTag: "add audio",
        tooltip: 'Add Audio',
        child: Icon(
          Icons.mic,
          color: Colors.deepPurple[400],
          size: MediaQuery.of(context).size.height * 0.04,
        ),
      ),
    );
  }

  Widget float3() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pick a color'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: Colors.black,
                    onColorChanged: (color) {
                      // Handle color change
                    },
                    showLabel: true, // Show color label
                    pickerAreaHeightPercent:
                        0.8, // Adjust the picker area height
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        elevation: 0,
        heroTag: "theme",
        shape: CircleBorder(),
        tooltip: 'Theme',
        child: Icon(
          Icons.color_lens,
          color: Colors.deepPurple[400],
          size: MediaQuery.of(context).size.height * 0.04,
        ),
      ),
    );
  }

  Widget float4() {
    return Container(
      child: FloatingActionButton(
        onPressed: null,
        elevation: 0,
        heroTag: "save",
        tooltip: 'Save',
        shape: CircleBorder(),
        child: Icon(
          Icons.download_rounded,
          color: Colors.deepPurple[400],
          size: MediaQuery.of(context).size.height * 0.04,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[100],
        iconTheme: IconThemeData(color: Colors.deepPurple[400]),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                'Add New Note',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.deepPurple[400],
                  fontSize: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
            ),
            IconButton(
              onPressed: _addNoteToList,
              icon: Icon(Icons.done),
              color: Colors.deepPurple[400],
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
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
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
              float4(),
            ],
            key: key,
            colorStartAnimation: Colors.deepPurple.shade400,
            colorEndAnimation: Colors.deepPurple.shade200,
            animatedIconData: AnimatedIcons.menu_close,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }
}
