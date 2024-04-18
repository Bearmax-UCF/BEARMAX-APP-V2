import 'package:bearmax/model/notes_model.dart';
import 'package:bearmax/provider/notes_provider.dart';
import 'package:bearmax/screens/add_note.dart';
import 'package:bearmax/screens/view_note.dart';
import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notes when the screen is initialized
    Provider.of<NoteProvider>(context, listen: false).fetchAllNotes(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Notes'),
      ),
      body: Stack(children: [
        Consumer<NoteProvider>(
          builder: (context, noteProvider, child) {
            return ListView.builder(
              itemCount: noteProvider.notes.length,
              itemBuilder: (context, index) {
                Note note = noteProvider.notes[index];
                return singleNote(note);
              },
            );
          },
        ),
        Positioned(
          bottom: 30,
          right: 20,
          child: addNoteButton(),
        ),
      ]),
    );
  }

  // Display formatted time and preview of note
  Widget formattedPreview(Note note) {
    String substring = note.note;
    substring =
        note.note.length > 43 ? '${note.note.substring(0, 43)}...' : note.note;

    DateTime date = DateTime.parse(note.date);
    final formattedDate = DateFormat('M/dd/yyyy').format(date);

    return Text("$substring\n$formattedDate");
  }

  // Single note card display
  Widget singleNote(Note note) {
    return Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Container(
                height: 97,
                decoration: const BoxDecoration(
                  color: Palette.backgroundColor,
                  border: Border(
                      left: BorderSide(
                        color: Palette.grey,
                        width: 0.5,
                      ),
                      right: BorderSide(
                        color: Palette.grey,
                        width: 0.5,
                      ),
                      bottom: BorderSide(
                        color: Palette.grey,
                        width: 1,
                      )),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Palette.shadow,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3)),
                  ],
                ),
                child: ListTile(
                  title: Text(note.title,
                      style: const TextStyle(
                          color: Palette.black, fontWeight: FontWeight.bold)),
                  subtitle: formattedPreview(note),
                  isThreeLine: true,
                  onTap: () {
                    viewNotePopup(note);
                  },
                ),
              ),
              const SizedBox(height: 5)
            ]));
  }

  // View single note popup
  Future viewNotePopup(Note note) {
    return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext c) {
        return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: ViewNoteScreen(note: note));
      },
    );
  }

  // Add new note button
  Widget addNoteButton() {
    return ElevatedButton(
      onPressed: () {
        addNotePopup();
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          backgroundColor: Palette.accentColor,
          foregroundColor: Palette.accentColorTwo,
          shadowColor: Palette.darkShadow,
          elevation: 6),
      child: const Icon(Icons.add, size: 35.0, color: Palette.backgroundColor),
    );
  }

  // Add new note page
  Future addNotePopup() {
    return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext c) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: const ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            child: AddNotesScreen(),
          ),
        );
      },
    );
  }
}
