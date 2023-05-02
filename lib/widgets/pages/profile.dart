import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Pageprofile extends StatefulWidget {
  const Pageprofile({super.key});

  @override
  State<Pageprofile> createState() => _PageprofileState();
}

class _PageprofileState extends State<Pageprofile> {
  final ImagePicker _picker = ImagePicker();
  final ImagePicker picker = ImagePicker();
// Pick an image.
Future<XFile?> get image async {
  return await picker.pickImage(source: ImageSource.gallery);
}
// Capture a photo.
Future<XFile?> get photo async => await picker.pickImage(source: ImageSource.camera);
// Pick a video.
Future<XFile?> get galleryVideo async => await picker.pickVideo(source: ImageSource.gallery);
// Capture a video.
Future<XFile?> get cameraVideo async => await picker.pickVideo(source: ImageSource.camera);
// Pick multiple images.
Future<List<XFile>> get images async => await picker.pickMultiImage();
  void pickImage()async{
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(alignment: Alignment.center,
      child: Text('Helo profile'),),
    );
  }
}


