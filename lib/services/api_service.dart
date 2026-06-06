import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

class ApiService {
  static const String _baseUrl = 'https://www.arbeitnow.com/api/job-board-api';

  Future<List<JobModel>> fetchJobs() async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jobList = jsonResponse['data'] ?? [];
        return jobList.map((job) => JobModel.fromJson(job)).toList();
      } else {
        throw HttpException('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw const SocketException('No Internet Connection. Please check your network.');
    } on TimeoutException {
      throw TimeoutException('Connection timed out. Please try again.');
    } on FormatException {
      throw const FormatException('Bad response format from server.');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
