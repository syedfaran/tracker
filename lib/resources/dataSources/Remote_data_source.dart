import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/model/JobListModel.dart';
import 'package:flutter_app/ui/appUtil/appString.dart';
import 'package:flutter_app/resources/repository/firebaseAuth_Repo.dart';
import 'package:http/http.dart' as http;

abstract class AbstractRemoteDataSource {
  Future getListOfJobs();
}

class RemoteDataSource implements AbstractRemoteDataSource{

  @override
  Future<List<JobListModel>>getListOfJobs()async{
    try{
      http.Response response = await http.get(Uri.parse(AppApiString.listOfJobs),headers: {'Content-type': 'application/json'});
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