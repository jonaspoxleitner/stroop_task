import 'dart:convert';
import 'dart:io';
import 'package:dart_console/dart_console.dart';
import 'package:http_server/http_server.dart';

final console = Console();

final targetFile = File('web/index.html');

Future main() async {
  console.writeLine('Starting Stroop Task Server...');

  var server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    4040,
  );

  console.setForegroundColor(ConsoleColor.yellow);
  console.writeLine('The server is now listening for requests.');
  console.resetColorAttributes();
  console.writeLine('Press Ctrl+C to exit.');

  await for (HttpRequest request in server) {
    handleRequest(request);
  }
}

void handleRequest(HttpRequest request) async {
  var staticFiles = VirtualDirectory('.');
  var postContentType = request.headers.contentType;

  try {
    if (request.method == 'GET') {
      // serve web directory
      var uri = request.uri.toString();

      if (uri == '/') {
        staticFiles.serveFile(targetFile, request);
      } else {
        staticFiles.serveFile(File('web' + uri), request);
      }
    } else if (request.method == 'POST' &&
        postContentType?.mimeType == 'application/json') {
      // save data
      var content = await utf8.decoder.bind(request).join();
      var data = jsonDecode(content) as Map<String, dynamic>;

      saveFile(data['filename'], data['filedata']);

      await request.response.close();
    } else {
      request.response.write('Something went wrong.');
    }
  } catch (e) {
    console.writeLine('Exception in handleRequest: $e');
  }

  console.writeLine('Request handled.');
}

void saveFile(String fileName, String content) {
  var file = File('data/' + fileName);
  if (!file.existsSync()) {
    File('data/' + fileName)
      ..createSync()
      ..writeAsStringSync(content);
    console.writeLine('File: A new File was saved.');
  } else {
    console.writeLine('File: This file already exits.');
  }
}
