import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileWriter {
  Future<void> writeJsonToFile(List<Map<String, dynamic>> dataList, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName.json');

      String jsonString = jsonEncode(dataList);

      await file.writeAsString(jsonString);
    } catch (e) {
      print("Error writing to file: $e");
    }
  }
}
