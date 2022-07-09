import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:lostsapp/constants/env.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class AddnUpdateRepository {
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<String?> postAnItem(Map<String, dynamic> values, String token) async {
    print(values);
    http.Response response;
    if (values["imageFile"] == null) {
      try {
        response = await http.post(
          Uri.parse(ENDPOINT + "/items/noImage"),
          headers: {
            "Authorization": 'bare $token',
            'Content-Type': "application/json"
          },
          body: jsonEncode({
            "title": values["title"] as String,
            "description": values["description"] as String,
            "found": values["found"] as String,
            "governorate": values["governorate"] as String,
            "category": values["category"] as String,
            'dateOfLoose': values["dateOfLoose"] as String,
          }),
        );
      } catch (e) {
        print("error");
        print(e);
        return null;
      }
      if (response.statusCode == 201) {
        return "success";
      } else {
        return null;
      }
    } else {
      try {
        XFile f = values["imageFile"] as XFile;
        final mimeTypeData = lookupMimeType(f.path)!.split("/");
        var imageUploadRequest =
            http.MultipartRequest("POST", Uri.parse(ENDPOINT + '/items'));
        imageUploadRequest.headers["Content-Type"] = "multipart/form-data";
        imageUploadRequest.headers["Authorization"] = 'barer $token';

        imageUploadRequest.fields.addAll({
          'title': values["title"] as String,
          'description': values["description"] as String,
          'found': values["found"] as String,
          'dateOfLoose': values["dateOfLoose"] as String,
          'governorate': values["governorate"] as String,
          'category': values["category"] as String
        });
        imageUploadRequest.files.add(await http.MultipartFile.fromPath(
            'itemImage', f.path,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
        http.StreamedResponse rr = await imageUploadRequest.send();
        if (rr.statusCode == 200 || rr.statusCode == 201) {
          print(await rr.stream.bytesToString());
          return "success";
        } else {
          print(rr.reasonPhrase);
          return null;
        }
      } catch (e) {
        print("error :" + e.toString());
        return null;
      }
    }
  }

  Future<void> testing() async {
    File f = await getImageFileFromAssets('demo.png');
    final mimeTypeData = lookupMimeType(f.path)!.split("/");
    var imageUploadRequest =
        http.MultipartRequest("POST", Uri.parse(ENDPOINT + '/items'));
    imageUploadRequest.headers["Content-Type"] = "multipart/form-data";
    //imageUploadRequest.headers["enctype"] = "multipart/form-data";
    imageUploadRequest.fields.addAll({
      'title': 'a',
      'description': 'a',
      'found': '1',
      'governorate': 'HOMS',
      'category': 'A'
    });

    imageUploadRequest.headers["Authorization"] =
        "beaer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImVsaWVhdHRAYWFhYWF0LmNvbSIsIl9pZCI6IjYyYjQ4NjYyZGZhYTc4N2Y1Y2RjN2FiNyIsInBob25lTnVtYmVyIjoiKzk2MzkzMjg1MTgwNiIsImlhdCI6MTY1NjY2OTcxNywiZXhwIjoxNjU2ODQyNTE3fQ.tOGr-2pCvCxPPUJkg5uRQLyg1KQZ46YyZ1kVCZLOq8o";

    imageUploadRequest.files.add(await http.MultipartFile.fromPath(
        'itemImage', f.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
    print(f.path);
    /* var e = await File.fromUri(Uri.parse(f.path)).readAsBytes();
    print("e length is ");
    print(e.length); */
    http.StreamedResponse rr = await imageUploadRequest.send();
    if (rr.statusCode == 200) {
      print(await rr.stream.bytesToString());
    } else {
      print(rr.reasonPhrase);
    }
    //http.MultipartFile("itemImage",await File.f)
  }
}
