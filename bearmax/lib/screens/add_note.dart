import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/model/new_note_model.dart';
import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({Key? key}) : super(key: key);

  @override
  State<AddNotesScreen> createState() => _AddNotesScreen();
}

class _AddNotesScreen extends State<AddNotesScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('New Note', style: TextStyle(fontFamily: 'Roboto')),
          actions: <Widget>[saveButton()],
          shape:
              const Border(bottom: BorderSide(color: Palette.grey, width: 0.5)),
        ),
        body: SingleChildScrollView(
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
                child: Column(
                  children: [titleText(), bodyText()],
                ))));
  }

  Widget saveButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 13),
        child: SizedBox(
            width: 83,
            child: ElevatedButton(
                onPressed: () {
                  noteAPI();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Palette.accentColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                child: const Text('SAVE',
                    style: TextStyle(
                        color: Palette.backgroundColor,
                        fontFamily: 'Roboto')))));
  }

  void noteAPI() {
    NewNoteRequest newNoteRequest = NewNoteRequest(
        title: titleController.text,
        date: DateTime.now(),
        note: bodyController.text);

    ApiService apiService = ApiService();
    apiService.addNote(newNoteRequest, context).then((value) {
      if (value.statusCode == 200) {
        const snackBar = SnackBar(content: Text("Successfully Added Note"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(content: Text('Missing one or more fields'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Widget titleText() {
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              child: TextFormField(
            controller: titleController,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              hintText: 'Title',
              hintStyle: TextStyle(fontSize: 25.0),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true,
            ),
          )),
        ]));
  }

  Widget bodyText() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
              child: TextFormField(
            controller: bodyController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Add note',
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true,
            ),
          )),
        ]));
  }
}
