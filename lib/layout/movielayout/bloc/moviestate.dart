import 'package:movieapp/models/detailsmovie.dart';
import 'package:movieapp/modules/details/Details.dart';

abstract class MovieState{}
class InitialMovieState extends MovieState{}
class ChangeBottomNavState extends MovieState{}
class MoviePopularLoadingState extends MovieState{}
class MoviePopularSucessState extends MovieState{}
class MoviePopularErrorState extends MovieState{}
class MovieTopRatedLoadingState extends MovieState{}
class MovieTopRatedSucessState extends MovieState{}
class MovieTopRatedErrorState extends MovieState{}
class MovieUnComingLoadingState extends MovieState{}
class MovieUnComingSucessState extends MovieState{}
class MovieUnComingErrorState extends MovieState{}
