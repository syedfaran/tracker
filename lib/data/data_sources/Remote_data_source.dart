import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/data/model/job_list_model.dart';
import 'package:flutter_app/helper/app_String.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_Repo.dart';
import 'package:http/http.dart' as http;
//abstract todo

class RemoteDataSource{
  static const jobListApi = AppApiString.listOfJobs;
   Future<List<JobListModel>>getListOfJobs()async{
    try{
      http.Response response = await http.get(Uri.parse(jobListApi),headers: {'Content-type': 'application/json'});
      final List parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map((json) => JobListModel.fromJson(json)).toList();
    }on SocketException {
      throw Failure('No Internet connection');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } on TimeoutException{
      throw Failure("Time Out Exception");
    }
  }
}