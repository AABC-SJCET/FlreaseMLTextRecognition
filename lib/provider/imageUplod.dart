import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

var resText = "Text From Image";

Future<String> upload(File imageFile) async {
  // open a bytestream
  try {
    var stream = new http.ByteStream(Stream.castFrom(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://handwrittenchar.herokuapp.com/predict");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    if (response.statusCode == 200) {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        resText = value;
      });
      return resText;
    } else {
      throw ("An error occured");
    }
  } catch (e) {
    print(e);
    throw e;
  }
}

String getTextRes() {
  return resText;
}
