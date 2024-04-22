import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/news_controller.dart';

class NewaUpdate extends StatefulWidget {
  @override
  _NewaUpdateState createState() => _NewaUpdateState();
}

class _NewaUpdateState extends State<NewaUpdate> {
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _newsDescriptionController = TextEditingController();
  XFile? _pickedImage;
  final NewsController _newsController = NewsController();

  void _pickImage() async {
    XFile? pickedImage = await _newsController.pickImage();
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Submission'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to submit the news?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _uploadNewsData();
              },
            ),
          ],
        );
      },
    );
  }

  void _uploadNewsData() async {
    final String headline = _headlineController.text.trim();
    final String newsDescription = _newsDescriptionController.text.trim();

    if (headline.isEmpty || newsDescription.isEmpty || _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all fields and upload an image.'),
      ));
      return;
    }

    _newsController.uploadNewsData(
      headline: headline,
      newsDescription: newsDescription,
      pickedImage: _pickedImage!,
      onSuccess: () {
        _headlineController.clear();
        _newsDescriptionController.clear();
        setState(() {
          _pickedImage = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('News uploaded successfully'),
        ));
      },
      onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Upload News', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _headlineController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Headline',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _newsDescriptionController,
                style: TextStyle(color: Colors.black),
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'News Description',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              SizedBox(height: 10),
              _pickedImage != null
                  ? Container(
                      height: 150,
                      child: Image.file(
                        File(_pickedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_headlineController.text.isNotEmpty &&
                      _newsDescriptionController.text.isNotEmpty &&
                      _pickedImage != null) {
                    _showConfirmationDialog();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please fill in all fields and upload an image.'),
                    ));
                  }
                },
                child: Text(
                  'Update News',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
