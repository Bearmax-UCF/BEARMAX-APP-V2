import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/model/notes_model.dart';
import 'package:bearmax/screens/home_screen.dart';
import 'package:bearmax/screens/notes_screen.dart';
import 'package:bearmax/util/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewNoteScreen extends StatefulWidget {
  final Note note;
  const ViewNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<ViewNoteScreen> createState() => _ViewNoteScreen();
}

class _ViewNoteScreen extends State<ViewNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool isTitleChanged = false;
  bool isBodyChanged = false;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note.title;
    titleController.addListener(_onTitleChanged);

    bodyController.text = widget.note.note;
    bodyController.addListener(_onBodyChanged);
  }

  void _onTitleChanged() {
    if (!isTitleChanged) {
      setState(() {
        isTitleChanged = true;
      });
    }
  }

  void _onBodyChanged() {
    if (!isBodyChanged) {
      setState(() {
        isBodyChanged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Note note = widget.note;
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).padding.right * 0.001,
                  left: MediaQuery.of(context).padding.left * 0.001),
              child: IconButton(
                onPressed: () {
                  deleteAlert();
                },
                iconSize: 28,
                color: Palette.red,
                icon: const Icon(Icons.delete_outline),
              ),
            )
          ],
        ),
        body: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Stack(children: [
              Column(children: [
                formattedDate(note),
                const SizedBox(height: 5),
                titleField(note),
                const SizedBox(height: 5),
                bodyField(note),
              ]),
              Positioned(
                bottom: 30,
                right: 20,
                child: editNoteButton(titleController, bodyController,
                    isTitleChanged, isBodyChanged, note),
              ),
            ])));
  }

  // Save button
  Widget editNoteButton(
      TextEditingController titleController,
      TextEditingController bodyController,
      bool isTitleChanged,
      bool isBodyChanged,
      Note note) {
    return ElevatedButton(
      onPressed: () {
        if (isTitleChanged || isBodyChanged) {
          EditNoteRequest editNoteRequest = EditNoteRequest(
              title: titleController.text, note: bodyController.text);
          ApiService apiService = ApiService();

          apiService.editNote(editNoteRequest, context, note.id).then((value) {
            if (kDebugMode) {
              print(note.id);
              print(titleController.text);
              print(bodyController.text);
            }

            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotesScreen()),
            );
          });
        } else {
          const snackBar =
              SnackBar(content: Text('Missing at least one field'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          backgroundColor: Palette.accentColor,
          foregroundColor: Palette.accentColorTwo,
          shadowColor: Palette.darkShadow,
          elevation: 6),
      child:
          const Icon(Icons.save_as_outlined, size: 35.0, color: Colors.white),
    );
  }

  // Body text editor
  Widget bodyField(Note note) {
    return TextFormField(
      controller: bodyController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        isDense: true,
      ),
    );
  }

  // Title field
  Widget titleField(Note note) {
    return TextFormField(
      controller: titleController,
      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        isDense: true,
      ),
    );
  }

  // Format date for display
  Widget formattedDate(Note note) {
    DateTime date = DateTime.parse(note.date);
    final formatDate = DateFormat('M/dd/yyyy h:mm a').format(date);

    return Text(formatDate,
        style: const TextStyle(
            fontFamily: 'Roboto', fontSize: 14, color: Palette.darkShadow));
  }

  // Delete alert
  Future<void> deleteAlert() async {
    String note = widget.note.id;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete Note',
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "Are you sure you want to delete this note? This cannot be undone.",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child:
                  const Text('Cancel', style: TextStyle(color: Palette.blue)),
            ),
            TextButton(
              onPressed: () {
                ApiService apiService = ApiService();

                apiService.deleteNote(context, note).then((value) {
                  if (value.statusCode == 200) {
                    Navigator.pop(context);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomePage(initialIndex: 0)),
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    Navigator.pop(context);
                    const snackBar = SnackBar(content: Text('Invalid'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Palette.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
