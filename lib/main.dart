import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/shared/network/remote/blocobserver.dart';
import 'package:movieapp/shared/network/remote/diohelper.dart';
import 'layout/movielayout/bloc/moviecubit.dart';
import 'layout/movielayout/bloc/moviestate.dart';
import 'layout/movielayout/movielayout.dart';
import 'modules/details/bloc/detailscubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.int();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesCubit()
            ..getmoviepopular()
            ..getmovietoprated()
            ..getmovieuncoming(),
        ),
        BlocProvider(
            create: (context) => MoviesDetailsCubit()..createdatabase()),
      ],
      child: BlocConsumer<MoviesCubit, MovieState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: MovieLayout(),
            );
          }),
    );
  }
}
