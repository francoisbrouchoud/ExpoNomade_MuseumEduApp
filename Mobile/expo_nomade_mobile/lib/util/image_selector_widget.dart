import 'package:expo_nomade_mobile/util/bo_editor_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../firebase_service.dart';

/// Class ImageSelectorWidget is used to display an image (if defined) and upload an image to set the value or update it.
class ImageSelectorWidget extends StatefulWidget {
  final String name;
  final String? url;
  final Function(String) urlChanged;

  /// Creates a new ImageSelectorWidget
  const ImageSelectorWidget(
      {super.key, required this.name, required this.urlChanged, this.url});

  @override
  _ImageSelectorWidgetState createState() => _ImageSelectorWidgetState();
}

/// State class for the ImageSelectorWidget
class _ImageSelectorWidgetState extends State<ImageSelectorWidget> {
  late String url;

  @override
  void initState() {
    super.initState();
    url = widget.url ?? "";
  }

  /// Opens a dialog to select the image file to upload and uploads it.
  Future<void> _pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final PlatformFile file = result.files.single;
      if (file.bytes != null && file.extension != null) {
        String imageUrl =
            await FirebaseService.uploadImage(file.bytes!, file.extension!);
        setState(() {
          url = imageUrl;
          widget.urlChanged(imageUrl);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const iconDim = 24.0; // TODO move this into globals
    return BOEditorBlockWidget(
      name: widget.name,
      children: [
        Row(
          children: [
            if (url.isNotEmpty)
              SizedBox(
                child: Image.network(url),
              ),
            IconButton(
              onPressed: _pickImageFile,
              icon: const Icon(
                Icons.upload_file,
                size: iconDim,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
