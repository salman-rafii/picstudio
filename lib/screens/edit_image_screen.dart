import 'dart:io';

import 'package:flutter/material.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({super.key, required this.selectedImage});
  final String selectedImage;

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.file(
        File(widget.selectedImage),
      ),
      floatingActionButton: _addNewTextFab,
    );
  }

  Widget get _addNewTextFab => FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        tooltip: "Add New Text",
        child: const Icon(
          Icons.edit,
          color: Colors.black,
        ),
      );
}
