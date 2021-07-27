import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/job_list_model.dart';
import 'package:flutter_app/data/repository/Repo.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_Repo.dart';
import 'package:flutter_app/proFirebase/firebaseAuth_provider.dart';

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
  void setJobList()async{
    _setState(NotifierState.loading);
    await _repo.getListOfJobs().then((value) => _setJob(value));
    _setState(NotifierState.loaded);
  }
}