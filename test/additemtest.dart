import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lostsapp/constants/env.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

void main() async {
  File f = await getImageFileFromAssets('demo.png');
  final mimeTypeData = lookupMimeType(f.path)!.split("/");
  var imageUploadRequest =
      http.MultipartRequest("POST", Uri.parse(ENDPOINT + '/items'));
  imageUploadRequest.fields['title'] = 'blah';
  imageUploadRequest.fields['description'] = 'blahdesc';
  imageUploadRequest.fields['found'] = '1';
  imageUploadRequest.fields['governorate'] = 'hh';
  imageUploadRequest.fields['category'] = 'blah';

  imageUploadRequest.headers["Authorization"] =
      "beaer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImVsaWVhdHRAYWFhYWF0LmNvbSIsIl9pZCI6IjYyYjQ4NjYyZGZhYTc4N2Y1Y2RjN2FiNyIsInBob25lTnVtYmVyIjoiKzk2MzkzMjg1MTgwNiIsImlhdCI6MTY1NjY2OTcxNywiZXhwIjoxNjU2ODQyNTE3fQ.tOGr-2pCvCxPPUJkg5uRQLyg1KQZ46YyZ1kVCZLOq8o";
  imageUploadRequest.files.add(http.MultipartFile.fromBytes(
      'itemImage', await File.fromUri(Uri.parse(f.path)).readAsBytes(),
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
  imageUploadRequest.send().then((value) => print(value));
}
