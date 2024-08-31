import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileReader {
  Future<List<Map<String, dynamic>>> readJsonFromFile(String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName.json');

      if (await file.exists()) {
        String jsonString = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(jsonString);
        return List<Map<String, dynamic>>.from(jsonData);
      } else {
        print("File does not exist");
        return [];
      }
    } catch (e) {
      print("Error reading from file: $e");
      return [];
    }
  }
}
