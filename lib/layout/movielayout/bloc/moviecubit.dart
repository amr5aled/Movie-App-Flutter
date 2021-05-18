import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/layout/movielayout/bloc/moviestate.dart';
import 'package:movieapp/models/moviemodel.dart';
import 'package:movieapp/modules/Favourite/favourite.dart';
import 'package:movieapp/modules/popular/popularmovies.dart';
import 'package:movieapp/modules/toprated/ratedmovies.dart';
import 'package:movieapp/modules/uncoming/uncomingmovies.dart';
import 'package:movieapp/shared/components/constraint.dart';
import 'package:movieapp/shared/network/local/entrypoint.dart';
import 'package:movieapp/shared/network/remote/diohelper.dart';

class MoviesCubit extends Cubit<MovieState> {
  MoviesCubit() : super(InitialMovieState());
  static MoviesCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<String> models = [
    'PopularMovie',
    'TopRatedMovie',
    'upcomingMovie',
    'FavouriteMovie'
  ];
  List<Widget> screens = [
    PopularMovies(),
    TopRatedMovies(),
    UnComingMovies(),
    FavouriteMovies(),
  ];
  List<BottomNavigationBarItem> Modules = [
    BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Popular'),
    BottomNavigationBarItem(
        icon: Icon(Icons.movie_filter_outlined), label: 'TopRated'),
    BottomNavigationBarItem(icon: Icon(Icons.move_to_inbox), label: 'Uncoming'),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border), label: 'Favourite'),
  ];
  void changeBotomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
    if(index==0)getmoviepopular();
    if(index==1)getmovietoprated();
    if(index==2)getmovieuncoming();
  }

  MoviesModel popularmovies;
  void getmoviepopular() {
    emit(MoviePopularLoadingState());
    DioHelper.getMovies(method: moviePopular, query: {
      'api_key': ApiKey,
    }).then((value) {
      popularmovies = MoviesModel.fromJson(value.data);

      emit(MoviePopularSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(MoviePopularErrorState());
    });
  }

  MoviesModel topratedmovies;
  void getmovietoprated() {
    emit(MovieTopRatedLoadingState());
    DioHelper.getMovies(method: movierated, query: {
      'api_key': ApiKey,
    }).then((value) {
      topratedmovies = MoviesModel.fromJson(value.data);
      // print(value.data);
      emit(MovieTopRatedSucessState());
    }).catchError((error) {
      emit(MovieTopRatedErrorState());
    });
  }

  MoviesModel uncomingmovies;
  void getmovieuncoming() {

    emit(MovieUnComingLoadingState());
    DioHelper.getMovies(method: movieComing, query: {
      'api_key': ApiKey,
    }).then((value) {
      uncomingmovies = MoviesModel.fromJson(value.data);
      // print(value.data);
      emit(MovieUnComingSucessState());
    }).catchError((error) {
      emit(MovieUnComingErrorState());
    });
  }


}
