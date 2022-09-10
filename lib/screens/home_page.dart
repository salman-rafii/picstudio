import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picstudio/screens/edit_image_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.upload_file),
          onPressed: () async {
            XFile? pickedImage =
                await ImagePicker().pickImage(source: ImageSource.gallery);

            if (pickedImage != null) {
              final route = MaterialPageRoute(builder: (context) {
                return EditImageScreen(selectedImage: pickedImage.path);
              });
              Navigator.push(context, route);
            }
          },
        ),
      ),
    );
  }
}
