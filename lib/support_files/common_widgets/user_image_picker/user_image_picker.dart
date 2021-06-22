import 'dart:io';
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_authentication/support_files/common_widgets/custom_image_loader.dart';
import 'package:user_authentication/support_files/common_widgets/user_image_picker/web_image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final String? imageUrl;
  final Function()? onImageClick;

  UserImagePicker(this.imagePickFn, {this.imageUrl, this.onImageClick});

  final void Function(dynamic pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  // html.File? _pickedImage;
  File? selectedImageFile;
  Uint8List? imageFileBytes;

  void _pickImage() async {
    var picker = ImagePicker();
    var pickedImage;
    if (kIsWeb) {
      // var mediaData = await ImagePickerWeb.getImageInfo;
      // html.File pickedImageFile = new html.File(
      //     mediaData.data!, mediaData.fileName!, {'type': 'image/jpg'});
      pickedImage = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );
      imageFileBytes = await pickedImage.readAsBytes();
      setState(() {
        // _pickedImage = pickedImageFile;
      });
      widget.imagePickFn(imageFileBytes);
    } else {
      pickedImage = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150,
      );
      final pickedImageFile = File(pickedImage!.path);
      imageFileBytes = await pickedImage.readAsBytes();

      setState(() {
        selectedImageFile = pickedImageFile;
      });
      widget.imagePickFn(selectedImageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: null,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: _getUserImage())),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text(widget.imageUrl != null ? "Change Image" : "Add Image"),
        ),
      ],
    );
  }

  Widget _getUserImage() {
    if (imageFileBytes != null) {
      return Image.memory(
        imageFileBytes!,
        fit: BoxFit.cover,
      );
    } else {
      if (widget.imageUrl != null) {
        return CustomImageLoaderWidget(imageUrl: widget.imageUrl!);
      } else {
        return Container();
      }
    }
  }

  // Future<File> convertHtmFileToIOFile(html.File file) async {
  //   final reader = html.FileReader();
  //   reader.readAsDataUrl(file);

  //   final res = await reader.onLoad.first;
  //   final encoded = reader.result as String;
  // final imageBase64 = encoded.replaceFirst(
  //     RegExp(r'data:application/[^;]+;base64,'),
  //     ''); // this is to remove some non necessary stuff
  //   File _itemPicIoFile = File.fromRawPath(base64Decode(encoded));
  //   return _itemPicIoFile;
  // }
}
