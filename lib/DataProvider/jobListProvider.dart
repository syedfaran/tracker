import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/DataProvider/firebaseAuthProvider.dart';
import 'package:flutter_app/model/jobListModel.dart';
import 'package:flutter_app/resources/repository/Repo.dart';
import 'package:flutter_app/resources/repository/firebaseAuth_Repo.dart';

class JobListProvider with ChangeNotifier {
  JobListProvider(){
    setJobList();
  }
  final _repo = Repository();
  Either<Failure, List<JobListModel>>? _jobList;
  Either<Failure, List<JobListModel>> get jobList=>_jobList!;
  NotifierState _state = NotifierState.loading;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void _setJob(Either<Failure, List<JobListModel>> job){

    _jobList = job;
    notifyListeners();
  }
  Future<void> setJobList()async{
    _setState(NotifierState.loading);
    await _repo.getListOfJobs().then((value) => _setJob(value));
    _setState(NotifierState.loaded);
  }
}