import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wisata_lamongan/api/listwisata.dart';

class RepositoryWisata {
  final baseUrl = 'http://172.23.80.1:8000/api/wisata';

  Future<List<Destinasi>> getData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<dynamic> data = json['data'];
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        List<Destinasi> destinasiList =
            dataList.map((item) => Destinasi.fromJson(item)).toList();
        return destinasiList;
      }
    } catch (e) {
      print(e.toString());
    }

    return []; // Return an empty list if an error occurs
  }

  String getImageUrl(String filename) {
    return Uri.parse('http://172.23.80.1:8000/api/file/$filename')
        .toString(); // Include the base URL when constructing the image URL
  }
}

class RepositoryReligi {
  final baseUrl = 'http://172.23.80.1:8000/api/religi';

  Future<List<Destinasi>> getData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<dynamic> data = json['data'];
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        List<Destinasi> destinasiList =
            dataList.map((item) => Destinasi.fromJson(item)).toList();
        return destinasiList;
      }
    } catch (e) {
      print(e.toString());
    }

    return []; // Return an empty list if an error occurs
  }

  String getImageUrl(String filename) {
    return Uri.parse('http://172.23.80.1:8000/api/file/$filename')
        .toString(); // Include the base URL when constructing the image URL
  }
}

class RepositoryAlam {
  final baseUrl = 'http://172.23.80.1:8000/api/alam';

  Future<List<Destinasi>> getData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<dynamic> data = json['data'];
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        List<Destinasi> destinasiList =
            dataList.map((item) => Destinasi.fromJson(item)).toList();
        return destinasiList;
      }
    } catch (e) {
      print(e.toString());
    }

    return []; // Return an empty list if an error occurs
  }

  String getImageUrl(String filename) {
    return Uri.parse('http://172.23.80.1:8000/api/file/$filename')
        .toString(); // Include the base URL when constructing the image URL
  }
}

class RepositoryUmkm {
  final baseUrl = 'http://172.23.80.1:8000/api/umkm';

  Future<List<Destinasi>> getData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<dynamic> data = json['data'];
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        List<Destinasi> destinasiList =
            dataList.map((item) => Destinasi.fromJson(item)).toList();
        return destinasiList;
      }
    } catch (e) {
      print(e.toString());
    }

    return []; // Return an empty list if an error occurs
  }

  String getImageUrl(String filename) {
    return Uri.parse('http://172.23.80.1:8000/api/file/$filename')
        .toString(); // Include the base URL when constructing the image URL
  }
}
