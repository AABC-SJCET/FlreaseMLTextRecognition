import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mltext/provider/imageUplod.dart';
import 'package:mltext/screen/textToSpeech.dart';
import 'package:mltext/utils/loading.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late File _image = File("");

  // final picker = ImagePicker();
  final _picker = ImagePicker();
  Future getImage(ImageSource source) async {
    try {
      PickedFile? pickedFile = await _picker.getImage(
        source: source,
        // imageQuality: 75,
        // maxHeight: 300,
        // maxWidth: 400,
      );

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          print('image selected.');
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future getText() async {
  try{  if (_image.path.isNotEmpty) {
      loading(context);
      final ctText = await upload(_image);
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => TextToSpeech(
                scanText: ctText,
              )));
    } else {
      popUpwithButton(context,
          title: "No Image", body: "Select an Image to continue");
    }}catch(e){
      Navigator.of(context).pop();
       popUpwithButton(context,
          title: "Opps!", body: "An Erroor occured!");
    }
  }
@override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bootomButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: scanAction(),
      appBar: AppBar(
        title: Text(
          "Scan Image",
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: _image.path.isEmpty
            ? Text(
                'No image selected.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            : Container(
                height: height / 2,
                width: MediaQuery.of(context).size.width - 20,
                child: Image.file(_image),
              ),
      ),
    );
  }

  FloatingActionButton scanAction() {
    return FloatingActionButton(
       heroTag: "n",
      onPressed: () => getText(),
      child: Icon(Icons.search),
      tooltip: "Scan",
      backgroundColor: Colors.green,
    );
  }

  Container bootomButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton.extended(
             heroTag: "xvd",
            onPressed: () => getImage(ImageSource.camera),
            label: const Text('Camera'),
            icon: const Icon(Icons.camera),
            backgroundColor: Colors.blue,
          ),
          // if (_image.path.isNotEmpty)
          //   FloatingActionButton(
          //     onPressed: () => getImage(ImageSource.gallery),
          //     child: const Icon(Icons.clear),
          //     backgroundColor: Colors.red,
          //   ),
          FloatingActionButton.extended(
            heroTag: "no",
            onPressed: () => getImage(ImageSource.gallery),
            label: const Text('Gallery'),
            icon: const Icon(Icons.photo_album),
            backgroundColor: Colors.blue,
          ),
          // ElevatedButton(
          //     onPressed: () => {getText()}, child: Text("Convert To Text")),
        ],
      ),
    );
  }
}
