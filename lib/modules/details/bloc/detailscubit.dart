import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/models/detailsmovie.dart';
import 'package:movieapp/models/videos.dart';
import 'package:movieapp/shared/components/constraint.dart';
import 'package:movieapp/shared/network/local/entrypoint.dart';
import 'package:movieapp/shared/network/remote/diohelper.dart';
import 'package:sqflite/sqflite.dart';

import 'detailsState.dart';

class MoviesDetailsCubit extends Cubit<MovieDetailsState> {
  MoviesDetailsCubit() : super(InitialMovieDetailsState());

  static MoviesDetailsCubit get(context) => BlocProvider.of(context);

  videoModel video;
 Future getvideo({ int movieId})async {
emit( MovieDetailsLoadingState());
     await DioHelper.getMovies(method:"movie/$movieId/videos?api_key=$ApiKey",
    ).then((value) {

      video = videoModel.fromJson(value.data);
      print(video.tailer.map((e) => e.key).toList());

      emit(MovieDetailsSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(MovieDetailsErrorState());
    });
  }


  Database database;
  List<Map<String, dynamic>> newtasks = [];
  void createdatabase() {
    openDatabase('Amr.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE Tasks(id INTEGER , image TEXT, title TEXT,vote Double)')
          .then((value) => print('table is created'))
          .catchError((onError) {
        print('error is:${onError.toString()}');
      });
    }, onOpen: (database) {
      getTasks(database);
    }).then((value) {
      database = value;
      print(database);
      emit(CreateDataBaseState());
    });
  } // create and open databse//

 Future insertToDatabase({
    @required int id,
    @required String image,
    @required String title,
    @required double vote,
  }) async {

    await database.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO Tasks(id  , image , title ,vote ) VALUES("$id", "$image", "$title", "$vote")',
      )
          .then((value) {
        print('$value inserted successfully');
        getTasks(database);
        emit(InsertDataBaseState());

      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return null;
    });
  }

  void getTasks(database) {
    emit(LoadingDataBaseState());
    database.rawQuery('SELECT * FROM Tasks').then((value) {
      newtasks = value;
      print(newtasks);

      emit(GetDataBaseState());
    });
  }

  void delete({@required int id}) {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getTasks(database);
      emit(DeleteDataBaseState());
    });
  }
}
