import 'package:movieapp/models/detailsmovie.dart';

abstract class MovieDetailsState {}

class InitialMovieDetailsState extends MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsSucessState extends MovieDetailsState {}

class MovieDetailsErrorState extends MovieDetailsState {}

class CreateDataBaseState extends MovieDetailsState {}

class GetDataBaseState extends MovieDetailsState {}

class InsertDataBaseState extends MovieDetailsState {}

class LoadingDataBaseState extends MovieDetailsState {}

class UpdateDataBaseState extends MovieDetailsState {}

class DeleteDataBaseState extends MovieDetailsState {}
