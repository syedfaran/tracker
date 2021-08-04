
import 'package:dartz/dartz.dart';
import 'package:flutter_app/model/JobListModel.dart';
import 'package:flutter_app/resources/dataSources/RemoteDataSource.dart';
import 'package:flutter_app/resources/repository/FirebaseAuthRepo.dart';


//generic OverView
abstract class _AbstractRepository {
  Future<Either<Failure, List<JobListModel>>> getListOfJobs();
}

class Repository implements _AbstractRepository {
  final RemoteDataSource _repo = RemoteDataSource();

  @override
  Future<Either<Failure, List<JobListModel>>> getListOfJobs() {
    return Task(() => _repo.getListOfJobs())
        .attempt()
        .map(
          // Grab only the *left* side of Either<Object, Post>
          (either) => either.leftMap((obj) {
            // Cast the Object into a Failure
            return obj as Failure;
          }),
        )
        .run();
  }
}
