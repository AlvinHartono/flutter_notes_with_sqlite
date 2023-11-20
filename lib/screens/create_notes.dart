import 'package:flutter/material.dart';
import 'package:projext/SQLite/db_helper.dart';
import 'package:projext/models/note.dart';
import 'package:projext/screens/notes_screen.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                db
                    .createNote(Note(
                        title: title.text,
                        content: content.text,
                        createdAt: DateTime.now().toIso8601String()))
                    .whenComplete(
                      () => Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                        builder: (context) => const Notes(),
                      )),
                    );
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            children: [
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                  label: Text("title"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  } else if (value.trim().length > 50) {
                    return "Title length is too long";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: content,
                maxLines: 10,
                decoration: const InputDecoration(
                  label: Text("Note Content"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  } else if (value.trim().length > 50) {
                    return "Title length is too long";
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
