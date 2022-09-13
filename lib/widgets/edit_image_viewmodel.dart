import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:picstudio/model/text_info.dart';
import 'package:picstudio/screens/edit_image_screen.dart';
import 'package:picstudio/utils/request_permission.dart';
import 'package:picstudio/widgets/default_button.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';

abstract class EditImageViewModel extends State<EditImageScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> texts = [];
  int currentIndex = 0;

// funcion to save image to gallery
  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery.'),
          ),
        );
      }).catchError((err) => print(err));
    }
  }


// function to save image
  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Selected For Styling',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  // Text function
  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
            text: _textController.text,
            left: 0,
            top: 0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20.0,
            fontStyle: FontStyle.normal,
            textAlign: TextAlign.left),
      );
    });
    Navigator.pop(context);
  }

  // dialog to add text
  addNewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Add New Text"),
        content: TextField(
          controller: _textController,
          maxLines: 5,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit),
              filled: true,
              hintText: "Your Text Here"),
        ),
        actions: <Widget>[
          DefaultButton(
            onPressed: () {
              print("Pressing back");
              Navigator.pop(context);
            },
            bgColor: Colors.red,
            textColor: Colors.white,
            child: const Text("Back"),
          ),
          DefaultButton(
            onPressed: () => addNewText(context),
            bgColor: Colors.red,
            textColor: Colors.white,
            child: const Text("Add Text"),
          )
        ],
      ),
    );
  }
}
